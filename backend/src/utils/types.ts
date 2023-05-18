import { PubSub } from "graphql-subscriptions";
import { Context } from "graphql-ws/lib/server";
import { IncomingMessage } from "http";
import { Types } from "mongoose";

export interface GraphQLContext {
  req: IncomingMessage | null;
  pubsub: PubSub;
}
export interface SubscriptionContext extends Context {
  connectionParams: {
    token?: string;
  };
}

/* Auth Types */
export interface LoginArgs {
  email: string;
  address: string;
}
export interface TokenResponse {
  id: string | null;
  token: string | null;
}

/* User Types */



