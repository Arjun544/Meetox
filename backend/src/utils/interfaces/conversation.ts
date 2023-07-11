import { Document } from "mongoose";
import { IUser } from "./user";

export interface IConversation extends Document {
  id: string;
  lastMessage: IMessage;
  participants: IUser[];
  extra: IExtra;
  createdAt: Date;
  updatedAt: Date;
}

export interface IExtra extends Document {
  [x: string]: any;
  participant: IUser;
  hasSeenLatestMessage: boolean;
}

export interface IMessage extends Document {
  id: string;
  message: string;
  sender: IUser;
  type: string;
  latitude: number;
  longitude: number;
  createdAt: Date;
  updatedAt: Date;
}
