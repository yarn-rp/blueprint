import { AuthenticatorType } from "./authenticator-type.enum";
import { UserData } from "./user-data.entity";

export interface Access {
  accessToken: string;
  refreshToken?: string;
  platformId: string;
  user: UserData;
  type: AuthenticatorType;
}

export type AccessPublicData = Omit<Access, "accessToken" | "refreshToken">;
