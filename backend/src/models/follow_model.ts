import { Schema, model } from "mongoose";
import { IFollow } from "../utils/interfaces/follow";

const followSchema = new Schema(
  {
    follower: {
      type: Schema.Types.ObjectId,
      ref: "Users",
    },
    following: {
      type: Schema.Types.ObjectId,
      ref: "Users",
    },
  },
  {
    timestamps: {
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    },
  }
);
followSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

followSchema.set("toJSON", {
  virtuals: true,
});

export default model<IFollow>("Follow", followSchema);
