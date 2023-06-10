import { PaginateModel, model } from "mongoose";
import Circle from "../models/circle_model";
import { ICircle } from "../utils/interfaces/circle";

/**
 * Retrieves all circles within a certain distance from a given latitude and longitude.
 *
 * @param {String} id - the id of the user who is not an admin of the circles to exclude
 * @param {number} latitude - the latitude to measure distance from
 * @param {number} longitude - the longitude to measure distance from
 * @param {number} distanceInKM - the distance in kilometers from the given coordinates to search for circles
 * @return {Promise<Array>} - promise that resolves to an array of circles within the specified distance
 */
export async function nearbyCircles(
  id: String,
  latitude: number,
  longitude: number,
  distanceInKM: number
): Promise<Array<ICircle>> {
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

/**
 * Retrieves circles associated with a user ID and filters by name if provided.
 *
 * @param {String} id - The user ID.
 * @param {String} name - The name to filter circles by.
 * @param {number} page - The page number of the results.
 * @param {number} limit - The maximum number of results per page.
 * @return {Promise<Object>} Object containing pagination information and an array of circles.
 */
export async function userCircles(
  id: String,
  name: String,
  page: number,
  limit: number
): Promise<object> {
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

/**
 * Deletes a circle by ID.
 *
 * @param {String} id - The ID of the circle to delete.
 * @return {Promise} Returns a Promise that resolves to the deleted circle.
 */
export async function deleteCircle(id: String): Promise<ICircle> {
  const circle = await Circle.findByIdAndDelete(id).select(
    "name description image isPrivate members createdAt location limit"
  );
  console.log("deleted circle", circle);
  return circle as ICircle;
}
