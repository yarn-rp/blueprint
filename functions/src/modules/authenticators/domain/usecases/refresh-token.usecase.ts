import { inject, injectable } from "tsyringe";
import { Access } from "../entities";
import { AccessRepository } from "../repositories/access.repository";
import { OAuth2Repository } from "../repositories/oauth2.repository";

@injectable()
export class RefreshToken {
  constructor(
    @inject("AccessRepository") private accessRepo: AccessRepository,
    @inject("OAuth2Repository") private oauthRepo: OAuth2Repository,
  ) {}

  async execute(uid: string, authenticatorId: string): Promise<Omit<Access, "user">> {
    console.log(`Refreshing token for ${uid} ${authenticatorId}`);
    const access = await this.accessRepo.getById(uid, authenticatorId);
    console.log({ oldAccess: access });
    const newAccess = await this.oauthRepo.refreshToken(access);
    console.log({ newAccess });

    await this.accessRepo.save({ ...newAccess, user: access.user }, uid);
    console.log(`Token refreshed for ${uid} ${authenticatorId}`);
    return newAccess;
  }
}
