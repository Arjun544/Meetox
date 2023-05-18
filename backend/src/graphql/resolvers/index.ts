import merge from "lodash.merge";
import authResolvers from "./auth";
import userResolvers from "./user";

const resolvers = merge({}, authResolvers, userResolvers);

export default resolvers;
