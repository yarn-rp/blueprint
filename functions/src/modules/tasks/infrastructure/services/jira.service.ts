/* eslint-disable require-jsdoc */
import axios from "axios";
import { Task } from "../../domain/entities/task.entity";
import { AbstractRemoteRepository } from "../repositories/factories/remote.repository.abstract";
import { Project } from "../../domain/entities/project.entity";
import { Priority } from "../../domain/entities/priority.entity";
import { Label } from "../../domain/entities/label.entity";
import { User } from "../../domain/entities/user.entity";
import { AccessPublicData } from "../../../authenticators/domain/entities/access.entity";

type JiraTask = {
  id: string;
  self: string;
  key: string;
  fields: {
    summary: string;
    description: JiraDescription;
    duedate: string;
    timeestimate: number;
    timespent: number;
    assignee: JiraApiUser;
    status: any;
    created: string;
    updated: string;
    priority: Record<string, any>;
    project: JiraProject;
    creator: JiraApiUser;
  };
  renderedFields: {
    description: string;
  };
};
interface JiraProject {
  id: string;
  uuid: string | null;
  name: string;
  self: string;
  description: string;
  avatarUrls: Record<string, string>;
}

interface JiraApiUser {
  [key: string]: unknown; // for arbitrary string keys and dynamic values
  self?: string;
  displayName?: string;
  avatarUrls?: { [key: string]: string };
}

interface JiraDescription {
  type: string;
  content: Array<DescriptionContent>;
}
interface DescriptionContent {
  content: Array<{ text: string }>;
}

export class JiraRemoteRepository extends AbstractRemoteRepository<JiraTask> {
  private CLOUDS_API_URL = "https://api.atlassian.com/oauth/token/accessible-resources";

  private buildHeaders(accessToken: string) {
    return {
      Authorization: `Bearer ${accessToken}`,
      Accept: "application/json",
    };
  }

  private buildSearchUrl(cloudId: string) {
    return `https://api.atlassian.com/ex/jira/${cloudId}/rest/api/3/search?jql=assignee=currentuser() AND StatusCategory!=Done&expand=renderedFields`;
  }

  private async getCloudIds(accessToken: string): Promise<{ id: string; url: string }[]> {
    const { data: clouds } = await axios.get<{ id: string; url: string }[]>(this.CLOUDS_API_URL, {
      headers: this.buildHeaders(accessToken),
    });
    return clouds;
  }

  async getTasks(accessToken: string): Promise<JiraTask[]> {
    const clouds = await this.getCloudIds(accessToken);

    const jiraTasks = clouds.map(async (cloud) => {
      const searchUrl = this.buildSearchUrl(cloud.id);
      const { data } = await axios.get<{ issues: JiraTask[] }>(searchUrl, {
        headers: this.buildHeaders(accessToken),
      });
      return data.issues.map((issue) => ({ ...issue, self: cloud.url }));
    });
    const tasksPerCloud = await Promise.all(jiraTasks);
    return tasksPerCloud.flat();
  }

  mapper(remote: JiraTask, access: AccessPublicData): Task {
    // Maybe moving all the mappers to a separate file would be a good idea
    const task = fromJiraApiIssueToTask(remote);

    return {
      access: access,
      ...task,
    };
  }
}

/**
 * Convert a Jira API status object to a Status object.
 * @param priority - the api priority object
 * @returns a number representing the priority of the task.
 * That number is 1|2|3|4|5.
 */
function fromJiraApiPriorityToPriority(priority?: Record<string, string>): Priority {
  // TODO(yarn-rp): this function is not working completely fine, since it is
  // not ensuring that the priority is a number from 1 to 5.
  const priorityNumber = priority?.id;
  const priorityInt = parseInt(priorityNumber as string) || 0;
  // if priority is a number from 1|2|3|4|5, return it
  if (priorityInt >= 1 && priorityInt <= 5) {
    return priorityInt;
  }

  // return three since this is the default priority
  return 3;
}
/**
 * Convert a Jira API status object to a Status object.
 * @param status - the api status object
 * @returns  a label representing the status of the task.
 */
function fromJiraApiStatusToStatus(status?: Record<string, any>): Label {
  if (status == null) {
    return { name: "No Status", colorHex: "#FFC107" };
  }

  const name = status.name ?? "";
  const colorName = status.statusCategory?.colorName ?? "";
  // if colorName is string, returning the color associated with that name
  if (typeof colorName === "string") {
    return { name, colorHex: getColorHexByName(colorName) };
  }

  return { name, colorHex: "#FFC107" };
}

/**
 * Returns the hex code of the color associated with a given color name.
 * Jira API returns a color name, but we need the hex code to display it, so
 * this functions is in charge of mapping the color name to the hex code.
 *
 * Since we can't support all the colors, we are just supporting the ones
 * that are used in the Jira Cloud UI and defaulting to an specific color
 * if the color is not found.
 * @param name - the name of the color
 * @returns the hex code of the color associated with the given name
 * or a default color if the color is not found.
 */
function getColorHexByName(name: string): string {
  // TODO(yarn-rp): implement this function properly, maybe calling to a
  // different service and fetching the color from database or just having
  // a temporary map of colors.
  return "#FFC107";
}

function fromJiraApiUserToUser(user: JiraApiUser, cloudUrl: string): User {
  const platformURL = new URL(`${cloudUrl}/jira/people/${user.accountId}`);
  const displayName = user.displayName ?? "";
  const avatarUrl = user.avatarUrls?.["48x48"] ?? "";

  return { platformURL, displayName, avatarUrl };
}

/**
 * Builds a url that can be opened in a browser env to see the task.
 * @param jiraIssue - the Jira API issue object
 * @returns the url that can be opened in a browser env to see the task
 */
function getTaskUrl(jiraIssue: JiraTask): URL | null {
  const domain = jiraIssue.self;
  const issueKey = jiraIssue.key;

  if (issueKey == null) {
    return null;
  }
  const url = new URL(`${domain}/browse/${issueKey}`);
  return url;
}

/**
 * A very simple function to hash a project to a color.
 * This function is not meant to be used in production, but it is good enough
 * for the purpose of this demo.
 *
 * Production should store projects in a database and assign a random color
 * to each project, so the projects keep the same color.
 * @param projectName - the name of the project
 * @returns the hex code of the color associated with the project name
 */
function colorFromProjectName(projectName: string): string {
  // Hash the projectName using a simple hash function
  let hash = 0;
  for (let i = 0; i < projectName.length; i++) {
    hash = projectName.charCodeAt(i) + ((hash << 5) - hash);
  }

  // Convert the hash to a positive integer and divide by the
  // maximum value to get a value between 0 and 1
  const value = (hash >>> 0) / 0xffffffff;

  // Use HSV color model to generate a random color with a fixed
  // saturation and brightness and a varying hue based on the hashed value
  const hue = value * 360;
  const saturation = 70;
  const brightness = 90;

  // Convert the HSV values to RGB and then to a hex code
  const { r, g, b } = hsvToRgb(hue, saturation, brightness);
  return rgbToHex(r, g, b);
}

// Helper function to convert an HSV color to RGB
function hsvToRgb(h: number, s: number, v: number) {
  const c = v * s;
  const x = c * (1 - Math.abs(((h / 60) % 2) - 1));
  const m = v - c;
  let rgb: { r: number; g: number; b: number };
  if (h < 60) {
    rgb = { r: c, g: x, b: 0 };
  } else if (h < 120) {
    rgb = { r: x, g: c, b: 0 };
  } else if (h < 180) {
    rgb = { r: 0, g: c, b: x };
  } else if (h < 240) {
    rgb = { r: 0, g: x, b: c };
  } else if (h < 300) {
    rgb = { r: x, g: 0, b: c };
  } else {
    rgb = { r: c, g: 0, b: x };
  }
  return {
    r: Math.round((rgb.r + m) * 255),
    g: Math.round((rgb.g + m) * 255),
    b: Math.round((rgb.b + m) * 255),
  };
}

// Helper function to convert an RGB color to a hex code
function rgbToHex(r: number, g: number, b: number) {
  return `#${r.toString(16).padStart(2, "0")}${g.toString(16).padStart(2, "0")}${b.toString(16).padStart(2, "0")}`;
}

/**
 * Maps a Jira API project to a blueprint project.
 * @see https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-projects/#api-rest-api-3-project-get
 * @param project - a jira representation of a project
 * @returns a blueprint representation of a project
 * @throws if the project doesn't have an id, name or platformURL
 */
function fromJiraProjectToProject(project: JiraProject): Project {
  const projectId = project.id;
  const projectName = project.name;
  const platformURL = project.self;
  const { description } = project;
  const iconUrl = project.avatarUrls?.$16X16;

  if (projectId == null) {
    throw new Error("Project ID is null");
  }
  if (projectName == null) {
    throw new Error("Project name is null");
  }
  if (platformURL == null) {
    throw new Error("Platform URL is null");
  }

  const color = colorFromProjectName(projectId);

  return {
    id: "jira",
    platformId: projectId,
    name: projectName,
    platformURL: new URL(platformURL),
    description: description || "",
    colorHex: color,
    iconUrl: iconUrl || "",
  };
}

/**
 * Maps a Jira Issue to a Blueprint Task.
 * @see https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-get
 * @param jiraIssue - a jira representation of an issue
 * @returns a blueprint representation of a task
 * @throws if the issue doesn't have any fields.
 * @throws if the project doesn't have an id, name or platformURL
 */
function fromJiraApiIssueToTask(jiraIssue: JiraTask): Omit<Task, "access"> {
  if (!jiraIssue.fields) {
    throw new Error("Issue fields are null");
  }
  const issueId = jiraIssue.id;
  const issueKey = jiraIssue.key;
  const { fields } = jiraIssue;

  const createdAt = new Date(fields.created as string);
  const updatedAt = new Date(fields.updated as string);

  const project = fromJiraProjectToProject(fields.project);

  const title = fields.summary || "";
  const description = jiraIssue.renderedFields?.description || "";
  const dueDate = fields.duedate ? new Date(fields.duedate) : undefined;
  const estimatedTime = fields.timeestimate;
  const loggedTime = fields.timespent || 0;
  const assigned = fields.assignee;
  const { creator } = fields;
  const isCompleted = false;
  const status = fromJiraApiStatusToStatus(fields.status);
  const priority = fromJiraApiPriorityToPriority(fields.priority);

  const userCreator = fromJiraApiUserToUser(creator, jiraIssue.self);
  if (userCreator === null) {
    throw new Error("User creator is null");
  }
  const userAssigned = fromJiraApiUserToUser(assigned, jiraIssue.self);
  const task = {
    id: issueId,
    taskId: issueKey,
    createdAt,
    updatedAt,
    project,
    taskURL: getTaskUrl(jiraIssue) || new URL(""),
    title,
    description,
    dueDate: dueDate.getTime() === 0 ? undefined : dueDate,
    estimatedTime,
    loggedTime,
    assigned: [userAssigned] || [],
    creator: userCreator,
    isCompleted,
    labels: [status],
    priority,
  };
  return task;
}
