import { container } from "tsyringe";
import * as functions from "firebase-functions";
import { RefreshTasksController } from "../../infrastructure/controllers/refresh-tasks.controller";

const refresh = container.resolve(RefreshTasksController);

const refreshTasks = functions.pubsub.schedule("every 5 minutes").onRun(async () => {
  console.log("refreshing tasks");
  await refresh.execute();
  console.log("tasks refreshed");
});

export default { refreshTasks };
