import { inject, injectable } from "tsyringe";
import { BlueprintLocalRepository } from "../../../blueprint/domain/repositories/blueprint.local.repository";
import { TasksRepository } from "../repositories/tasks.repository";

@injectable()
export class CompleteTask {
  constructor(
    @inject("TasksRepository") private readonly tasksRepo: TasksRepository,
    @inject("BlueprintLocalRepository") private readonly blueprintRepo: BlueprintLocalRepository,
  ) {}

  async execute(taskId: string, uid: string): Promise<void> {
    const task = await this.tasksRepo.get(taskId, uid);
    if (!task || task.isCompleted) {
      return;
    }
    task.isCompleted = true;
    await this.tasksRepo.save(task, uid);

    // TODO: check if this works
    await this.blueprintRepo.deleteTasks([task], uid);
  }
}
