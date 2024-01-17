import { container } from "tsyringe";
import * as functions from "firebase-functions";
import { RefreshTasksController } from "../../infrastructure/controllers/refresh-tasks.controller";

// Refers to the time that the scheduler will run
// https://firebase.google.com/docs/functions/schedule-functions
const TIME_TO_REFRESH = 1;
const refresh = container.resolve(RefreshTasksController);

const refreshTasks = functions.pubsub.schedule(`every ${TIME_TO_REFRESH} minutes`).onRun(async () => {
  console.log("refreshing tasks");
  await refresh.execute();
  console.log("tasks refreshed");
});

export default { refreshTasks };
