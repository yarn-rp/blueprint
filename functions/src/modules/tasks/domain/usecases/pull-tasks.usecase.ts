import { inject, injectable } from "tsyringe";
import { RefreshToken } from "../../../authenticators/domain/usecases/refresh-token.usecase";
import { Task } from "../entities";
import { PlatformId } from "../entities/platform.enum";
import { RemoteRepositoryFactory } from "../repositories/factories/remote.repository.factory";
import { TasksRepository } from "../repositories/tasks.repository";

@injectable()
export class PullTasks {
  constructor(
    @inject("TasksRepository") private readonly tasksRepo: TasksRepository,
    @inject("RemoteRepositoryFactory")
    private readonly remoteFactory: RemoteRepositoryFactory,
    private readonly refreshToken: RefreshToken,
  ) {}

  async execute(platform: PlatformId, uid: string, authenticatorId: string): Promise<void> {
    console.log("Pulling tasks for platform: ", platform);
    const remoteRepo = this.remoteFactory.buildFor(platform);
    const newAccess = await this.refreshToken.execute(uid, authenticatorId);
    if (newAccess.status === "requires_reauth") {
      console.error("Authenticator requires re-authentication");
      return;
    }

    const oldTasks = await this.tasksRepo.fetchFromAuthenticator(uid, authenticatorId);
    const tasks: Task[] = await remoteRepo.pull(uid, authenticatorId, undefined);

    // get new and updated tasks to add to the local repository
    const newTasks = tasks.filter((task) => !oldTasks.some((oldTask) => oldTask.taskId === task.taskId));
    const updatedTasks = tasks
      .filter((task) => oldTasks.some((oldTask) => oldTask.taskId === task.taskId))
      .map((task) => {
        const oldTask = oldTasks.find((oldTask) => oldTask.taskId === task.taskId) as Task;
        return { ...oldTask, ...task, isCompleted: oldTask.isCompleted || task.isCompleted };
      });

    const tasksToKeep = [...newTasks, ...updatedTasks];

    // get events to remove from the local repository
    const tasksToRemove = oldTasks.filter((oldTask) => !tasks.some((task) => task.taskId === oldTask.taskId));
    console.log({ eventsToRemove: tasksToRemove });

    await this.tasksRepo.add(tasksToKeep, uid);
    await this.tasksRepo.remove(tasksToRemove, uid);
  }
}
