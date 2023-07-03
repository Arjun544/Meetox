import { Schema, model } from "mongoose";
import { IAnswer } from "../utils/interfaces/answer";
import paginate from "mongoose-paginate-v2";

const answerSchema = new Schema(
  {
    answer: {
      type: String,
      required: true,
    },
    question: {
      type: Schema.Types.ObjectId,
      ref: "Questions",
    },
    user: {
      type: Schema.Types.ObjectId,
      ref: "Users",
    },
    likes: {
      type: Array,
      default: [],
    },
  },
  {
    timestamps: {
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    },
  }
);
answerSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

answerSchema.set("toJSON", {
  virtuals: true,
});

answerSchema.index({ "answer.answer": "text" });

answerSchema.plugin(paginate);

export default model<IAnswer>("Answer", answerSchema);
