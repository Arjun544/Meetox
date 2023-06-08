import { Document } from "mongoose";
import { ILocation, IUser } from "./user";

export interface IQuestion extends Document {
  question: string;
  answers: [IAnswer];
  owner: IUser;
  upvotes: [IVote];
  downvotes: [IVote];
  expiry: Date;
  location: ILocation;
  createdAt: Date;
  updatedAt: Date;
}

export interface IAnswer {
  answer: string;
  user: IUser;
}

export interface IVote {
  votes: number;
  user: IUser;
}
