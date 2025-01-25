import { AuthenticatorType } from "./authenticator-type.enum";
import { UserData } from "./user-data.entity";

export interface Access {
  accessToken: string;
  refreshToken?: string;
  platformId: string;
  status: "connected" | "requires_reauth";
  user: UserData;
  type: AuthenticatorType;
}

/**
 * Public access information to fetch data from platformId.
 */
export type AccessPublicData = Omit<Access, "accessToken" | "refreshToken" | "type" | "status"> & {
  authenticatorId: string;
};
