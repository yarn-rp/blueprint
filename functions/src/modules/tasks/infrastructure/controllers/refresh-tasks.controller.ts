import { Firestore } from "firebase-admin/firestore";
import { inject, injectable } from "tsyringe";
import { AuthenticatorType } from "../../../authenticators/domain/entities";
import { PullTasks } from "../../domain/usecases/pull-tasks.usecase";

@injectable()
export class RefreshTasksController {
  constructor(
    public pull: PullTasks,
    // TODO: dont rely on raw firestore and make a service for it
    @inject("firestore") private readonly firestore: Firestore,
  ) {}

  async execute() {
    const usersDoc = await this.firestore.collection("users").get();
    // get authenticators for every user
    for (const user of usersDoc.docs) {
      console.log(`Refreshing tasks for user ${user.id}`);

      const authenticatorsDoc = await this.firestore
        .collection("users")
        .doc(user.id)
        .collection("authenticators")
        .get();

      const authenticators = authenticatorsDoc.docs
        .map((doc) => doc.data())
        .filter((authenticator) => authenticator.type == AuthenticatorType.Task);

      console.log(
        "\tRefreshing for authenticators",
        authenticators.map((a) => a.platformName),
      );

      // get tasks for every authenticator
      const userPromises = authenticatorsDoc.docs
        .filter((authenticator) => authenticator.data().type == AuthenticatorType.Task)
        .map((authenticator) => this.pull.execute(authenticator.data().platformName, user.id, authenticator.id));
      // execute all for the user
      const results = await Promise.allSettled(userPromises);

      // log errors
      results.forEach((result) => {
        if (result.status == "rejected") {
          const userData = user.data();
          console.error(`Error fetching new events for user ${userData.id} for reason: result.reason`);
        }
      });
      console.log(`Refreshed tasks for user ${user.id}`);
    }
  }
}
