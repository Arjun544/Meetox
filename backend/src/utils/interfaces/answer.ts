import { Types, Document } from "mongoose";

export interface IAnswer extends Document {
  id: string;
  answer: String;
  question: Types.ObjectId;
  user: Types.ObjectId;
  likes: [string];
  createdAt: Date;
  updatedAt: Date;
}
