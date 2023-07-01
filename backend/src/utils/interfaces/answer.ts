import { Types, Document } from "mongoose";

export interface IAnswer extends Document {
  id: string;
  answer: String;
  question: Types.ObjectId;
  user: Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}
