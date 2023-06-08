import merge from "lodash.merge";
import authResolvers from "./auth";
import userResolvers from "./user";
import circleResolvers from "./circle";
import questionResolvers from "./question";

const resolvers = merge(
  {},
  authResolvers,
  userResolvers,
  circleResolvers,
  questionResolvers
);

export default resolvers;
