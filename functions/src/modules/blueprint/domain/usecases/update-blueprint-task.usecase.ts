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
  async execute(event: Task, uid: string): Promise<void> {
    await this.blueprintLocalRepository.updateTasks([event], uid);
  }
}
