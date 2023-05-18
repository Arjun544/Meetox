import cloudinary, { UploadApiErrorResponse } from "cloudinary";
import { GraphQLError } from "graphql/error/GraphQLError";

export async function uploadImage(folder: string, photo: string) {
  cloudinary.v2.config({
    cloud_name: process.env.CLOUDINARY_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET,
  });
  try {
    const result = await cloudinary.v2.uploader.upload(photo, {
      allowed_formats: ["jpg", "png"],
      folder: folder,
    });
    return result;
  } catch (e: any) {
    throw new GraphQLError(e?.message);
    return `Image could not be uploaded: ${e.message}`;
  }
}
