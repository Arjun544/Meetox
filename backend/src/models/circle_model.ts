import { Schema, model } from "mongoose";
import { ICircle } from "../utils/interfaces/circle";

const circleSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    image: {
      type: Map,
      of: String,
      default: {
        image: "",
        imageId: "",
      },
    },
    isPrivate: {
      type: Boolean,
      required: false,
    },
    limit: {
      type: Number,
      required: true,
    },
    admin: {
      type: Schema.Types.ObjectId,
      ref: "Users",
    },
    location: {
      type: {
        type: String,
        index: "2dsphere",
        enum: ["Point"],
      },
      address: {
        type: String,
        default: "",
      },
      coordinates: {
        type: [Number],
        required: true,
      },
    },
    members: [
      {
        type: Schema.Types.ObjectId,
        ref: "User",
      },
    ],
  },
  {
    timestamps: {
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    },
  }
);
circleSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

circleSchema.set("toJSON", {
  virtuals: true,
});

// userSchema.plugin(paginate);

export default model<ICircle>("Circles", circleSchema);
