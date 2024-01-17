import { container } from "tsyringe";
import * as functions from "firebase-functions";
import { RefreshEventsController } from "../../infrastructure/controllers/refresh-events.controller";


// Refers to the time that the scheduler will run
// https://firebase.google.com/docs/functions/schedule-functions
const TIME_TO_REFRESH = 1;
const refresh = container.resolve(RefreshEventsController);

const refreshEvents = functions.pubsub.schedule(`every ${TIME_TO_REFRESH} minutes`).onRun(async () => {
  console.log("refreshing events");
  await refresh.execute();
  console.log("tasks refreshed");
});

export default { refreshEvents };
