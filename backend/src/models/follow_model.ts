import { Schema, model } from "mongoose";
import { IFollow } from "../utils/interfaces/follow";
import paginate from "mongoose-paginate-v2";

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

followSchema.index({ "follower.name": "text" });
followSchema.index({ "following.name": "text" });

followSchema.plugin(paginate);

export default model<IFollow>("Follow", followSchema);
