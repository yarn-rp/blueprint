import axios from "axios";
import { ConfigService } from "../../../../common/config/config.service";
import { AuthenticatorType } from "../../domain/entities";
import { Access } from "../../domain/entities/access.entity";
import { OAuthClaim } from "../../domain/entities/claim-access.entity";
import { UserData } from "../../domain/entities/user-data.entity";
import { OAuth2Repository } from "../../domain/repositories/oauth2.repository";

/**
 * An OAuth2 strategy for Google.
 */
export class GoogleOAuthStrategy implements OAuth2Repository {
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
      "https://oauth2.googleapis.com/token",
      {
        grant_type: "authorization_code",
        client_id: this.config.get<string>("google.clientId"),
        client_secret: this.config.get<string>("google.clientSecret"),
        redirect_uri: this.config.get<string>("google.redirectURI"),
        code: claim.code,
      },
      {
        headers: {
          Accept: "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      },
    );
    console.log(data);
    return {
      accessToken: data.access_token,
      refreshToken: data.refresh_token,
      platformId: "google-calendar",
      type: AuthenticatorType.Event,
      status: "connected",
    };
  }

  async refreshToken(oldAuth: Omit<Access, "user">): Promise<Omit<Access, "user">> {
    // TODO: do this for all platforms
    if (await this.checkTokenValidity(oldAuth.accessToken)) {
      console.log("STILL VALID");
      return oldAuth;
    }
    try {
      const { data } = await axios.post(
        "https://oauth2.googleapis.com/token",
        {
          grant_type: "refresh_token",
          client_id: this.config.get<string>("google.clientId"),
          client_secret: this.config.get<string>("google.clientSecret"),
          refresh_token: oldAuth.refreshToken,
        },
        {
          headers: {
            Accept: "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        },
      );

      return {
        ...oldAuth,
        accessToken: data.access_token,
      };
    } catch (error) {
      return oldAuth;
    }
  }

  /**
   * Gets the user data associated with an access object.
   *
   * @param access - The access object.
   * @returns The user data.
   */
  async getUser(access: Omit<Access, "user">): Promise<UserData> {
    const { data } = await axios.get("https://www.googleapis.com/oauth2/v1/userinfo?alt=json", {
      headers: {
        Authorization: `Bearer ${access.accessToken}`,
      },
    });
    console.log(data);
    return {
      gid: data.id,
      email: data.email,
      name: data.name,
    };
  }

  private async checkTokenValidity(token: string): Promise<boolean> {
    try {
      await axios.get("https://www.googleapis.com/oauth2/v1/userinfo?alt=json", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      return true;
    } catch (error) {
      return false;
    }
  }
}
