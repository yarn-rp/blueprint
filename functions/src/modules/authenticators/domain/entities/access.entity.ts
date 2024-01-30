import { AuthenticatorType } from "./authenticator-type.enum";
import { UserData } from "./user-data.entity";

export interface Access {
  accessToken: string;
  refreshToken?: string;
  platformId: string;
  user: UserData;
  type: AuthenticatorType;
}

/**
 * Public access information to fetch data from platformId.
 */
export type AccessPublicData = Omit<Access, "accessToken" | "refreshToken" | "type"> & { authenticatorId: string };
