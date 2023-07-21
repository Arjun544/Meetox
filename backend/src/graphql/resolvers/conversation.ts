import { IncomingMessage } from "http";
import {
  createConversation,
  getConversations,
} from "../../services/conversation_services";
import { decodeToken } from "../../services/token_services";
import { IConversation } from "../../utils/interfaces/conversation";
import { GraphQLContext } from "../../utils/types";
import { GraphQLError } from "graphql";
import Conversation from "../../models/conversation_model";
import { withFilter } from "graphql-subscriptions/dist/with-filter";

const resolvers = {
  Mutation: {
    createConversation: async (_: any, args: any, context: GraphQLContext) => {
      const { req, pubsub } = context;
      const { receiver, message, type, latitude, longitude } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const newConversation: IConversation | null = await createConversation(
        pubsub,
        id as string,
        receiver,
        message,
        type,
        latitude,
        longitude
      );

      return newConversation;
    },
    hasConversation: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { sender, receiver } = args;
      const { id } = decodeToken(req as IncomingMessage);
      try {
        const conversation: IConversation | null = await Conversation.findOne({
          participants: { $all: [sender, receiver] },
        }).populate([
          {
            path: "participants",
            match: { _id: { $ne: id } },
            select: "id name display_pic",
          },
          {
            path: "lastMessage",
          },
        ]);

        return {
          hasConversation: !!conversation,
          conversation: conversation,
        };
      } catch (error: any) {
        throw new GraphQLError("Failed to check conversation existence");
      }
    },
  },
  Query: {
    conversations: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { name, page, limit } = args;
      const { id } = decodeToken(req as IncomingMessage);
      const allConversations = await getConversations(
        id as string,
        name,
        page,
        limit
      );
      return allConversations;
    },
  },

  Subscription: {
    conversationCreated: {
      subscribe: withFilter(
        (_: any, _args: any, context: GraphQLContext) => {
          const { pubsub } = context;
          return pubsub.asyncIterator("CONVERSATION_CREATED");
        },
        (payload: any, args: any, _context: GraphQLContext) => {
          const { id } = args;
          const { conversationCreated } = payload;
          const { participants } = conversationCreated;
          // Only participants of the conversation will be notified 
          const participantsIds = participants.map(
            (participant: { _id: any }) => participant._id.toString()
            );
          return participantsIds.includes(id);
        }
      ),
    },
  },
};

export default resolvers;
