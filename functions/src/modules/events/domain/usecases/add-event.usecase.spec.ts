import "reflect-metadata";
import { container } from "tsyringe";

import { AddEventUseCase } from "./add-event.usecase";

import { EventLocalRepository } from "../repositories/local/event.local.repository";
import { testEvent, testUserId } from "./__mocks__/event.mock";

describe("AddEventUseCase", () => {
  const eventsRepoMock: EventLocalRepository = {
    set: jest.fn(),
    fetchFromAuthenticator: jest.fn(),
    remove: jest.fn(),
    fetchLastFromPlatform: jest.fn(),
  };

  let addEventUseCase: AddEventUseCase;

  beforeEach(() => {
    container.register("EventLocalRepository", { useValue: eventsRepoMock });
    addEventUseCase = container.resolve(AddEventUseCase);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it("should be defined", () => {
    expect(addEventUseCase).toBeDefined();
  });

  it("should call repository to add the event", async () => {
    await addEventUseCase.execute(testEvent, testUserId);
    expect(eventsRepoMock.set).toHaveBeenCalled;
  });

  it("should call the add method with the event list and " + "the user id", async () => {
    await addEventUseCase.execute(testEvent, testUserId);
    expect(eventsRepoMock.set).toHaveBeenCalledWith([testEvent], testUserId);
  });

  it("should throw exception when repository throws exception ", async () => {
    eventsRepoMock.set = jest.fn().mockRejectedValue(new Error("test error"));
    await expect(addEventUseCase.execute(testEvent, testUserId)).rejects.toThrow("test error");
  });
});
