import { inject, injectable } from "tsyringe";
import { TasksRepository } from "../repositories/tasks.repository";

@injectable()
export class CompleteTask {
  constructor(@inject("TasksRepository") private readonly tasksRepo: TasksRepository) {}

  async execute(taskId: string, uid: string): Promise<void> {
    const task = await this.tasksRepo.get(taskId, uid);
    if (!task) {
      console.error(`Task ${taskId} not found for user ${uid}`);
      return;
    }
    task.isCompleted = true;
    await this.tasksRepo.save(task, uid);
  }
}
