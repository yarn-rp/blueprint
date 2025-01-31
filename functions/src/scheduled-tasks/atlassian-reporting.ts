import axios from "axios";
import { Firestore, Timestamp } from "firebase-admin/firestore";
import * as functions from "firebase-functions";
import { container } from "tsyringe";
import { ConfigService } from "../common/config/config.service";

const firestore = container.resolve<Firestore>("firestore");
const config = container.resolve<ConfigService>("config");

function chunkArray<T>(array: T[], chunkSize: number): T[][] {
  const chunks: T[][] = [];
  for (let i = 0; i < array.length; i += chunkSize) {
    chunks.push(array.slice(i, i + chunkSize));
  }
  return chunks;
}

type Authenticator = {
  accessToken: string;
  user: {
    gid: string;
  };
  fetchedAt: Timestamp;
};

type Status = "closed" | "updated";

type JiraResponse = {
  accounts: {
    accountId: string;
    status: Status;
  }[];
};

// Get the reporting token from the owner user
// NOTE: The owner user must have an account in Blueprint
async function getReportingToken(): Promise<string> {
  const authenticator = await firestore
    .collectionGroup("authenticators")
    .where("platformId", "==", "jira")
    .where("user.email", "==", config.get("jira.ownerEmail"))
    .get();
  const authenticatorData = authenticator.docs[0].data() as Authenticator;
  return authenticatorData.accessToken;
}

async function callApi(chunk: { id: string; updatedAt: string }[]): Promise<{ accountId: string; status: Status }[]> {
  console.log("Calling API with chunk", chunk);
  const response = await axios.post<JiraResponse>(
    "https://api.atlassian.com/app/report-accounts/",
    {
      accounts: chunk.map((account) => ({ accountId: account.id, updatedAt: account.updatedAt })),
    },
    {
      headers: {
        Authorization: `Bearer ${await getReportingToken()}`,
        ContentType: "application/json",
      },
    },
  );
  console.log("API response", response.data);

  if (response.status === 204) return [];
  return response.data.accounts;
}

/*
 * Processes the response from the API.
 * This removes the accounts that are closed from the Firestore
 * Authenticator collection, and set "requires_reauth" status to the
 * accounts that are updated.
 * @param response - The response from the API.
 * @return A Promise that resolves to void.
 * */
async function processResponse(response: JiraResponse["accounts"]): Promise<void> {
  const batch = firestore.batch();
  const promises = response.map(async (account) => {
    const doc = await firestore.collectionGroup("authenticators").where("user.gid", "==", account.accountId).get();
    if (doc.empty) return;
    if (account.status === "closed") {
      doc.forEach((doc) => batch.delete(doc.ref));
    } else {
      doc.forEach((doc) => batch.update(doc.ref, { status: "requires_reauth" }));
    }
  });
  await Promise.all(promises);
  await batch.commit();
}

export const atlassianReporting = functions.pubsub.schedule("5 8 * * 0").onRun(async () => {
  try {
    const atlassianAccounts = (
      await firestore.collectionGroup("authenticators").where("platformId", "==", "jira").get()
    ).docs
      .map<Authenticator>((doc) => doc.data() as Authenticator)
      .filter((authenticator) => authenticator.user && authenticator.fetchedAt)
      .map((authenticator) => ({
        id: authenticator.user.gid,
        updatedAt: authenticator.fetchedAt.toDate().toISOString(),
      }));

    const chunkSize = 80;
    const chunks = chunkArray(atlassianAccounts, chunkSize);

    console.log("Chunks", chunks);
    const promises = chunks.map(async (chunk, index) => {
      try {
        console.log("Sending chunk", index + 1, "of", chunks.length);
        const response = await callApi(chunk);

        console.log("Processing response", index + 1, "of", chunks.length);
        await processResponse(response);

        return { success: true, chunkIndex: index };
      } catch (error) {
        console.error(`Error procesando chunk ${index + 1}:`, error);
        return { success: false, chunkIndex: index, error };
      }
    });

    const results = await Promise.allSettled(promises);
    results.forEach((result, index) => {
      if (result.status === "fulfilled") {
        if (result.value.success) {
          console.log(`Chunk ${result.value.chunkIndex + 1} processed successfully.`);
        } else {
          console.error(`Chunk ${result.value.chunkIndex + 1} failed:`, result.value.error);
        }
      } else {
        console.error(`Chunk ${index + 1} failed unexpected:`, result.reason);
      }
    });
  } catch (error) {
    console.error("Error in atlassianReporting function:", error);
  }
});
