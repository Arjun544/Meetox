import { Schema, model } from "mongoose";
import paginate from "mongoose-paginate-v2";
import { IQuestion } from "../utils/interfaces/question";

const questionSchema = new Schema(
  {
    question: {
      type: String,
      required: true,
    },
    admin: {
      type: Schema.Types.ObjectId,
      ref: "Users",
    },
    likes: {
      type: Array,
      default: [],
    },
    expiry: {
      type: Date,
      required: true,
      default: new Date(new Date().setHours(new Date().getHours() + 24)), //Adding next 24 hours
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
questionSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

questionSchema.set("toJSON", {
  virtuals: true,
});

questionSchema.index({ question: "text" });

questionSchema.index({ expiry: 1 }, { expireAfterSeconds: 0 });

questionSchema.plugin(paginate);

export default model<IQuestion>("Questions", questionSchema);
