import { Schema, model } from "mongoose";
import { IMember } from "../utils/interfaces/member";
import paginate from "mongoose-paginate-v2";

const memberSchema = new Schema(
  {
    member: {
      type: Schema.Types.ObjectId,
      ref: "Users",
    },
    circle: {
      type: Schema.Types.ObjectId,
      ref: "Circles",
    },
  },
  {
    timestamps: {
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    },
  }
);
memberSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

memberSchema.set("toJSON", {
  virtuals: true,
});

memberSchema.index({ "member.name": "text" });

memberSchema.plugin(paginate);

export default model<IMember>("Member", memberSchema);
