import merge from "lodash.merge";
import authResolvers from "./auth";
import userResolvers from "./user";
import followResolvers from "./follow";
import circleResolvers from "./circle";
import questionResolvers from "./question";
import conversationResolvers from "./conversation";
import messageResolvers from "./message";

const resolvers = merge(
  {},
  authResolvers,
  userResolvers,
  followResolvers,
  circleResolvers,
  questionResolvers,
  conversationResolvers,
  messageResolvers
);

export default resolvers;
