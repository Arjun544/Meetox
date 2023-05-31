import { IncomingMessage } from "http";
import jwt from "jsonwebtoken";
import { TokenResponse } from "../utils/types";

export function generateToken(payload: {}) {
  const token = jwt.sign(payload, process.env.JWT_ACCESS_TOKEN_SECRET!, {
    expiresIn: "7d",
  });

  return { token };
}

export function decodeToken(
  req: IncomingMessage,
  requireAuth = true
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

export function getIdFromToken(token: string): String {
  const { id } = jwt.verify(
    token,
    process.env.JWT_ACCESS_TOKEN_SECRET!
  ) as jwt.JwtPayload;
  return id;
}
