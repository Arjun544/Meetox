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

/* Circle Types */

export interface CircleResponse {
  id: string;
  name: string;
  description: string;
  image: IImage;
  location: ILocation;
  isPrivate: Boolean;
  limit: number;
  admin: AdminResponse;
  members: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface AdminResponse {
  id: string;
  name: string;
  display_pic: IDisplayPic;
  isPremium: Boolean;
}
