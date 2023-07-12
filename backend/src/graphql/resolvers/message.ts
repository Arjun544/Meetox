import { IncomingMessage } from "http";
import { getMessages, sendMessage } from "../../services/message_services";
import { decodeToken } from "../../services/token_services";
import { IMessage } from "../../utils/interfaces/conversation";
import { GraphQLContext } from "../../utils/types";

const resolvers = {
  Mutation: {
    sendMessage: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: conversationId, message, type, latitude, longitude } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const newMessage: IMessage | null = await sendMessage(
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
