import { Event } from "../../../events/domain/entities";
import { Task } from "../../../tasks/domain/entities";
/**
 * A repository for events inside the Blueprint. This repository
 * is in charge of managing blueprint items that are already inside the platform.
 */
export interface BlueprintLocalRepository {
  /**
   * Update the items that are in the blueprint collection that match with the events
   * @param events events to update
   * @param uid user id to associate with the item
   */
  updateEvents(items: Event[], uid: string): Promise<void>;

  /**
   * Update the items that are in the blueprint collection that match with the tasks
   * @param tasks tasks to update
   * @param uid user id to associate with the item
   */
  updateTasks(items: Task[], uid: string): Promise<void>;
}
