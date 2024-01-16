/* eslint-disable require-jsdoc */
import { inject, injectable } from "tsyringe";
import { BlueprintLocalRepository } from "../repositories/blueprint.local.repository";
import { Event } from "../../../events/domain/entities";

/**
 * Use case for adding an event to the repository.
 */
@injectable()
export class CreateBlueprintEventUseCase {
  /**
   * Creates a new instance of the CreateBlueprintUseCase use case.
   * @param {BlueprintLocalRepository} blueprintLocalRepository The repository
   * to add the event to.
   */
  constructor(
    @inject("BlueprintLocalRepository") private readonly blueprintLocalRepository: BlueprintLocalRepository,
  ) {}

  /**
   * Executes the CreateBlueprintUseCase use case.
   * @param {Event} event The event to add to the repository.
   * @param {string} uid The user ID to associate with the event.
   * @return {Promise<void>} A Promise that resolves when the event
   * has been added to the repository.
   */
  async execute(event: Event, uid: string): Promise<void> {
    await this.blueprintLocalRepository.createEvents([event], uid);
  }
}
