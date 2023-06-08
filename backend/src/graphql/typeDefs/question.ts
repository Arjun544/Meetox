import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IQuestion
  scalar ILocation

  type Query {
    getNearByQuestions(
      latitude: Float!
      longitude: Float!
      distanceInKM: Float!
    ): [IQuestion]
  }

  type Query {
    userQuestions(name: String, page: Int!, limit: Int!): QuestionsResponse
  }

  type Mutation {
    addQuestion(question: String!, location: ILocation!): IQuestion
    deleteQuestion(id: String!): IQuestion
  }

  type QuestionsResponse {
    page: Int
    nextPage: Int
    prevPage: Int
    hasNextPage: Boolean
    hasPrevPage: Boolean
    total_pages: Int
    total_results: Int
    questions: [IQuestion]
  }
`;

export default typeDefs;
