import { UploadApiResponse } from "cloudinary";
import { withFilter } from "graphql-subscriptions/dist/with-filter";
import { IncomingMessage } from "http";
import User from "../../models/user_model";
import { uploadImage } from "../../services/storage_services";
import { decodeToken, getIdFromToken } from "../../services/token_services";
import { nearbyUsers } from "../../services/user_services";
import { IUser } from "../../utils/interfaces/user";
import { GraphQLContext } from "../../utils/types";

const resolvers = {
  Mutation: {
    addProfile: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { name, birthDate, profile } = args;
      const { id, token } = decodeToken(req as IncomingMessage);

      const results: string | UploadApiResponse = await uploadImage(
        "User Profiles",
        profile
      );

      const response: UploadApiResponse = results as UploadApiResponse;

      const user: IUser | null = await User.findByIdAndUpdate(
        id,
        {
          name,
          birthDate,
          display_pic: {
            profileId: response.public_id,
            profile: response.secure_url,
          },
        },
        { new: true }
      );

      return user;
    },
    updateLocation: async (_: any, args: any, context: GraphQLContext) => {
      const { req, pubsub } = context;
      const { location } = args;
      const { id, token } = decodeToken(req as IncomingMessage);

      const user: IUser | null = await User.findByIdAndUpdate(
        id,
        {
          location: location,
        },
        { new: true }
      );

      return true;
    },
  },
  Query: {
    getUser: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id, token } = decodeToken(req as IncomingMessage);

      const user: IUser | null = await User.findById(id).select(
        "email name birthDay display_pic isPremium location createdAt followers followings"
      );

      return user;
    },
    getNearByUsers: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { latitude, longitude, distanceInKM, followers } = args;
      const { id, token } = decodeToken(req as IncomingMessage);

      const users = await nearbyUsers(
        id as String,
        latitude,
        longitude,
        distanceInKM,
        followers
      );
      return users;
    },
  },
  // Subscription: {
  //   locationUpdated: {
  //     subscribe: withFilter(
  //       (payload: any, __: any, context: GraphQLContext) => {
  //         const { token, pubsub } = context;

  //         const userId = getIdFromToken(token);

  //         return pubsub.asyncIterator([`LOCATION_UPDATED:${userId}`]);
  //       },
  //       (payload: any, _, context: GraphQLContext) => {
  //         return true;
  //       }
  //     ),
  //   },
  // },
};

export default resolvers;
