// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

class MemberModel {
  String? typename;
  Members? members;

  MemberModel({
    this.typename,
    this.members,
  });

  factory MemberModel.fromRawJson(String str) =>
      MemberModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        typename: json["__typename"],
        members:
            json["members"] == null ? null : Members.fromJson(json["members"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "members": members?.toJson(),
      };
}

class Members {
  String? typename;
  int? page;
  dynamic nextPage;
  dynamic prevPage;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? totalPages;
  int? totalResults;
  List<User>? members;

  Members({
    this.typename,
    this.page,
    this.nextPage,
    this.prevPage,
    this.hasNextPage,
    this.hasPrevPage,
    this.totalPages,
    this.totalResults,
    this.members,
  });

  factory Members.fromRawJson(String str) => Members.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Members.fromJson(Map<String, dynamic> json) => Members(
        typename: json["__typename"],
        page: json["page"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        members: json["members"] == null
            ? []
            : List<User>.from(json["members"]!.map((x) => User.fromJson(x))),
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
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
      };
}
