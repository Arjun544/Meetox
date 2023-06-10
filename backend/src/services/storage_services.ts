import cloudinary, { UploadApiErrorResponse } from "cloudinary";
import { GraphQLError } from "graphql/error/GraphQLError";

/**
 * Uploads an image to Cloudinary.
 *
 * @param {string} folder - the folder in which to store the image
 * @param {string} photo - the image to upload
 * @return {Promise<any>} - a promise to return the uploaded image object
 * @throws {GraphQLError} - if there is an error uploading the image
 */
export async function uploadImage(folder: string, photo: string): Promise<any> {
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
