import axios from "axios";
import { ConfigService } from "../../../../common/config/config.service";
import { AuthenticatorType } from "../../domain/entities";
import { Access } from "../../domain/entities/access.entity";
import { OAuthClaim } from "../../domain/entities/claim-access.entity";
import { UserData } from "../../domain/entities/user-data.entity";
import { OAuth2Repository } from "../../domain/repositories/oauth2.repository";

/**
 * An OAuth2 strategy for Jira.
 */
export class JiraOAuthStrategy implements OAuth2Repository {
  constructor(private readonly config: ConfigService) {}

  async wipeOut(_access: Pick<Access, "user">): Promise<void> {
    console.log("Wiping out access (No action needed)");
  }

  /**
   * Claims access to Jira.
   *
   * @param claim - The OAuth claim.
   * @returns An access object.
   */
  async claimAccess(claim: OAuthClaim): Promise<Omit<Access, "user">> {
    const { data } = await axios.post(
      "https://auth.atlassian.com/oauth/token",
      {
        grant_type: "authorization_code",
        client_id: this.config.get<string>("jira.clientId"),
        client_secret: this.config.get<string>("jira.clientSecret"),
        redirect_uri: this.config.get<string>("jira.redirectURI"),
        code: claim.code,
      },
      {
        headers: {
          Accept: "application/json",
        },
      },
    );
    return {
      accessToken: data.access_token,
      refreshToken: data.refresh_token,
      platformId: "jira",
      type: AuthenticatorType.Task,
      status: "connected",
    };
  }

  async refreshToken(oldAuth: Omit<Access, "user">): Promise<Omit<Access, "user">> {
    const { data } = await axios.post(
      "https://auth.atlassian.com/oauth/token",
      {
        grant_type: "refresh_token",
        client_id: this.config.get<string>("jira.clientId"),
        client_secret: this.config.get<string>("jira.clientSecret"),
        refresh_token: oldAuth.refreshToken,
      },
      {
        headers: {
          Accept: "application/json",
        },
      },
    );

    return {
      ...oldAuth,
      accessToken: data.access_token,
      refreshToken: data.refresh_token,
    };
  }

  /**
   * Gets the user data associated with an access object.
   *
   * @param access - The access object.
   * @returns The user data.
   */
  async getUser(access: Omit<Access, "user">): Promise<UserData> {
    const { data } = await axios.get("https://api.atlassian.com/me", {
      headers: {
        Authorization: `Bearer ${access.accessToken}`,
      },
    });
    return {
      gid: data.account_id,
      email: data.email,
      name: data.name,
    };
  }
}
