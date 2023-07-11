// Generate one to one converation model for chat
import { Schema, model } from "mongoose";
import paginate from "mongoose-paginate-v2";
import { IConversation } from "../utils/interfaces/conversation";

const extraSchema = new Schema({
  participant: {
    type: Schema.Types.ObjectId,
    ref: "Users",
    required: true,
  },
  hasSeenLastMessage: {
    type: Boolean,
    required: true,
  },
});

const conversationSchema = new Schema(
  {
    participants: [
      {
        type: Schema.Types.ObjectId,
        ref: "Users",
        required: true,
      },
    ],
    extra: [extraSchema],
    lastMessage: {
      type: Schema.Types.ObjectId,
      ref: "Messages",
    },
  },
  {
    timestamps: {
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    },
  }
);

conversationSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

conversationSchema.set("toJSON", {
  virtuals: true,
});

conversationSchema.index({ "participants.name": "text" });

conversationSchema.plugin(paginate);

export default model<IConversation>("Conversations", conversationSchema);
