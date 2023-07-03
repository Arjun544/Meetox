import { withFilter } from "graphql-subscriptions/dist/with-filter";
import { IncomingMessage } from "http";
import Question from "../../models/question_model";
import Answer from "../../models/answer_model";
import { decodeToken } from "../../services/token_services";
import { IQuestion } from "../../utils/interfaces/question";
import { GraphQLContext } from "../../utils/types";
import {
  nearbyQuestions,
  userQuestions,
  deleteQuestion,
  getAnswers,
  likeQuestion,
  likeAnswer,
} from "../../services/question_services";
import { IAnswer } from "../../utils/interfaces/answer";

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
    addAnswer: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: questionId, answer } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const newAnswer: IAnswer | null = await Answer.create({
        question: questionId,
        answer: answer,
        user: id,
      });
      const populatedAnswer = await newAnswer.populate({
        path: "user",
        select: "id name display_pic isPremium",
      });
      return populatedAnswer;
    },
    toggleLikeQuestion: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: questionId } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const question = await likeQuestion(id as String, questionId as String);
      return question;
    },
    toggleLikeAnswer: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: answerId } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const answer = await likeAnswer(id as String, answerId as String);
      return answer;
    },
  },
  QuestionResponse: {
    answers: async (parent: { _id: any }) => {
      const count = await Answer.countDocuments({ question: parent._id });
      return count;
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
    answers: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: questionId, page, limit } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const answers = await getAnswers(questionId as String, page, limit);
      return answers;
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
