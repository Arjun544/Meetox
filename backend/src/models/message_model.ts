// Generate one to one converation model for chat
import { Schema, model } from "mongoose";
import paginate from "mongoose-paginate-v2";
import { IMessage } from "../utils/interfaces/conversation";

const messageSchema = new Schema(
  {
    message: {
      type: String,
    },
    type: {
      type: String,
    },
    latitude: {
      type: Number,
    },
    longitude: {
      type: Number,
    },
    sender: {
      type: Schema.Types.ObjectId,
      ref: "Users",
    },
    conversationId: {
      type: Schema.Types.ObjectId,
      ref: "Conversations",
    },
  },
  {
    timestamps: {
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    },
  }
);

messageSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

messageSchema.set("toJSON", {
  virtuals: true,
});

messageSchema.index({ message: "text" });

messageSchema.plugin(paginate);

export default model<IMessage>("Messages", messageSchema);
