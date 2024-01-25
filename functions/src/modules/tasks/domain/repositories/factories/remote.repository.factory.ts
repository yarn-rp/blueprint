import { PlatformId } from "../../entities/platform.enum";
import { RemoteRepository } from "./impl/remote.repository";

export interface RemoteRepositoryFactory {
  buildFor(platform: PlatformId): RemoteRepository;
}
