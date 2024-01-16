import { injectable } from "tsyringe";
import * as functions from "firebase-functions";
import { Event } from "../../../events/domain/entities/event.entity";
import { DeleteBlueprintEventUseCase } from "../../domain/usecases/delete-blueprint-event.usecase";

type UpdateBlueprintContext = {
  uid: string;
};

@injectable()
export class DeleteBlueprintItemController {
  constructor(public deleteBlueprintEventUseCase: DeleteBlueprintEventUseCase) {}

  async execute(
    change: functions.firestore.QueryDocumentSnapshot,
    context: functions.EventContext<UpdateBlueprintContext>,
  ): Promise<void> {
    const { uid } = context.params;
    const data = change.data();

    return this.deleteBlueprintEventUseCase.execute(data as Event, uid);
  }
}
