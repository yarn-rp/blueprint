/* eslint-disable require-jsdoc */
import { Firestore } from "firebase-admin/firestore";
import { inject, injectable } from "tsyringe";
import { PlatformId } from "../../../domain/entities/platform.enum";
import { RemoteRepository } from "../../../domain/repositories/factories/impl/remote.repository";
import { RemoteRepositoryFactory } from "../../../domain/repositories/factories/remote.repository.factory";
import { AsanaRemoteRepository } from "../../services/asana.service";
import { GithubRemoteRepository } from "../../services/github.service";
import { JiraRemoteRepository } from "../../services/jira.service";

@injectable()
export class FirestoreRemoteRepositoryFactory implements RemoteRepositoryFactory {
  constructor(@inject("firestore") private readonly firestore: Firestore) {}

  buildFor(platform: PlatformId): RemoteRepository {
    switch (platform) {
      case PlatformId.Jira:
        return new JiraRemoteRepository(this.firestore);
      case PlatformId.Asana:
        return new AsanaRemoteRepository(this.firestore);
      case PlatformId.Github:
        return new GithubRemoteRepository(this.firestore);
    }
  }
}
