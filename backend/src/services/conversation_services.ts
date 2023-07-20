import Message from "../models/message_model";
import Conversation from "../models/conversation_model";
import { IConversation, IMessage } from "../utils/interfaces/conversation";
import { PaginateModel, model } from "mongoose";
import { PubSub } from "graphql-subscriptions/dist/pubsub";

export async function createConversation(
  pubsub: PubSub,
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

  // Publish the new conversation event
  pubsub.publish("CONVERSATION_CREATED", {
    conversationCreated: updatedConversation,
  });

  return updatedConversation as IConversation;
}

export async function getConversations(
  id: String,
  name: String,
  page: number,
  limit: number
): Promise<any> {
  console.log(name);
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
        match: { _id: { $ne: id } },
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
