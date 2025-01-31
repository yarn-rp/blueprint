import "reflect-metadata";
import { container } from "tsyringe";
import { configFactory } from "./common/config/config.service";
import { getFirestore } from "./common/firestore/firestore.service";
import { ApiKeyServiceImpl } from "./access/api-key/api-key.service";

container.register("config", { useFactory: configFactory });
container.register("firestore", { useValue: getFirestore() });
container.register("api-key", { useClass: ApiKeyServiceImpl });

// AuthenticatorsModule
import authRoutes from "./modules/authenticators/authenticators.module";
export const authenticators = authRoutes;

// UsersModule
import userRoutes from "./modules/users/users.module";
export const users = userRoutes;

// BlueprintModule
import blueprintRoutes from "./modules/blueprint/blueprint.module";
export const blueprint = blueprintRoutes;

// TasksModule
import tasksRoutes from "./modules/tasks/tasks.module";
export const tasks = tasksRoutes;

// EventsModule
import eventsRoutes from "./modules/events/events.module";
export const events = eventsRoutes;

// ScheduledTasks
import scheduledTasks from "./scheduled-tasks";
export const scheduled = scheduledTasks;
