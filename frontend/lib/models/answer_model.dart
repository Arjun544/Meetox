// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

class AnswerModel {
  String? typename;
  Answers? answers;

  AnswerModel({
    this.typename,
    this.answers,
  });

  factory AnswerModel.fromRawJson(String str) =>
      AnswerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        typename: json["__typename"],
        answers:
            json["answers"] == null ? null : Answers.fromJson(json["answers"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "answers": answers?.toJson(),
      };
}

class Answers {
  String? typename;
  List<Answer>? answers;
  bool? hasNextPage;
  bool? hasPrevPage;
  dynamic nextPage;
  int? page;
  dynamic prevPage;
  int? totalPages;
  int? totalResults;

  Answers({
    this.typename,
    this.answers,
    this.hasNextPage,
    this.hasPrevPage,
    this.nextPage,
    this.page,
    this.prevPage,
    this.totalPages,
    this.totalResults,
  });

  factory Answers.fromRawJson(String str) => Answers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
        typename: json["__typename"],
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(
                json["answers"]!.map((x) => Answer.fromJson(x))),
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
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
        "hasNextPage": hasNextPage,
        "hasPrevPage": hasPrevPage,
        "nextPage": nextPage,
        "page": page,
        "prevPage": prevPage,
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Answer {
  String? id;
  String? answer;
  String? questionId;
  User? user;
  int? upvotes;
  int? downvotes;
  DateTime? createdAt;
  DateTime? updatedAt;

  Answer({
    this.id,
    this.answer,
    this.user,
    this.upvotes,
    this.downvotes,
    this.createdAt,
    this.updatedAt,
    this.questionId,
  });

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["_id"] ?? json['id'],
        answer: json["answer"],
        user: User.fromJson(json["user"]),
        upvotes: json["upvotes"] ?? 0,
        downvotes: json["downvotes"] ?? 0,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        questionId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question": answer,
        "user": user,
        "upvotes": upvotes,
        "downvotes": downvotes,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": questionId,
      };
}
