import User from "../models/user_model";

export async function nearbyUsers(
  id: String,
  latitude: number,
  longitude: number,
  distanceInKM: number,
  followers: [String]
) {
  const radius = distanceInKM / 6378.1;
  const users = await User.find({
    _id: { $nin: followers != undefined ? [...followers, id] : id }, // excludes followers with ids & id
    "location.coordinates": {
      $geoWithin: { $centerSphere: [[latitude, longitude], radius] },
    },
  }).select("email name birthDay display_pic isPremium location createdAt");

  return users;
}
