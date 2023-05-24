import merge from "lodash.merge";
import authResolvers from "./auth";
import userResolvers from "./user";
import circleResolvers from "./circle";

const resolvers = merge({}, authResolvers, userResolvers, circleResolvers);

export default resolvers;
