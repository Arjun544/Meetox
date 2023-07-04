import { PaginateModel, model } from "mongoose";
import Question from "../models/question_model";
import Answer from "../models/answer_model";
import { IQuestion } from "../utils/interfaces/question";
import { IAnswer } from "../utils/interfaces/answer";

/**
 * Returns an array of questions nearby a specific location based on the given
 * latitude, longitude, and distance in kilometers.
 *
 * @param {String} id - the id of the user requesting the questions
 * @param {number} latitude - the latitude of the user's location
 * @param {number} longitude - the longitude of the user's location
 * @param {number} distanceInKM - the radius of the area in kilometers
 * @return {Promise<Array>} an array of questions with their respective details
 */
export async function nearbyQuestions(
  id: String,
  latitude: number,
  longitude: number,
  distanceInKM: number
): Promise<Array<IQuestion>> {
  const radius = distanceInKM / 6378.1;
  const questions = await Question.find({
    admin: { $ne: id },
    "location.coordinates": {
      $geoWithin: { $centerSphere: [[latitude, longitude], radius] },
    },
  }).select("question admin likes expiry createdAt location");

  return questions;
}

/**
 * Retrieves a paginated list of questions based on the provided admin ID,
 * question text, page number, and limit per page.
 *
 * @param {String} id - the admin ID to retrieve questions for
 * @param {String} question - the text to search for in the questions, or null to retrieve all questions
 * @param {number} page - the page number to retrieve (starting at 1)
 * @param {number} limit - the number of questions to retrieve per page
 * @return {Object} an object containing pagination information and an array of questions
 */
export async function userQuestions(
  id: String,
  question: String,
  page: number,
  limit: number
): Promise<object> {
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

/**
 * Deletes a question by its id.
 * @param {string} id - The id of the question to be deleted.
 * @returns {Promise} - A promise that resolves with the deleted question.
 */
export async function deleteQuestion(id: String): Promise<any> {
  const question = await Question.findByIdAndDelete(id).select(
    "question answers admin likes expiry createdAt location"
  );
  return question;
}

export async function getAnswers(
  id: String,
  page: number,
  limit: number
): Promise<object> {
  const query = {
    question: id,
  };
  const option = {
    lean: true,
    sort: { createdAt: -1 },
    populate: {
      path: "user",
      select: "id name display_pic isPremium",
    },
    page: page,
    limit: limit,
  };

  const answer = model<IAnswer, PaginateModel<IQuestion>>("Answer");

  const result = await answer.paginate(query, option);
  return {
    page: result.page,
    nextPage: result.nextPage,
    prevPage: result.prevPage,
    hasNextPage: result.hasNextPage,
    hasPrevPage: result.hasPrevPage,
    total_pages: result.totalPages,
    total_results: result.totalDocs,
    answers: result.docs,
  };
}

export async function likeQuestion(
  userId: String,
  id: String
): Promise<Boolean> {
  try {
    const question = await Question.findById(id);
    if (!question) {
      throw new Error("Question not found");
    }

    const userLiked = question.likes.some((like) => like.toString() === userId);
    if (userLiked) {
      // Unlike post
      question.likes = question.likes.filter(
        (like) => like.toString() !== userId
      ) as [string];
    } else {
      // Like post
      question.likes.push(userId as string);
    }

    await question.save();

    return true;
  } catch (error) {
    console.log(error);
    throw new Error("Failed to toggle like on question");
  }
}

export async function likeAnswer(userId: String, id: String): Promise<Boolean> {
  try {
    const answer = await Answer.findById(id);
    if (!answer) {
      throw new Error("Answer not found");
    }

    const userLiked = answer.likes.some((like) => like.toString() === userId);
    if (userLiked) {
      // Unlike post
      answer.likes = answer.likes.filter(
        (like) => like.toString() !== userId
      ) as [string];
    } else {
      // Like post
      answer.likes.push(userId as string);
    }

    await answer.save();

    return true;
  } catch (error) {
    console.log(error);
    throw new Error("Failed to toggle like on answer");
  }
}
