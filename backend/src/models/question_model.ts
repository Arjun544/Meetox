import { Schema, model } from "mongoose";
import { IQuestion } from "../utils/interfaces/question";
import paginate from "mongoose-paginate-v2";

const questionSchema = new Schema(
  {
    question: {
      type: String,
      required: true,
    },
    answers: [
      {
        type: Map,
        default: {
          answer: "",
          user: {
            type: Schema.Types.ObjectId,
            ref: "Users",
          },
        },
      },
    ],
    admin: {
      type: Schema.Types.ObjectId,
      ref: "Users",
    },
    upvotes: [
      {
        type: Map,
        default: {
          votes: {
            type: Number,
            default: 0,
          },
          user: {
            type: Schema.Types.ObjectId,
            ref: "Users",
          },
        },
      },
    ],
    downvotes: [
      {
        type: Map,
        default: {
          votes: {
            type: Number,
            default: 0,
          },
          user: {
            type: Schema.Types.ObjectId,
            ref: "Users",
          },
        },
      },
    ],
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

questionSchema.plugin(paginate);

export default model<IQuestion>("Questions", questionSchema);
