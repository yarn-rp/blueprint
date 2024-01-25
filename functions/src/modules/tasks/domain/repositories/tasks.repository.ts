import { PlatformId } from "../entities/platform.enum";
import { Task } from "../entities/task.entity";

export interface TasksRepository {
  add(tasks: Task[], uid: string): Promise<void>;
  fetchLastFromPlatform(platform: PlatformId, uid: string): Promise<Task | undefined>;
}
