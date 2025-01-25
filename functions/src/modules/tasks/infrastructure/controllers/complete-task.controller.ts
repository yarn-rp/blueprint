import { injectable } from "tsyringe";
import * as functions from "firebase-functions";
import { CompleteTask } from "../../domain/usecases/complete-task.usecase";

/**
 * Controller for completing a task.
 */
@injectable()
export class CompleteTaskController {
  constructor(public complete: CompleteTask) {}

  async execute(data: { taskId: string }, context: functions.https.CallableContext) {
    const uid = context.auth?.uid;
    if (!uid) {
      throw new functions.https.HttpsError("unauthenticated", "This method requires an authorized user");
    }

    await this.complete.execute(data.taskId, uid);
  }
}
