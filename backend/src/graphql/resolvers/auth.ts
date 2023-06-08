import { decodeToken, generateToken } from "../../services/token_services";
import { GraphQLContext } from "../../utils/types";
// import {
//   userById,
//   userByEmail,
//   updateUser,
// } from "../../services/user_services";
import { GraphQLError } from "graphql";
import { IncomingMessage } from "http";
import User from "../../models/user_model";
import { createSession } from "../../services/session_services";
import { ISession, IUser } from "../../utils/interfaces/user";

const resolvers = {
  Mutation: {
    loginWithGmail: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { email, address } = args;

      const { id, token } = decodeToken(req as IncomingMessage, false);

      if (!email) {
        throw new GraphQLError("Email is required");
      }

      try {
        const hasUser = await User.findOne({ email }).select(
          "email name display_pic isPremium location createdAt followers followings"
        );

        if (!hasUser) {
          //  Store new user
          const user: IUser = await User.create({ email });
          // Generate token
          const { token } = generateToken({
            id: user.id,
            name: user.name,
            email: user.email,
          });

          const data = {
            token: token,
            expires: new Date(Date.now() + 60 * 1000 * 10080), // expires in 7 days
            address: address,
            user: user.id,
            createdAt: new Date(Date.now()),
          };

          await createSession(data as ISession);

          return { token, user };
        } else {
          // Generate token
          const { token } = generateToken({
            id: hasUser.id,
            name: hasUser.name,
            email: hasUser.email,
          });

          const data = {
            token: token,
            expires: new Date(Date.now() + 60 * 1000 * 10080), // expires in 7 days
            address: address,
            user: hasUser.id,
            createdAt: new Date(Date.now()),
          };

          await createSession(data as ISession);

          return { token, user: hasUser };
        }
      } catch (error: any) {
        console.log("error", error);
        throw new GraphQLError(error?.message);
      }
    },
  },
  Query: {
    login: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id, token } = decodeToken(req as IncomingMessage, false);

      const user: IUser | null = await User.findById(
        "63b4c378ed06a7b0395aa97b"
      );

      return user;
    },
  },
};

export default resolvers;
