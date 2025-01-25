/* eslint-disable require-jsdoc */
import { inject, injectable } from "tsyringe";
import { BlueprintLocalRepository } from "../repositories/blueprint.local.repository";
import { Task } from "../../../tasks/domain/entities";

@injectable()
export class UpdateBlueprintTaskUseCase {
  /**
   * Creates a new instance of the UpdateBlueprintUseCase use case.
   * @param {BlueprintLocalRepository} blueprintLocalRepository The repository
   * to add the event to.
   */
  constructor(
    @inject("BlueprintLocalRepository") private readonly blueprintLocalRepository: BlueprintLocalRepository,
  ) {}

  /**
   * Executes the UpdateBlueprintUseCase use case.
   * @param {Event} event The event to add to the repository.
   * @param {string} uid The user ID to associate with the event.
   * @return {Promise<void>} A Promise that resolves when the event
   * has been added to the repository.
   */
  async execute(task: Task, uid: string): Promise<void> {
    if (task.isCompleted) {
      console.log("deleteFutureTasks");
      await this.blueprintLocalRepository.deleteFutureTasks([task], uid);
    }
    await this.blueprintLocalRepository.updateTasks([task], uid);
  }
}
