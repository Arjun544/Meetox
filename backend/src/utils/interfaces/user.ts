import { Types, Document } from "mongoose";

export interface ISession extends Document {
  token: string;
  user: string;
  address: string;
  expires: Date;
  createdAt: Date;
}

export interface IUser extends Document {
  name: string;
  email: string;
  display_pic: IDisplayPic;
  birthDate: Date;
  isPremium: boolean;
  isOnline: boolean;
  passwordlessToken: string;
  passwordlessTokenExpires: Date;
  whatsAppToken: string;
  whatsAppTokenExpires: Date;
  socials: ISocialLink;
  location: ILocation;
  followers: [Types.ObjectId];
  followings: [Types.ObjectId];
  createdAt: Date;
  updatedAt: Date;
}

export interface IDisplayPic extends IUser {
  profile: string;
  profileId: string;
}
export interface ISocialLink extends IUser {
  type: string;
  link: string;
}
export interface ILocation {
  address: string;
  coordinates: [number];
}
