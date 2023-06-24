import { Types, Document } from "mongoose";

export interface IMember extends Document {
  id: string;
  member: Types.ObjectId;
  circle: Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}
