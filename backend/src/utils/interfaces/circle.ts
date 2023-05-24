import { Types, Document } from "mongoose";
import { ILocation } from "./user";

export interface ICircle extends Document {
  name: string;
  description: string;
  image: IImage;
  location: ILocation;
  isPrivate: Boolean;
  limit: Number;
  admin: [Types.ObjectId];
  members: [Types.ObjectId];
  createdAt: Date;
  updatedAt: Date;
}

export interface IImage {
  image: string;
  imageId: string;
}


