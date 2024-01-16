import { container } from "tsyringe";
import { FirestoreBlueprintLocalRepository } from "./infrastructure/repositories/firestore-blueprint-local.repository";

container.register("BlueprintLocalRepository", { useClass: FirestoreBlueprintLocalRepository });

import triggers from "./interfaces/firestore/triggers";
export default { ...triggers };
