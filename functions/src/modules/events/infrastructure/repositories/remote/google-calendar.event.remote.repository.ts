/* eslint-disable camelcase */
import { google, calendar_v3 } from "googleapis";
import { PlatformId } from "../../../domain/entities";
import { BaseEventRemoteRepository } from "./base.event.remote.repository";
import "reflect-metadata";
import { container } from "tsyringe";
import { ConfigService } from "../../../../../common/config/config.service";

export type GoogleCalendarEvent = calendar_v3.Schema$Event;

/**
 * A Google Calendar remote repository that fetches the events from the
 * Google Calendar API.
 *
 * @see https://developers.google.com/calendar/v3/reference/events
 * @see https://developers.google.com/calendar/v3/reference/events/list
 */
export class GoogleCalendarEventRemoteRepository extends BaseEventRemoteRepository<GoogleCalendarEvent> {
  /**
   * Override of the Platform name to indicate the platform
   * name of the remote repository.
   */
  platformName: PlatformId = PlatformId.GoogleCalendar;

  /**
   * Retrieves the events from the Google Calendar API using
   * the access token.
   * @param accessToken - the access token to authenticate
   * with the remote source.
   */
  async getEvents(accessToken: string): Promise<GoogleCalendarEvent[]> {
    const calendarAPIClient = this._getCalendarAPIClient(accessToken);
    try {
      // Get events from the primary calendar, from today till next week
      const response = await calendarAPIClient.events.list({
        calendarId: "primary",
        timeMin: new Date(new Date().setHours(0, 0, 0, 0)).toISOString(),
        timeMax: new Date(new Date().setHours(0, 0, 0, 0) + 7 * 24 * 60 * 60 * 1000).toISOString(),
        singleEvents: true,
        orderBy: "startTime",
      });
      const colors = await calendarAPIClient.colors.get();

      const gCalendarEvents = response.data.items;
      const coloredEvents = gCalendarEvents?.map((event) => {
        const colorId = event.colorId;
        const color = colorId ? colors.data.event?.[colorId]?.background : undefined;
        return {
          ...event,
          colorId: color,
        };
      });

      return coloredEvents || [];
    } catch (error) {
      console.log("Error: ", error);
      // Depending on the error we might return different
      // exceptions
      throw error;
    }
  }

  /**
   * Creates a Google Calendar V3 API client given a valid access token.
   * Please note that the access token must have the following scopes:
   * - https://www.googleapis.com/auth/calendar.events.readonly
   * - https://www.googleapis.com/auth/calendar.readonly
   *
   * @param accessToken - the access token to authenticate
   * with client.
   * @returns a Google Calendar API client
   * authenticated client
   *
   * @see https://developers.google.com/calendar/v3/reference
   */
  private _getCalendarAPIClient(accessToken: string): calendar_v3.Calendar {
    const config = container.resolve<ConfigService>("config");
    console.log("ClientID", config.get("google.clientId"));
    const client = new google.auth.OAuth2(
      config.get("google.clientId"),
      config.get("google.clientSecret"),
      config.get("google.redirectURI"),
    );
    client.setCredentials({ access_token: accessToken });
    return google.calendar({
      version: "v3",
      auth: client,
    });
  }
}
