import { Schema, model } from "mongoose";
import { IUser } from "../utils/interfaces/user";

const userSchema = new Schema(
  {
    name: {
      type: String,
      default: "",
    },
    email: {
      type: String,
      required: true,
      unique: true,
    },
    display_pic: {
      type: Map,
      of: String,
      default: {
        profile: "",
        profileId: "",
      },
    },
    birthDate: {
      type: Date,
      default: Date.now(),
    },
    isPremium: {
      type: Boolean,
      default: false,
    },
    isOnline: {
      type: Boolean,
      default: false,
    },
    passwordlessToken: {
      type: String,
      default: null,
    },
    passwordlessTokenExpires: {
      type: Date,
      default: null,
    },
    whatsAppToken: {
      type: String,
      default: null,
    },
    whatsAppTokenExpires: {
      type: Date,
      default: null,
    },
    socials: {
      type: Array,
      of: Map,
      default: [],
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
  },
  {
    timestamps: {
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    },
  }
);
userSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

userSchema.set("toJSON", {
  virtuals: true,
});

// userSchema.plugin(paginate);

export default model<IUser>("Users", userSchema);
