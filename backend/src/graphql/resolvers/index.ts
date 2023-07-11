import merge from "lodash.merge";
import authResolvers from "./auth";
import userResolvers from "./user";
import followResolvers from "./follow";
import circleResolvers from "./circle";
import questionResolvers from "./question";
import conversationResolvers from "./conversation";

const resolvers = merge(
  {},
  authResolvers,
  userResolvers,
  followResolvers,
  circleResolvers,
  questionResolvers,
  conversationResolvers
);

export default resolvers;
