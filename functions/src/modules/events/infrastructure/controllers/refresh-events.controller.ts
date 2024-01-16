import { Firestore } from "firebase-admin/firestore";
import { inject, injectable } from "tsyringe";
import { AuthenticatorType } from "../../../authenticators/domain/entities";
import { PullEventsUseCase } from "../../domain/usecases/pull-events.usecase";

// TODO: this is an ugly copy paste of refresh-tasks.controller.ts, please refactor
@injectable()
export class RefreshEventsController {
  constructor(
    public pull: PullEventsUseCase,
    // TODO: dont rely on raw firestore and make a service for it
    @inject("firestore") private readonly firestore: Firestore,
  ) {}

  async execute() {
    const usersDoc = await this.firestore.collection("users").get();
    // get authenticators for every user
    for (const user of usersDoc.docs) {
      console.log(`Refreshing events for user ${user.id}`);

      const authenticatorsDoc = await this.firestore
        .collection("users")
        .doc(user.id)
        .collection("authenticators")
        .get();

      // get tasks for every authenticator
      const userPromises = authenticatorsDoc.docs
        .filter((authenticator) => authenticator.data().type == AuthenticatorType.Event)
        .map((authenticator) => this.pull.execute(authenticator.data().platformName, user.id, authenticator.id));
      // execute all for the user
      await Promise.all(userPromises);

      console.log(`Refreshed events for user ${user.id}`);
    }
  }
}
