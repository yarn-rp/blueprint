/* eslint-disable require-jsdoc */
import { inject, injectable } from "tsyringe";
import { RefreshToken } from "../../../authenticators/domain/usecases/refresh-token.usecase";
import { Event, PlatformId } from "../entities";
import { EventLocalRepository } from "../repositories/local/event.local.repository";
import { EventRemoteRepositoryFactory } from "../repositories/remote/event.remote.repository.factory";

/**
 * Use case for pulling events from a remote repository and adding
 * them to the local repository.
 */
@injectable()
export class PullEventsUseCase {
  /**
   * Creates a new instance of the PullEvents use case.
   * @param  eventRepository - The local event repository
   * to add events to.
   * @param  remoteFactory - The factory
   * for creating remote event repositories.
   */
  constructor(
    @inject("EventLocalRepository") private readonly eventRepository: EventLocalRepository,

    @inject("EventRemoteRepositoryFactory")
    private readonly remoteFactory: EventRemoteRepositoryFactory,
    private readonly refreshToken: RefreshToken,
  ) {}

  /**
   * Executes the use case by pulling events from the remote
   * repository and adding them to the local repository.
   * @param platform - The platform to pull
   * events from.
   * @param uid - The user ID to associate
   * with the events.
   * @param authenticatorId - The authenticator ID to
   * use for authentication.
   * @returns A Promise that resolves when the events have been
   * added to the local repository.
   */
  async execute(platform: PlatformId, uid: string, authenticatorId: string): Promise<void> {
    console.log("Pulling events for platform: ", platform);
    const remoteRepo = this.remoteFactory.buildFor(platform);
    await this.refreshToken.execute(uid, authenticatorId);

    const oldEvents = await this.eventRepository.fetchFromAuthenticator(uid, authenticatorId);
    const events: Event[] = await remoteRepo.pull(uid, authenticatorId, undefined);

    // get new and updated events to add to the local repository
    const newEvents = events.filter((event) => !oldEvents.some((oldEvent) => oldEvent.eventId === event.eventId));
    console.log({ newEvents });
    const updatedEvents = events.filter((event) => oldEvents.some((oldEvent) => oldEvent.eventId === event.eventId));
    console.log({ updatedEvents });
    const eventsToKeep = [...newEvents, ...updatedEvents];

    // get events to remove from the local repository
    const eventsToRemove = oldEvents.filter((oldEvent) => !events.some((event) => event.eventId === oldEvent.eventId));
    console.log({ eventsToRemove });

    await this.eventRepository.set(eventsToKeep, uid);
    await this.eventRepository.remove(eventsToRemove, uid);
  }
}
