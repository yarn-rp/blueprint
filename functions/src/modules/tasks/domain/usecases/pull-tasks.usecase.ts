import { inject, injectable } from "tsyringe";
import { RefreshToken } from "../../../authenticators/domain/usecases/refresh-token.usecase";
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
    console.log(`Pulling tasks for ${platform} ${uid} ${authenticatorId}`);
    const remoteRepo = this.remoteFactory.buildFor(platform);

    const lastTaskOrNone = await this.tasksRepo.fetchLastFromPlatform(platform, uid);

    await this.refreshToken.execute(uid, authenticatorId);
    const tasks = await remoteRepo.pull(uid, authenticatorId, lastTaskOrNone);

    await this.tasksRepo.add(tasks, uid);
  }
}
