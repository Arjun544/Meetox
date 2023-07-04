import { UploadApiResponse } from "cloudinary";
import { PaginateModel, model } from "mongoose";
import Circle from "../models/circle_model";
import Member from "../models/member_model";
import { ICircle } from "../utils/interfaces/circle";
import { IMember } from "../utils/interfaces/member";
import { deleteImage, uploadImage } from "./storage_services";

/**
 * Adds a circle to the database.
 *
 * @param {String} id - The ID of the circle.
 * @param {String} image - The image URL of the circle.
 * @param {String} name - The name of the circle.
 * @param {String} description - The description of the circle.
 * @param {Boolean} isPrivate - Whether the circle is private or not.
 * @param {number} limit - The member limit of the circle.
 * @param {any} location - The location of the circle.
 * @param {Array<String>} members - The members of the circle.
 * @return {Promise<CircleResponse>} The created circle object.
 */
export async function addCircle(
  id: String,
  image: String,
  name: String,
  description: String,
  isPrivate: Boolean,
  limit: number,
  location: any,
  members: [String]
): Promise<ICircle> {
  const results: string | UploadApiResponse = await uploadImage(
    "Circles Profiles",
    image as string
  );

  const response: UploadApiResponse = results as UploadApiResponse;

  const circle: ICircle | null = await Circle.create({
    name,
    description,
    image: {
      image: response.secure_url,
      imageId: response.public_id,
    },
    admin: id,
    isPrivate,
    limit,
    location,
  });

  for (const member in members) {
    if (Object.prototype.hasOwnProperty.call(members, member)) {
      const element = members[member];
      const newMember = new Member({
        member: element,
        circle: circle.id,
      });
      await newMember.save();
    }
  }

  return circle;
}

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
  })
    .select("name description image admin isPrivate createdAt location limit")
    .populate({
      path: "admin",
      select: "id name display_pic isPremium",
    });

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
  const circle: ICircle | null = await Circle.findByIdAndDelete(id);
  // Delete members of circle in Members collection
  await Member.deleteMany({ circle: id });

  if (circle && circle.image) {
    const imageId: string = circle.image.get("imageId");
    // Delete circle image from cloudinary
    const results: string | UploadApiResponse = await deleteImage(imageId);
    console.log("results", results);
  } else {
    console.log("No image found for the circle");
  }
  return circle as ICircle;
}

export async function circleMembers(
  id: String,
  name: String,
  page: number,
  limit: number
): Promise<any> {
  const query =
    name === null
      ? {
          circle: id,
        }
      : {
          circle: id,
          $text: { $search: name as string },
        };
  const option = {
    lean: true,
    sort: { createdAt: -1 },
    populate: {
      path: "member",
      select: "id name display_pic isPremium location createdAt updatedAt",
    },
    page: page,
    limit: limit,
  };

  const member = model<IMember, PaginateModel<IMember>>("Member");

  const result = await member.paginate(query, option);
  return {
    page: result.page,
    nextPage: result.nextPage,
    prevPage: result.prevPage,
    hasNextPage: result.hasNextPage,
    hasPrevPage: result.hasPrevPage,
    total_pages: result.totalPages,
    total_results: result.totalDocs,
    members: result.docs.map((doc) => doc.member),
  };
}
