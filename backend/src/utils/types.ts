import { PubSub } from "graphql-subscriptions";
import { Context } from "graphql-ws/lib/server";
import { IncomingMessage } from "http";
import { IImage } from "./interfaces/circle";
import { ILocation } from "./interfaces/user";

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
export interface CircleResponse {
  id: string;
  name: string;
  description: string;
  image: IImage;
  location: ILocation;
  isPrivate: Boolean;
  limit: number;
  admin: string;
  members: number;
  createdAt: Date;
  updatedAt: Date;
}
