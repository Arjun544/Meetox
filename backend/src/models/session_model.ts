import { Schema, model } from "mongoose";
import { IUser } from "../utils/interfaces/user";

const sessionSchema = new Schema(
  {
    token: {
      type: String,
      unique: true,
    },
    user: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
    expires: {
      type: Date,
      default: Date.now(),
    },
    address: {
      type: JSON,
    },
  },
  {
    timestamps: {
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    },
  }
);
sessionSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

sessionSchema.set("toJSON", {
  virtuals: true,
});

// userSchema.plugin(paginate);

export default model<IUser>("Sessions", sessionSchema);
