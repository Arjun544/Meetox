import { Types, Document } from "mongoose";

export interface IFollow extends Document {
  id: string;
  follower: Types.ObjectId;
  following: Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}
