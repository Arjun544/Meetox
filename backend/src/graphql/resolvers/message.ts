import { IncomingMessage } from "http";
import { getMessages, sendMessage } from "../../services/message_services";
import { decodeToken } from "../../services/token_services";
import { IMessage } from "../../utils/interfaces/conversation";
import { GraphQLContext } from "../../utils/types";
import { withFilter } from "graphql-subscriptions/dist/with-filter";

const resolvers = {
  Mutation: {
    sendMessage: async (_: any, args: any, context: GraphQLContext) => {
      const { req, pubsub } = context;
      const { id: conversationId, message, type, latitude, longitude } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const newMessage: IMessage | null = await sendMessage(
        pubsub,
        id as string,
        conversationId as string,
        message,
        type,
        latitude,
        longitude
      );

      return newMessage;
    },
  },
  Query: {
    messages: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: converationId, text, page, limit } = args;
      const { id } = decodeToken(req as IncomingMessage);
      const allMessages = await getMessages(
        converationId as string,
        text,
        page,
        limit
      );
      return allMessages;
    },
  },

  Subscription: {
    conversationUpdated: {
      subscribe: withFilter(
        (_: any, args: any, context: GraphQLContext) => {
          const { pubsub } = context;
          const { id } = args;

          return pubsub.asyncIterator([`CONVERSATION_UPDATED_${id}`]);
        },
        (payload: any, _, context: GraphQLContext) => {
          return true;
        }
      ),
    },
    newMessage: {
      subscribe: withFilter(
        (_: any, args: any, context: GraphQLContext) => {
          const { pubsub } = context;
          const { id } = args;

          return pubsub.asyncIterator([`NEW_MESSAGE_${id}`]);
        },
        (payload: any, _, context: GraphQLContext) => {
          return true;
        }
      ),
    },
  },
};

export default resolvers;
