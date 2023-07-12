import gql from "graphql-tag";

const typeDefs = gql`
  scalar IMessage

  type Mutation {
    sendMessage(
      id: String!
      message: String!
      type: String!
      latitude: Float
      longitude: Float
    ): IMessage
  }

  type Query {
    messages(
      id: String!
      text: String
      page: Int!
      limit: Int!
    ): MessagesResponse
  }

  type MessagesResponse {
    page: Int
    nextPage: Int
    prevPage: Int
    hasNextPage: Boolean
    hasPrevPage: Boolean
    total_pages: Int
    total_results: Int
    messages: [IMessage]
  }
`;

export default typeDefs;
