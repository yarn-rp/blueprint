import { injectable } from "tsyringe";
import * as functions from "firebase-functions";
import { UpdateBlueprintEventUseCase } from "../../domain/usecases/update-blueprint-event.usecase";
import { UpdateBlueprintTaskUseCase } from "../../domain/usecases/update-blueprint-task.usecase";
import { Event } from "../../../events/domain/entities/event.entity";
import { Task } from "../../../tasks/domain/entities/task.entity";

type UpdateBlueprintContext = {
  uid: string;
};

@injectable()
export class UpdateBlueprintController {
  constructor(
    public updateBlueprintEventUseCase: UpdateBlueprintEventUseCase,
    public updateBlueprintTaskUseCase: UpdateBlueprintTaskUseCase,
  ) {}

  async execute(
    change: functions.firestore.QueryDocumentSnapshot,
    context: functions.EventContext<UpdateBlueprintContext>,
  ): Promise<void> {
    const { uid } = context.params;
    const data = change.data();
    console.log("update blueprint for data:", data);

    const { taskId } = data;
    const isTask = !!taskId;

    console.log("is task", isTask);

    isTask
      ? await this.updateBlueprintTaskUseCase.execute(data as Task, uid)
      : await this.updateBlueprintEventUseCase.execute(data as Event, uid);
  }
}
