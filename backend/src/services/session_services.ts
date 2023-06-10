import { GraphQLError } from "graphql/error/GraphQLError";
import Session from "../models/session_model";
import { ISession } from "../utils/interfaces/user";

/**
 * Creates a new session in the database using the provided session object.
 *
 * @param {ISession} session - The session object to be created.
 * @return {Promise<any>} A Promise that resolves with the newly created session object.
 * @throws {GraphQLError} Throws an error if there was a problem creating the session.
 */
export async function createSession(session: ISession): Promise<any> {
  try {
    const newSession = await Session.create(session);
    return newSession!;
  } catch (error: any) {
    console.log("error", error);
    throw new GraphQLError(error?.message);
  }
}
