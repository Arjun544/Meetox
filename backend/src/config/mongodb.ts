import { connect } from "mongoose";

export async function connectToDatabase() {
  try {
    await connect(process.env.mongodb_URL!);
    console.log(" 🚀🚀🚀 Connected to database 🚀🚀🚀");
  } catch (error) {
    console.error("😭😭😭 Database connection error 😭😭😭");
  }
}
