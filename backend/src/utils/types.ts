import { PubSub } from "graphql-subscriptions";
import { Context } from "graphql-ws/lib/server";
import { IncomingMessage } from "http";
import { Types } from "mongoose";
import { IImage } from "./interfaces/circle";
import { IDisplayPic, ILocation } from "./interfaces/user";

export interface GraphQLContext {
  req: IncomingMessage | null;
  token: string;
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
