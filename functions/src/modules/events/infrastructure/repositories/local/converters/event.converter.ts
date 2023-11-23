import { Timestamp, type DocumentData } from "firebase-admin/firestore";
import { Event } from "../../../../domain/entities";

/**
 * Firestore data converter for the Event interface.
 * @see https://firebase.google.com/docs/firestore/manage-data/add-data#custom_objects
 */
export const eventConverter: FirebaseFirestore.FirestoreDataConverter<Event> = {
  /**
   * Converts an Event object to a Firestore DocumentData object.
   * @param event - The Event object to convert.
   * @returns A Firestore DocumentData object
   *  representing the Event object.
   */
  toFirestore(event: Event): DocumentData {
    console.log("Event: ", event);
    console.log("Timestamp", Timestamp.fromDate);

    return {
      ...event,
      startTime: event.startTime ? Timestamp.fromDate(event.startTime) : null,
      endTime: event.endTime ? Timestamp.fromDate(event.endTime) : null,
      organizer: event.organizer || null,
      attendees: event.attendees || [],
      conferenceData: event.conferenceData || null,
    };
  },

  /**
   * Converts a Firestore QueryDocumentSnapshot to an Event object.
   * @param snapshot - The Firestore
   *  QueryDocumentSnapshot to convert.
   * @returns An Event object representing the
   * Firestore QueryDocumentSnapshot.
   */
  fromFirestore(snapshot: FirebaseFirestore.QueryDocumentSnapshot): Event {
    const data = snapshot.data();

    return {
      ...data,
      startTime: data.startTime ? data.startTime.toDate() : null,
      endTime: data.endTime ? data.endTime.toDate() : null,
      organizer: data.organizer || null,
      attendees: data.attendees || [],
      conferenceData: data.conferenceData || null,
    } as Event;
  },
};
