import { withFilter } from "graphql-subscriptions/dist/with-filter";
import { IncomingMessage } from "http";
import Question from "../../models/question_model";
import { decodeToken } from "../../services/token_services";
import { IQuestion } from "../../utils/interfaces/question";
import { GraphQLContext } from "../../utils/types";
import {
  nearbyQuestions,
  userQuestions,
  deleteQuestion,
} from "../../services/question_services";

const resolvers = {
  Mutation: {
    addQuestion: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { question: name, location } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const question: IQuestion | null = await Question.create({
        question: name,
        admin: id,
        location,
      });

      return question;
    },
    deleteQuestion: async (_: any, args: any, context: GraphQLContext) => {
      const { id: questionId } = args;

      const question = await deleteQuestion(questionId as String);
      return question;
    },
  },
  Query: {
    userQuestions: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { name, page, limit } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const questions = await userQuestions(id as String, name, page, limit);
      return questions;
    },
    getNearByQuestions: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { latitude, longitude, distanceInKM, followers } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const questions = await nearbyQuestions(
        id as String,
        latitude,
        longitude,
        distanceInKM
      );
      return questions;
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
