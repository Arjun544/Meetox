// To parse this JSON data, do
//
//     final followerModel = followerModelFromJson(jsonString);

import 'dart:convert';

import 'package:frontend/models/user_model.dart';

class FollowerModel {
  String? typename;
  Followers? followers;

  FollowerModel({
    this.typename,
    this.followers,
  });

  factory FollowerModel.fromRawJson(String str) =>
      FollowerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
        typename: json["__typename"],
        followers: json["followers"] == null
            ? null
            : Followers.fromJson(json["followers"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "followers": followers?.toJson(),
      };
}

class Followers {
  String? typename;
  int? page;
  dynamic nextPage;
  dynamic prevPage;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? totalPages;
  int? totalResults;
  List<User>? followers;

  Followers({
    this.typename,
    this.page,
    this.nextPage,
    this.prevPage,
    this.hasNextPage,
    this.hasPrevPage,
    this.totalPages,
    this.totalResults,
    this.followers,
  });

  factory Followers.fromRawJson(String str) =>
      Followers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        typename: json["__typename"],
        page: json["page"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        followers: json["followers"] == null
            ? []
            : List<User>.from(json["followers"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "page": page,
        "nextPage": nextPage,
        "prevPage": prevPage,
        "hasNextPage": hasNextPage,
        "hasPrevPage": hasPrevPage,
        "total_pages": totalPages,
        "total_results": totalResults,
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x.toJson())),
      };
}
