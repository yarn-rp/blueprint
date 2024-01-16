import { container } from "tsyringe";
import * as functions from "firebase-functions";
import { RefreshEventsController } from "../../infrastructure/controllers/refresh-events.controller";

const refresh = container.resolve(RefreshEventsController);

const refreshEvents = functions.pubsub.schedule("every 5 minutes").onRun(async () => {
  console.log("refreshing events");
  await refresh.execute();
  console.log("tasks refreshed");
});

export default { refreshEvents };
