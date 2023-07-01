import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IQuestion
  scalar IAnswer
  scalar ILocation

  type Query {
    getNearByQuestions(
      latitude: Float!
      longitude: Float!
      distanceInKM: Float!
    ): [QuestionResponse]
    userQuestions(name: String, page: Int!, limit: Int!): QuestionsResponse
    answers(id: String, page: Int!, limit: Int!): AnswersResponse
  }

  type Mutation {
    addQuestion(question: String!, location: ILocation!): IQuestion
    deleteQuestion(id: String!): IQuestion
    addAnswer(id: String!, answer: String!): IAnswer
  }

  type QuestionsResponse {
    page: Int
    nextPage: Int
    prevPage: Int
    hasNextPage: Boolean
    hasPrevPage: Boolean
    total_pages: Int
    total_results: Int
    questions: [QuestionResponse]
  }

  type QuestionResponse {
    id: String
    question: String
    location: ILocation
    answers: Int
    upvotes: Int
    downvotes: Int
    admin: AdminResponse
    expiry: Date
    createdAt: Date
    updatedAt: Date
  }

  type AdminResponse {
    _id: String
    name: String
    display_pic: IDisplayPic
    isPremium: Boolean
  }

  type AnswerResponse {
    id: String
    answer: String
    upvotes: Int
    downvotes: Int
    user: AdminResponse
    createdAt: Date
    updatedAt: Date
  }

  type AnswersResponse {
    page: Int
    nextPage: Int
    prevPage: Int
    hasNextPage: Boolean
    hasPrevPage: Boolean
    total_pages: Int
    total_results: Int
    answers: [AnswerResponse]
  }
`;

export default typeDefs;
