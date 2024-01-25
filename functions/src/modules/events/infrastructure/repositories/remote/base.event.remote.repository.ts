import { Firestore } from "firebase-admin/firestore";
import { Event, PlatformId } from "../../../domain/entities";
import { EventRemoteRepository } from "../../../domain/repositories/remote/event.remote.repository";
import { Access, AccessPublicData } from "../../../../authenticators/domain/entities";

/**
 * An abstract base class for EventRemoteRepository implementations.
 * It provides common functionality for interacting with a remote event
 * data source.
 *
 * It implements the pull method from the EventRemoteRepository interface,
 * but you will still need to implement the platformName property.
 */
export abstract class BaseEventRemoteRepository<RemoteEvent> implements EventRemoteRepository {
  constructor(
    private readonly firestore: Firestore,
    private readonly mapper: Mapper<RemoteEvent>,
  ) {}

  /**
   * Retrieves the access token for a user based on their uid
   * and authenticatorId.
   *
   * @param uid - The user ID.
   * @param authenticatorId - The ID of the authenticator.
   * @returns The access token as a Promise.
   */
  private async getAccess(uid: string, authenticatorId: string): Promise<Access> {
    const accessFirestoreDoc = await this.firestore
      .collection("users")
      .doc(uid)
      .collection("authenticators")
      .doc(authenticatorId)
      .get();

    const data = await accessFirestoreDoc.data();
    return data as Access;
  }

  /**
   * Abstract method to retrieve events from the remote source.
   *
   * @param accessToken - The access token to authenticate with
   * the remote source.
   * @returns A Promise containing an array of RemoteEvent objects.
   */
  abstract getEvents(accessToken: string): Promise<RemoteEvent[]>;

  /**
   * Platform name to indicate which platform the remote repository
   * is interacting with.
   */
  abstract platformName: PlatformId;

  /**
   * Retrieves events from a remote source and maps them to domain entities.
   *
   * @param uid - The user ID.
   * @param authenticatorId - The ID of the authenticator.
   * @param lastPulledEvent - Optional last pulled event.
   * @returns A Promise containing an array of Event entities.
   */
  async pull(uid: string, authenticatorId: string): Promise<Event[]> {
    const access = await this.getAccess(uid, authenticatorId);
    const nativeTasks = await this.getEvents(access.accessToken);
    console.log("nativeTasks", nativeTasks);
    // using bind since iterative methods like map and forEach
    // don't preserve the this context
    // @see {@link https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array#iterative_methods}
    // for more information
    return nativeTasks.map((element) => {
      return this.mapper.fromRemoteEvent(element, {
        platformId: access.platformId,
        user: access.user,
      });
    });
  }
}

/**
 * Mapper interface to map a RemoteEvent object to an Event entity.
 */
export interface Mapper<RemoteEvent> {
  /**
   * Maps a RemoteEvent object to an Event entity.
   * @param remoteEvent - The RemoteEvent object to map.
   */
  fromRemoteEvent(remoteEvent: RemoteEvent, accessData: AccessPublicData): Event;
}
