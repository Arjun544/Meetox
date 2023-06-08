import { PaginateModel, model } from "mongoose";
import Circle from "../models/circle_model";
import { ICircle } from "../utils//interfaces/circle";

export async function nearbyCircles(
  id: String,
  latitude: number,
  longitude: number,
  distanceInKM: number
) {
  const radius = distanceInKM / 6378.1;
  const circles = await Circle.find({
    admin: { $ne: id },
    "location.coordinates": {
      $geoWithin: { $centerSphere: [[latitude, longitude], radius] },
    },
  }).select(
    "name description image isPrivate members createdAt location limit"
  );

  return circles;
}

export async function userCircles(
  id: String,
  name: String,
  page: number,
  limit: number
) {
  console.log("name: " + name);
  const query =
    name === null
      ? {
          admin: id,
        }
      : {
          admin: id,
          $text: { $search: name as string },
        };
  const option = {
    lean: true,
    sort: { createdAt: -1 },
    page: page,
    limit: limit,
  };

  const circle = model<ICircle, PaginateModel<ICircle>>("Circles");

  const result = await circle.paginate(query, option);
  return {
    page: result.page,
    nextPage: result.nextPage,
    prevPage: result.prevPage,
    hasNextPage: result.hasNextPage,
    hasPrevPage: result.hasPrevPage,
    total_pages: result.totalPages,
    total_results: result.totalDocs,
    circles: result.docs,
  };
}

export async function deleteCircle(id: String) {
  const circle = await Circle.findByIdAndDelete(id).select(
    "name description image isPrivate members createdAt location limit"
  );
  console.log("deleted circle", circle);
  return circle;
}
