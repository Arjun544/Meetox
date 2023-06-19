import { PaginateModel, model } from "mongoose";
import { IFollow } from "../utils/interfaces/follow";

export async function userFollowers(
  id: String,
  userId: String,
  name: String,
  page: number,
  limit: number
): Promise<object> {
  const query =
    name === null
      ? {
          following: userId,
          follower: id,
        }
      : {
          following: userId,
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
  userId: String,
  name: String,
  page: number,
  limit: number
): Promise<object> {
  const query =
    name === null
      ? {
          following: userId,
          follower: id,
        }
      : {
          following: userId,
          follower: id,
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
