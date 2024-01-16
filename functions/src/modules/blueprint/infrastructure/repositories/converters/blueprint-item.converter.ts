import { Timestamp, type DocumentData } from "firebase-admin/firestore";
import { BlueprintItem } from "../../../domain/entities";
import { Task } from "../../../../tasks/domain/entities/task.entity";
import { Event } from "../../../../events/domain/entities/event.entity";

/**
 * Firestore data converter for the Event interface.
 * @see https://firebase.google.com/docs/firestore/manage-data/add-data#custom_objects
 */
export const blueprintItemConverter: FirebaseFirestore.FirestoreDataConverter<BlueprintItem> = {
  /**
   * Converts an Event object to a Firestore DocumentData object.
   * @param event - The Event object to convert.
   * @returns A Firestore DocumentData object
   *  representing the Event object.
   */
  toFirestore(item: BlueprintItem): DocumentData {
    console.log("Event: ", item);
    console.log("Timestamp", Timestamp.fromDate);

    return {
      startTime: Timestamp.fromDate(item.startTime),
      endTime: Timestamp.fromDate(item.endTime),
      value: item.value,
      runTimeType: item.runTimeType,
      id: item.id,
    };
  },

  /**
   * Converts a Firestore QueryDocumentSnapshot to an Event object.
   * @param snapshot - The Firestore
   *  QueryDocumentSnapshot to convert.
   * @returns An Event object representing the
   * Firestore QueryDocumentSnapshot.
   */
  fromFirestore(snapshot: FirebaseFirestore.QueryDocumentSnapshot): BlueprintItem {
    const data = snapshot.data();
    let value: Event | Task;

    if (data.runTimeType === "task") {
      value = data.value as Task;
    } else {
      value = data.value as Event;
    }

    return {
      startTime: data.startTime.toDate(),
      endTime: data.endTime.toDate(),
      value: value,
      runTimeType: data.runTimeType,
      id: data.id,
    };
  },
};
