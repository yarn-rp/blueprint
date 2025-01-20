/* eslint-disable require-jsdoc */
import { Firestore } from "firebase-admin/firestore";
import { inject, injectable } from "tsyringe";
import { PlatformId } from "../../domain/entities/platform.enum";
import { Task } from "../../domain/entities/task.entity";
import { TasksRepository } from "../../domain/repositories/tasks.repository";
import { taskConverter } from "./converters/task-converter";

@injectable()
export class FirestoreTasksRepository implements TasksRepository {
  constructor(@inject("firestore") private readonly firestore: Firestore) {}

  async get(taskId: string, uid: string): Promise<Task | undefined> {
    const task = await this.firestore
      .collection("users")
      .doc(uid)
      .collection("tasks")
      .doc(taskId)
      .withConverter(taskConverter)
      .get();

    return task.data();
  }

  async save(task: Task, uid: string): Promise<void> {
    await this.add([task], uid);
  }

  async add(tasks: Task[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    tasks.forEach((task) => {
      const docId = `${task.access.platformId}-${task.project.platformId || "no_project"}-${task.taskId}`;

      const taskRef = this.firestore
        .collection("users")
        .doc(uid)
        .collection("tasks")
        .withConverter(taskConverter)
        .doc(docId);
      batch.set(taskRef, task);
    });

    await batch.commit();
  }

  async fetchLastFromPlatform(platform: PlatformId, uid: string): Promise<Task | undefined> {
    const taskQuerySnapshot = await this.firestore
      .collection("users")
      .doc(uid)
      .collection("tasks")
      .withConverter(taskConverter)
      .where("platform", "==", platform)
      .orderBy("createdAt", "desc")
      .limit(1)
      .get();

    const taskOrUndefined = !taskQuerySnapshot.empty ? (taskQuerySnapshot.docs[0] as unknown as Task) : undefined;
    return taskOrUndefined;
  }
}
