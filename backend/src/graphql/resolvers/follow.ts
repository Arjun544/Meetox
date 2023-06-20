import { IncomingMessage } from "http";
import Follow from "../../models/follow_model";
import { decodeToken } from "../../services/token_services";
import { GraphQLContext } from "../../utils/types";
import {
  nearbyFollowers,
  userFollowers,
  userFollowing,
} from "../../services/follow_services";

const resolvers = {
  Mutation: {
    follow: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: followingId } = args;
      const { id, token } = decodeToken(req as IncomingMessage);
      const follow = new Follow({
        follower: id,
        following: followingId,
      });
      await follow.save();
      return follow;
    },
    unFollow: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: followingId } = args;
      const { id, token } = decodeToken(req as IncomingMessage);
      const follow = await Follow.findOneAndDelete({
        follower: id,
        following: followingId,
      });
      return follow !== null;
    },
  },
  NearByFollowerResponse: {
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
    isFollowed: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: followingId } = args;
      const { id, token } = decodeToken(req as IncomingMessage);
      const follow = await Follow.findOne({
        follower: id,
        following: followingId,
      });
      return follow !== null;
    },
    followers: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: userId, name, page, limit } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const followers = await userFollowers(
        id as String,
        userId,
        name,
        page,
        limit
      );
      return followers;
    },
    following: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: userId, name, page, limit } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const followers = await userFollowing(
        id as String,
        userId,
        name,
        page,
        limit
      );
      return followers;
    },
    nearByFollowers: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { latitude, longitude, distanceInKM } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const followers = await nearbyFollowers(
        id as String,
        latitude,
        longitude,
        distanceInKM
      );
      return followers;
    },
  },
};

export default resolvers;
