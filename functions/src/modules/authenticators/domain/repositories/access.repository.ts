import { Access } from "../entities/access.entity";

export interface AccessRepository {
  save(access: Access, uid: string): Promise<void>;
  getById(uid: string, authenticatorId: string): Promise<Access>;
}
