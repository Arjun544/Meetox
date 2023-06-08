// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

class QuestionModel {
  String? typename;
  UserQuestions? userQuestions;

  QuestionModel({
    this.typename,
    this.userQuestions,
  });

  factory QuestionModel.fromRawJson(String str) =>
      QuestionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        typename: json["__typename"],
        userQuestions: json["userQuestions"] == null
            ? null
            : UserQuestions.fromJson(json["userQuestions"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "userQuestions": userQuestions?.toJson(),
      };
}

class UserQuestions {
  String? typename;
  List<Question>? questions;
  bool? hasNextPage;
  bool? hasPrevPage;
  dynamic nextPage;
  int? page;
  dynamic prevPage;
  int? totalPages;
  int? totalResults;

  UserQuestions({
    this.typename,
    this.questions,
    this.hasNextPage,
    this.hasPrevPage,
    this.nextPage,
    this.page,
    this.prevPage,
    this.totalPages,
    this.totalResults,
  });

  factory UserQuestions.fromRawJson(String str) =>
      UserQuestions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserQuestions.fromJson(Map<String, dynamic> json) => UserQuestions(
        typename: json["__typename"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
        nextPage: json["nextPage"],
        page: json["page"],
        prevPage: json["prevPage"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "hasNextPage": hasNextPage,
        "hasPrevPage": hasPrevPage,
        "nextPage": nextPage,
        "page": page,
        "prevPage": prevPage,
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Question {
  String? id;
  String? question;
  List<dynamic>? answers;
  String? admin;
  List<dynamic>? upvotes;
  List<dynamic>? downvotes;
  DateTime? expiry;
  Location? location;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? questionId;

  Question({
    this.id,
    this.question,
    this.answers,
    this.admin,
    this.upvotes,
    this.downvotes,
    this.expiry,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.questionId,
  });

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["_id"],
        question: json["question"],
        answers: json["answers"] == null
            ? []
            : List<dynamic>.from(json["answers"]!.map((x) => x)),
        admin: json["admin"],
        upvotes: json["upvotes"] == null
            ? []
            : List<dynamic>.from(json["upvotes"]!.map((x) => x)),
        downvotes: json["downvotes"] == null
            ? []
            : List<dynamic>.from(json["downvotes"]!.map((x) => x)),
        expiry: json["expiry"] == null ? null : DateTime.parse(json["expiry"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        questionId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question,
        "answers":
            answers == null ? [] : List<dynamic>.from(answers!.map((x) => x)),
        "admin": admin,
        "upvotes":
            upvotes == null ? [] : List<dynamic>.from(upvotes!.map((x) => x)),
        "downvotes": downvotes == null
            ? []
            : List<dynamic>.from(downvotes!.map((x) => x)),
        "expiry": expiry?.toIso8601String(),
        "location": location?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": questionId,
      };
}


