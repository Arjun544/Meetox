import 'dart:convert';

import 'package:frontend/models/user_model.dart';

class FollowingModel {
  String? typename;
  Following? following;

  FollowingModel({
    this.typename,
    this.following,
  });

  factory FollowingModel.fromRawJson(String str) =>
      FollowingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowingModel.fromJson(Map<String, dynamic> json) => FollowingModel(
        typename: json["__typename"],
        following: json["following"] == null
            ? null
            : Following.fromJson(json["following"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "following": following?.toJson(),
      };
}

class Following {
  String? typename;
  int? page;
  dynamic nextPage;
  dynamic prevPage;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? totalPages;
  int? totalResults;
  List<User>? following;

  Following({
    this.typename,
    this.page,
    this.nextPage,
    this.prevPage,
    this.hasNextPage,
    this.hasPrevPage,
    this.totalPages,
    this.totalResults,
    this.following,
  });

  factory Following.fromRawJson(String str) =>
      Following.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Following.fromJson(Map<String, dynamic> json) => Following(
        typename: json["__typename"],
        page: json["page"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        following: json["followings"] == null
            ? []
            : List<User>.from(json["followings"]!.map((x) => User.fromJson(x))),
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
        "followings": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x.toJson())),
      };
}
