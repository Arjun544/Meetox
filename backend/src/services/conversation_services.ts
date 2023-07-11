import Message from "../models/message_model";
import Conversation from "../models/conversation_model";
import {
  IConversation,
  IExtra,
  IMessage,
} from "../utils/interfaces/conversation";
import { PaginateModel, model, Types } from "mongoose";

export async function createConversation(
  sender: any,
  receiver: any,
  message: string
): Promise<IConversation> {
  const participants = [sender, receiver];
  const newConversation = await Conversation.create({
    participants: participants,
    extra: participants.map((participant) => ({
      participant,
      hasSeenLastMessage: participant === sender,
    })),
  });

  const newMessage: IMessage | null = await Message.create({
    message: message,
    type: "text",
    latitude: 0,
    longitude: 0,
    sender: sender,
    conversationId: newConversation.id,
  });

  // Update lastMessage of the conversation
  const updatedConversation: IConversation | null =
    await Conversation.findByIdAndUpdate(
      newConversation.id,
      {
        lastMessage: newMessage,
      },
      { new: true }
    )
      .populate({
        path: "participants",
        match: { _id: receiver },
        select: "id name display_pic",
      })
      .populate({
        path: "lastMessage",
      });

  return updatedConversation as IConversation;
}

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

export async function getConversations(
  id: String,
  name: String,
  page: number,
  limit: number
): Promise<any> {
  console.log(name)
  const query =
    name === null
      ? {
          participants: id,
        }
      : {
          participants: id,
          $text: { $search: name as string },
        };
  const option = {
    lean: true,
    sort: { "lastMessage.timestamp": -1 },
    populate: [
      {
        path: "participants",
        match: { _id: {$ne: id} },
        select: "id name display_pic",
      },
      {
        path: "lastMessage",
      },
    ],
    page: page,
    limit: limit,
  };

  const conversation = model<IConversation, PaginateModel<IConversation>>(
    "Conversations"
  );

  const result = await conversation.paginate(query, option);

  return {
    page: result.page,
    nextPage: result.nextPage,
    prevPage: result.prevPage,
    hasNextPage: result.hasNextPage,
    hasPrevPage: result.hasPrevPage,
    total_pages: result.totalPages,
    total_results: result.totalDocs,
    conversations: result.docs,
  };
}
