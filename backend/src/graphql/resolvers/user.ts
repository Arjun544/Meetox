import { UploadApiResponse } from "cloudinary";
import { IncomingMessage } from "http";
import Follow from "../../models/follow_model";
import User from "../../models/user_model";
import { uploadImage } from "../../services/storage_services";
import { decodeToken } from "../../services/token_services";
import { nearbyUsers, userSocials } from "../../services/user_services";
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
      const { req } = context;
      const { location } = args;
      const { id, token } = decodeToken(req as IncomingMessage);

      await User.findByIdAndUpdate(
        id,
        {
          location: location,
        },
        { new: true }
      );

      return true;
    },
  },
  NearByUserResponse: {
    followers: async (parent: { id: any }) => {
      const count = await Follow.countDocuments({ following: parent.id });
      return count;
    },
    followings: async (parent: { id: any }) => {
      const count = await Follow.countDocuments({ follower: parent.id });
      return count;
    },
  },
  Query: {
    getUser: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id, token } = decodeToken(req as IncomingMessage);

      const user: IUser | null = await User.findById(id).select(
        "email name display_pic isPremium location createdAt updatedAt"
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
    socials: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: userId } = args;
      const { id, token } = decodeToken(req as IncomingMessage);

      const socials = await userSocials(userId as String);
      return socials;
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
