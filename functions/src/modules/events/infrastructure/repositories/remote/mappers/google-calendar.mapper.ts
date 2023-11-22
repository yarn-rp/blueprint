import { Mapper } from "../base.event.remote.repository";
import { Event, User, AttendantStatus, PlatformName, ConferenceData } from "../../../../domain/entities";
import { GoogleCalendarEvent } from "../google-calendar.event.remote.repository";
import { calendar_v3 as CalendarV3 } from "googleapis";

/**
 * A mapper in charge of converting objects from Google Calendar Platform to
 * Event entities.
 */
export class GoogleCalendarMapper implements Mapper<GoogleCalendarEvent> {
  /**
   * Maps GoogleCalendarEvent to Event.
   * @param remoteEvent - the remote event to map
   * @returns the mapped event
   */
  fromRemoteEvent(remoteEvent: GoogleCalendarEvent): Event {
    const startTime = remoteEvent.start?.dateTime ? new Date(remoteEvent.start.dateTime) : undefined;
    const endTime = remoteEvent.end?.dateTime ? new Date(remoteEvent.end.dateTime) : undefined;
    const subject = remoteEvent.summary || "";
    const description = remoteEvent.description || "";
    const isAllDay = !!remoteEvent.start?.date;
    const colorHex = remoteEvent.colorId || undefined;
    const organizer: User = {
      displayName: remoteEvent.organizer?.displayName || "",
      email: remoteEvent.organizer?.email || "",
    };
    const attendees = remoteEvent.attendees?.map((att) => ({
      user: {
        displayName: att.displayName || "",
        email: att.email || "",
      },
      status: (att.responseStatus as AttendantStatus) || AttendantStatus.NeedsAction,
    }));

    const platformLink = remoteEvent.htmlLink || undefined;

    const conferenceData = this.getConferenceData(remoteEvent.conferenceData || undefined);

    const event: Event = {
      startTime,
      endTime,
      subject,
      description,
      isAllDay,
      colorHex,
      organizer,
      attendees,
      platformLink,
      platform: PlatformName.GoogleCalendar,
      attendantStatus: AttendantStatus.Accepted, // Replace with the real status
      conferenceData,
    };

    return event;
  }

  /**
   * Maps conference data from Google Calendar API to ConferenceData domain entity
   * @param gConferenceData - the
   * conference data from the Google Calendar API
   * @returns the mapped conference data
   */
  private getConferenceData(gConferenceData?: CalendarV3.Schema$ConferenceData): ConferenceData | undefined {
    if (!gConferenceData) return undefined;
    // map conference data from google to domain entity
    return {
      entryPoints:
        gConferenceData.entryPoints?.map((entryPoint) => {
          return {
            entryPointType: entryPoint.entryPointType || "",
            uri: entryPoint.uri || "",
            label: entryPoint.label || "",
          };
        }) || [],
      notes: gConferenceData.notes || "",
    };
  }
}
