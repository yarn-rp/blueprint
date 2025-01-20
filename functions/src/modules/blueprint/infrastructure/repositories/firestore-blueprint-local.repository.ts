/* eslint-disable require-jsdoc */
import { FieldPath, Firestore, Timestamp } from "firebase-admin/firestore";
import { inject, injectable } from "tsyringe";
import { Event } from "../../../events/domain/entities/event.entity";
import { Task } from "../../../tasks/domain/entities/task.entity";
import { BlueprintItem } from "../../domain/entities/blueprint-item.entity";
import { BlueprintLocalRepository } from "../../domain/repositories/blueprint.local.repository";

@injectable()
export class FirestoreBlueprintLocalRepository implements BlueprintLocalRepository {
  constructor(@inject("firestore") private readonly firestore: Firestore) {}

  async createEvents(items: Event[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    items.forEach((item) => {
      const docRef = this.firestore.collection("users").doc(uid).collection("blueprint").doc();

      const blueprintItem: BlueprintItem = {
        id: docRef.id,
        startTime: item.startTime as Date,
        endTime: item.endTime as Date,
        value: item,
        runtimeType: "event",
      };

      batch.set(docRef, blueprintItem);
    });

    await batch.commit();
  }

  async updateEvents(items: Event[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    const evenIdFieldRef = new FieldPath("value", "eventId");
    console.log("Updating events that match with", items);

    await Promise.all(
      items.map((item) => {
        const matchingEventsOnBlueprint = this.firestore
          .collection("users")
          .doc(uid)
          .collection("blueprint")
          .where(evenIdFieldRef, "==", item.eventId)
          .get();

        return matchingEventsOnBlueprint.then((snapshot) => {
          snapshot.docs.forEach((doc) => {
            batch.update(doc.ref, { value: item, startTime: item.startTime, endTime: item.endTime });
          });
        });
      }),
    );

    await batch.commit();
  }

  async deleteEvents(items: Event[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    const evenIdFieldRef = new FieldPath("value", "eventId");
    console.log("Deleting events that match with", items);

    await Promise.all(
      items.map((item) => {
        const matchingEventsOnBlueprint = this.firestore
          .collection("users")
          .doc(uid)
          .collection("blueprint")
          .where(evenIdFieldRef, "==", item.eventId)
          .get();

        return matchingEventsOnBlueprint.then((snapshot) => {
          snapshot.docs.forEach((doc) => {
            batch.delete(doc.ref);
          });
        });
      }),
    );

    await batch.commit();
  }

  async updateTasks(items: Task[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    const taskIdFieldRef = new FieldPath("value", "taskId");

    const promises = items.map(async (item) => {
      const matchingTasksOnBlueprint = await this.firestore
        .collection("users")
        .doc(uid)
        .collection("blueprint")
        .where(taskIdFieldRef, "==", item.taskId)
        .get();

      matchingTasksOnBlueprint.docs.forEach((doc) => {
        batch.update(doc.ref, { value: item });
      });
    });

    await Promise.all(promises);
    await batch.commit();
  }
  async deleteTasks(items: Task[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    const taskIdFieldRef = new FieldPath("value", "taskId");
    items.forEach((item) => {
      const matchingTasksOnBlueprint = this.firestore
        .collection("users")
        .doc(uid)
        .collection("blueprint")
        .where(taskIdFieldRef, "==", item.taskId)
        .get();

      matchingTasksOnBlueprint.then((snapshot) => {
        snapshot.docs.forEach((doc) => {
          batch.delete(doc.ref);
        });
      });
    });

    await batch.commit();
  }

  async deleteFutureTasks(items: Task[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    const taskIdFieldRef = new FieldPath("value", "taskId");
    console.log(
      "Deleting future tasks that match with",
      items.map((item) => item.taskId),
    );

    const promises = items.map(async (item) => {
      const matchingTasksOnBlueprint = await this.firestore
        .collection("users")
        .doc(uid)
        .collection("blueprint")
        .where(taskIdFieldRef, "==", item.taskId)
        .where("startTime", ">", Timestamp.now())
        .get();

      matchingTasksOnBlueprint.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });
    });

    await Promise.all(promises);
    await batch.commit();
  }
}
