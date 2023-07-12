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

const resolvers = {
  Mutation: {
    createConversation: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { receiver, message } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const newConversation: IConversation | null = await createConversation(
        id as string,
        receiver,
        message
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
        });

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

  //   Subscription: {
  //     locationUpdated: {
  //       subscribe: withFilter(
  //         (_: any, __: any, context: GraphQLContext) => {
  //           const { pubsub } = context;

  //           return pubsub.asyncIterator(["LOCATION_UPDATED"]);
  //         },
  //         (payload: any, _, context: GraphQLContext) => {
  //           return true;
  //         }
  //       ),
  //     },
  //   },
};

export default resolvers;
