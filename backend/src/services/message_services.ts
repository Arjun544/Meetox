import Message from "../models/message_model";
import Conversation from "../models/conversation_model";
import { IConversation, IMessage } from "../utils/interfaces/conversation";
import { PaginateModel, model } from "mongoose";

export async function sendMessage(
  id: string,
  conversationId: string,
  message: string,
  type: string,
  latitude: number,
  longitude: number
): Promise<IMessage> {
  const newMessage: IMessage | null = await Message.create({
    message: message,
    type: type,
    latitude: latitude,
    longitude: longitude,
    sender: id,
    conversationId: conversationId,
  });

  // Update lastMessage of the conversation
  await Conversation.findByIdAndUpdate(conversationId, {
    lastMessage: newMessage,
  });

  return newMessage;
}

export async function getMessages(
  id: String,
  text: String,
  page: number,
  limit: number
): Promise<any> {
  const query =
    text === null
      ? {
          conversationId: id,
        }
      : {
          conversationId: id,
          $text: { $search: text as string },
        };
  const option = {
    lean: true,
    sort: { createdAt: -1 },
    populate: {
      path: "sender",
      select: "id name display_pic",
    },
    page: page,
    limit: limit,
  };

  const message = model<IMessage, PaginateModel<IMessage>>("Messages");

  const result = await message.paginate(query, option);

  return {
    page: result.page,
    nextPage: result.nextPage,
    prevPage: result.prevPage,
    hasNextPage: result.hasNextPage,
    hasPrevPage: result.hasPrevPage,
    total_pages: result.totalPages,
    total_results: result.totalDocs,
    messages: result.docs,
  };
}
