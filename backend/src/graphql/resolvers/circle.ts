import { IncomingMessage } from "http";
import Member from "../../models/member_model";
import {
  addCircle,
  circleMembers,
  deleteCircle,
  editCircle,
  nearbyCircles,
  userCircles,
} from "../../services/circle_services";
import { decodeToken } from "../../services/token_services";
import { GraphQLContext } from "../../utils/types";

const resolvers = {
  Mutation: {
    addCircle: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { name, description, image, isPrivate, limit, location, members } =
        args;
      const { id, token } = decodeToken(req as IncomingMessage);

      const cirlce = await addCircle(
        id as string,
        image,
        name,
        description,
        isPrivate,
        limit,
        location,
        members
      );
      return cirlce;
    },
    deleteCircle: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: circleId } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const circle = await deleteCircle(circleId as String);
      return circle;
    },
    editCircle: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const {
        id: circleId,
        name,
        description,
        imageId,
        image,
        isPrivate,
      } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const circle = await editCircle(
        circleId as String,
        image,
        imageId,
        name,
        description,
        isPrivate
      );
      return circle;
    },
    addMember: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: circleId } = args;
      const { id, token } = decodeToken(req as IncomingMessage);
      const member = new Member({
        member: id,
        circle: circleId,
      });
      await member.save();
      return member;
    },
    leaveMember: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: circleId } = args;
      const { id, token } = decodeToken(req as IncomingMessage);
      const member = await Member.findOneAndDelete({
        member: id,
        circle: circleId,
      });
      return member !== null;
    },
  },
  CircleResponse: {
    members: async (parent: { id: any }) => {
      const count = await Member.countDocuments({ circle: parent.id });
      return count;
    },
  },
  Query: {
    userCircles: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { name, page, limit } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const circles = await userCircles(id as String, name, page, limit);
      return circles;
    },
    getNearByCircles: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { latitude, longitude, distanceInKM, followers } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const circles = await nearbyCircles(
        id as String,
        latitude,
        longitude,
        distanceInKM
      );
      return circles;
    },
    isMember: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: circleId } = args;
      const { id, token } = decodeToken(req as IncomingMessage);
      const member = await Member.findOne({
        circle: circleId,
        member: id,
      });
      return member !== null;
    },
    members: async (_: any, args: any, context: GraphQLContext) => {
      const { req } = context;
      const { id: circleId, name, page, limit } = args;
      const { id } = decodeToken(req as IncomingMessage);

      const members = await circleMembers(circleId, name, page, limit);
      return members;
    },
  },
  //   Subscription: {
  //     locationUpdated: {
  //       subscribe: withFilter(
  //         (_: any, __: any, context: GraphQLContext) => {
  //           const { pubsub } = context;

  //           return pubsub.asyncIterator(["LOCATION_UPDATED"]);
  //         },
  //         (payload: any, _, context: GraphQLContext) => {
  //           return true;
  //         }
  //       ),
  //     },
  //   },
};

export default resolvers;
