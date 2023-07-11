import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IMessage
  scalar IConversation
  scalar IImage

  type Mutation {
    createConversation(receiver: String!, message: String!): IConversation
    sendMessage(
      id: String!
      message: String!
      type: String!
      latitude: Float
      longitude: Float
    ): IMessage
  }

  type Query {
    hasConversation(sender: String!, receiver: String!): hasConversationResponse
    conversations(name: String, page: Int, limit: Int): ConversationsResponse
  }

  type ConversationsResponse {
    page: Int
    nextPage: Int
    prevPage: Int
    hasNextPage: Boolean
    hasPrevPage: Boolean
    total_pages: Int
    total_results: Int
    conversations: [IConversation]
  }

  type Conversation {
    _id: String
    participants: [IUser!]!
    # hasSeenLatestMessage: Boolean!
    lastMessage: IMessage
    createdAt: String!
    updatedAt: String!
  }

  type ReceiverResponse {
    name: String
    display_pic: IImage
  }

  type hasConversationResponse {
    hasConversation: Boolean
    conversation: IConversation
  }
`;

export default typeDefs;
