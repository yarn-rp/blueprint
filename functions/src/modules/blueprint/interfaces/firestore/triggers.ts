import { container } from "tsyringe";
import * as functions from "firebase-functions";
import { UpdateBlueprintController } from "../../infrastructure/controllers/update-blueprint.controller";

const updateBlueprint = container.resolve(UpdateBlueprintController);

const updateEvent = functions.firestore.document("users/{uid}/events/{eventId}").onUpdate(async (change, context) => {
  console.log("update event");
  return await updateBlueprint.execute(change.after, context);
});

const updateTask = functions.firestore.document("users/{uid}/tasks/{taskId}").onUpdate(async (change, context) => {
  console.log("update task");
  return await updateBlueprint.execute(change.after, context);
});

export default { updateEvent, updateTask };
