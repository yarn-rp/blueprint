import * as functions from "firebase-functions";
import { container } from "tsyringe";
import { AddTaskViaApiKey } from "../../infrastructure/controllers/add-task.controller";
import { withMiddlewares } from "../../../../access/http/middleware/apply-middlewares";
import { ApiKeyCurrentUser } from "../../../../access/api-key/api-key.middleware";
import { CompleteTaskController } from "../../infrastructure/controllers/complete-task.controller";

const addTaskController = container.resolve(AddTaskViaApiKey);
const completeTaskController = container.resolve(CompleteTaskController);

const addTask = withMiddlewares(ApiKeyCurrentUser)(async (req, res) => {
  return addTaskController.execute(req, res);
});

const completeTask = functions.https.onCall(async (data, context) => {
  return completeTaskController.execute(data, context);
});

export default { addTask, completeTask };
