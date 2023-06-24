import { PaginateModel, model } from "mongoose";
import Follow from "../models/follow_model";
import { IFollow } from "../utils/interfaces/follow";

export async function userFollowers(
  id: String,
  name: String,
  page: number,
  limit: number
): Promise<object> {
  const query =
    name === null
      ? {
          follower: id,
        }
      : {
          follower: id,
          $text: { $search: name as string },
        };
  const option = {
    lean: true,
    sort: { createdAt: -1 },
    populate: {
      path: "follower",
      select: "id name display_pic isPremium location createdAt updatedAt",
    },
    page: page,
    limit: limit,
  };

  const follow = model<IFollow, PaginateModel<IFollow>>("Follow");

  const result = await follow.paginate(query, option);
  return {
    page: result.page,
    nextPage: result.nextPage,
    prevPage: result.prevPage,
    hasNextPage: result.hasNextPage,
    hasPrevPage: result.hasPrevPage,
    total_pages: result.totalPages,
    total_results: result.totalDocs,
    followers: result.docs.map((doc) => doc.follower),
  };
}
export async function userFollowing(
  id: String,
  name: String,
  page: number,
  limit: number
): Promise<object> {
  const query =
    name === null
      ? {
          following: id,
        }
      : {
          following: id,
          $text: { $search: name as string },
        };
  const option = {
    lean: true,
    sort: { createdAt: -1 },
    populate: {
      path: "following",
      select: "id name display_pic isPremium location createdAt updatedAt",
    },
    page: page,
    limit: limit,
  };

  const follow = model<IFollow, PaginateModel<IFollow>>("Follow");

  const result = await follow.paginate(query, option);
  return {
    page: result.page,
    nextPage: result.nextPage,
    prevPage: result.prevPage,
    hasNextPage: result.hasNextPage,
    hasPrevPage: result.hasPrevPage,
    total_pages: result.totalPages,
    total_results: result.totalDocs,
    following: result.docs.map((doc) => doc.following),
  };
}

export async function nearbyFollowers(
  id: String,
  latitude: number,
  longitude: number,
  distanceInKM: number
): Promise<Array<Object>> {
  const radius = distanceInKM / 6378.1;
  const followers = await Follow.find({
    following: id,
  }).populate({
    path: "follower",
    select: "id name display_pic isPremium location createdAt updatedAt",
    match: {
      "location.coordinates": {
        $geoWithin: { $centerSphere: [[latitude, longitude], radius] },
      },
    },
  });
  return followers.map((doc) => doc.follower);
}
