/* eslint-disable require-jsdoc */
import { Firestore } from "firebase-admin/firestore";
import { Task } from "../../../domain/entities/task.entity";
import { RemoteRepository } from "../../../domain/repositories/factories/impl/remote.repository";
import { Access, AccessPublicData } from "../../../../authenticators/domain/entities";

export abstract class AbstractRemoteRepository<RemoteTask> implements RemoteRepository {
  constructor(private readonly firestore: Firestore) {}

  async getAccess(uid: string, authenticatorId: string): Promise<Access> {
    const accessFirestoreDoc = await this.firestore
      .collection("users")
      .doc(uid)
      .collection("authenticators")
      .doc(authenticatorId)
      .get();

    const data = await accessFirestoreDoc.data();
    return data as Access;
  }

  abstract getTasks(accessToken: string): Promise<RemoteTask[]>;

  abstract mapper(remoteTask: RemoteTask, accessData: AccessPublicData): Task;

  async pull(uid: string, authenticatorId: string, lastPulledTask?: Task): Promise<Task[]> {
    const access = await this.getAccess(uid, authenticatorId);
    const nativeTasks = await this.getTasks(access.accessToken);

    const mapperFunction = (remoteTask: RemoteTask) =>
      this.mapper(remoteTask, {
        platformId: access.platformId,
        user: access.user,
      });

    return nativeTasks.map(mapperFunction);
  }
}
