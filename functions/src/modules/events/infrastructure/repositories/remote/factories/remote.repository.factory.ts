import { Firestore } from "firebase-admin/firestore";
import { inject, injectable } from "tsyringe";
import { PlatformId } from "../../../../domain/entities";
import { EventRemoteRepository } from "../../../../domain/repositories/remote/event.remote.repository";
import { EventRemoteRepositoryFactory } from "../../../../domain/repositories/remote/event.remote.repository.factory";
import { GoogleCalendarEventRemoteRepository } from "../google-calendar.event.remote.repository";
import { GoogleCalendarMapper } from "../mappers/google-calendar.mapper";

@injectable()
export class FirestoreEventRemoteRepositoryFactory implements EventRemoteRepositoryFactory {
  constructor(@inject("firestore") private readonly firestore: Firestore) {}

  buildFor(platform: PlatformId): EventRemoteRepository {
    switch (platform) {
      case PlatformId.GoogleCalendar:
        return new GoogleCalendarEventRemoteRepository(this.firestore, new GoogleCalendarMapper());
    }
  }
}
