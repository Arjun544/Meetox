import { GraphQLError } from "graphql/error/GraphQLError";
import Session from "../models/session_model";
import { ISession } from "../utils/interfaces/user";

export async function createSession(session: ISession): Promise<any> {
  try {
    const newSession = await Session.create(session);
    return newSession!;
  } catch (error: any) {
    console.log("error", error);
    throw new GraphQLError(error?.message);
  }
}
