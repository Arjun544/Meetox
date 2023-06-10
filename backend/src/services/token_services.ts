import { IncomingMessage } from "http";
import jwt from "jsonwebtoken";
import { TokenResponse } from "../utils/types";

/**
 * Generates a JSON Web Token (JWT) for the given payload using the JWT_ACCESS_TOKEN_SECRET
 * environment variable as the secret to sign the token. The token expires after 7 days.
 *
 * @param {object} payload - The data to be included in the token
 * @return {object} An object containing the generated token
 */
export function generateToken(payload: {}): any {
  const token = jwt.sign(payload, process.env.JWT_ACCESS_TOKEN_SECRET!, {
    expiresIn: "7d",
  });

  return { token };
}

/**
 * Decodes a token received from a request's authorization header and returns
 * a TokenResponse object containing the token and its decoded payload.
 *
 * @param {IncomingMessage} req - The incoming request object.
 * @param {boolean} [requireAuth=true] - Flag to indicate if authentication is required.
 * @return {TokenResponse} - The token and decoded payload.
 * @throws {Error} - If authorization header is missing and requireAuth is true.
 */
export function decodeToken(
  req: IncomingMessage,
  requireAuth: boolean = true
): TokenResponse {
  const header = req.headers.authorization;
  if (!requireAuth) {
    return { id: null, token: null };
  } else {
    if (header) {
      const token = header.replace("Bearer ", "");

      const { id } = jwt.verify(
        token,
        process.env.JWT_ACCESS_TOKEN_SECRET!
      ) as jwt.JwtPayload;

      return { id, token };
    } else {
      throw new Error("Login in to access resource");
    }
  }
}

/**
 * Retrieves the ID from a JSON Web Token.
 *
 * @param {string} token - The JSON Web Token to retrieve the ID from.
 * @return {String} The ID retrieved from the JSON Web Token.
 */
export function getIdFromToken(token: string): String {
  const { id } = jwt.verify(
    token,
    process.env.JWT_ACCESS_TOKEN_SECRET!
  ) as jwt.JwtPayload;
  return id;
}
