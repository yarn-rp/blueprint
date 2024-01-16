import { injectable } from "tsyringe";
import * as functions from "firebase-functions";
import { Event } from "../../../events/domain/entities/event.entity";
import { CreateBlueprintEventUseCase } from "../../domain/usecases/create-blueprint-event.usecase";

type UpdateBlueprintContext = {
  uid: string;
};

@injectable()
export class CreateBlueprintItemController {
  constructor(public createBlueprintEventUseCase: CreateBlueprintEventUseCase) {}

  async execute(
    change: functions.firestore.QueryDocumentSnapshot,
    context: functions.EventContext<UpdateBlueprintContext>,
  ): Promise<void> {
    const { uid } = context.params;
    const data = change.data();

    return this.createBlueprintEventUseCase.execute(data as Event, uid);
  }
}
