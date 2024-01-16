import { container } from "tsyringe";
import * as functions from "firebase-functions";
import { UpdateBlueprintItemController } from "../../infrastructure/controllers/update-blueprint-item.controller";
import { CreateBlueprintItemController } from "../../infrastructure/controllers/create-blueprint-item.controller";
import { DeleteBlueprintItemController } from "../../infrastructure/controllers/delete-blueprint-item.controller";

const updateBlueprintItem = container.resolve(UpdateBlueprintItemController);
const createBlueprintItem = container.resolve(CreateBlueprintItemController);
const deleteBlueprintItem = container.resolve(DeleteBlueprintItemController);

const updateEvent = functions.firestore.document("users/{uid}/events/{eventId}").onUpdate(async (change, context) => {
  console.log("update event");
  return await updateBlueprintItem.execute(change.after, context);
});

const createEvent = functions.firestore.document("users/{uid}/events/{eventId}").onCreate(async (change, context) => {
  console.log("create event");
  return await createBlueprintItem.execute(change, context);
});

const deleteEvent = functions.firestore.document("users/{uid}/events/{eventId}").onDelete(async (change, context) => {
  console.log("delete event");
  return await deleteBlueprintItem.execute(change, context);
});

const updateTask = functions.firestore.document("users/{uid}/tasks/{taskId}").onUpdate(async (change, context) => {
  console.log("update task");
  return await updateBlueprintItem.execute(change.after, context);
});

export default { updateEvent, updateTask, createEvent, deleteEvent };
