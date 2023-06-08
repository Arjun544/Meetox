import { PaginateModel, model } from "mongoose";
import Question from "../models/question_model";
import { IQuestion } from "../utils/interfaces/question";

export async function nearbyQuestions(
  id: String,
  latitude: number,
  longitude: number,
  distanceInKM: number
) {
  const radius = distanceInKM / 6378.1;
  const questions = await Question.find({
    admin: { $ne: id },
    "location.coordinates": {
      $geoWithin: { $centerSphere: [[latitude, longitude], radius] },
    },
  }).select("name answers owner upvotes downvotes expiry createdAt location");

  return questions;
}

export async function userQuestions(
  id: String,
  question: String,
  page: number,
  limit: number
) {
  const query =
    question === null
      ? {
          admin: id,
        }
      : {
          admin: id,
          $text: { $search: question as string },
        };
  const option = {
    lean: true,
    sort: { createdAt: -1 },
    page: page,
    limit: limit,
  };

  const newQuestion = model<IQuestion, PaginateModel<IQuestion>>("Questions");

  const result = await newQuestion.paginate(query, option);
  return {
    page: result.page,
    nextPage: result.nextPage,
    prevPage: result.prevPage,
    hasNextPage: result.hasNextPage,
    hasPrevPage: result.hasPrevPage,
    total_pages: result.totalPages,
    total_results: result.totalDocs,
    questions: result.docs,
  };
}

export async function deleteQuestion(id: String) {
  const question = await Question.findByIdAndDelete(id).select(
    "name answers owner upvotes downvotes expiry createdAt location"
  );
  return question;
}
