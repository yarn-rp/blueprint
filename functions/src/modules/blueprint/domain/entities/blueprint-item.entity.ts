import { Task } from "../../../tasks/domain/entities";
import { Event } from "../../../events/domain/entities";

/**
 * Represents an item in the Blueprint collection, which can be either an event or a task.
 * @property id - The id of the item
 * @property startTime - The start time of the item
 * @property endTime - The end time of the item
 * @property value - The value of the item (either a {@link Task} or an {@link Event})
 * @property runTimeType - The type of the item, either "task" or "event"
 *  For more information about the properties, see the {@link Task} and {@link Event} interfaces.
 */
export interface BlueprintItem {
  id: string;
  startTime: Date;
  endTime: Date;
  value: Event | Task;
  runTimeType: "task" | "event";
}
