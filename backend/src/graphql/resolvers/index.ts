import merge from "lodash.merge";
import authResolvers from "./auth";
import userResolvers from "./user";
import followResolvers from "./follow";
import circleResolvers from "./circle";
import questionResolvers from "./question";

const resolvers = merge(
  {},
  authResolvers,
  userResolvers,
  followResolvers,
  circleResolvers,
  questionResolvers
);

export default resolvers;
