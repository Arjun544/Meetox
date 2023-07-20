import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IConversation
  scalar IImage

  type Mutation {
    createConversation(
      receiver: String!
      message: String!
      type: String!
      latitude: Float
      longitude: Float
    ): IConversation
    hasConversation(sender: String!, receiver: String!): hasConversationResponse
  }

  type Query {
    conversations(name: String, page: Int, limit: Int): ConversationsResponse
  }

  type Subscription {
    conversationCreated: IConversation
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

  type hasConversationResponse {
    hasConversation: Boolean
    conversation: IConversation
  }
`;

export default typeDefs;
