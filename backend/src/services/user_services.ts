import Follow from "../models/follow_model";
import User from "../models/user_model";
import { IUser } from "../utils/interfaces/user";

/**
 * Retrieves a list of users within a certain distance from a location with the option to exclude certain users.
 * @param {String} id - the id of the user making the request
 * @param {number} latitude - the latitude of the center of the search area
 * @param {number} longitude - the longitude of the center of the search area
 * @param {number} distanceInKM - the maximum distance in kilometers from the center of the search area
 * @return {Promise<Array<User>>} an array of User objects that meet the search criteria
 */
export async function nearbyUsers(
  id: String,
  latitude: number,
  longitude: number,
  distanceInKM: number
): Promise<Array<IUser>> {
  const radius = distanceInKM / 6378.1;
  const followers = await Follow.find(
    {
      follower: id,
    },
    {
      lean: true,
    }
  ).select("following");

  const followingsIds = followers.map((doc) => doc.following);
  const users = await User.find({
    _id: { $nin: followingsIds != undefined ? [...followingsIds, id] : id }, // excludes followers with ids & id
    "location.coordinates": {
      $geoWithin: { $centerSphere: [[latitude, longitude], radius] },
    },
  }).select("name display_pic isPremium location createdAt updatedAt");

  return users;
}

export async function userSocials(id: String): Promise<any> {
  const user = await User.findOne({
    _id: id,
  }).select("socials");

  return user?.socials;
}
