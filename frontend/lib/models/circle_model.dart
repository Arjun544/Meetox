// To parse this JSON data, do
//
//     final circleModel = circleModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

class CircleModel {
  String? typename;
  UserCircles? userCircles;

  CircleModel({
    this.typename,
    this.userCircles,
  });

  factory CircleModel.fromRawJson(String str) =>
      CircleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CircleModel.fromJson(Map<String, dynamic> json) => CircleModel(
        typename: json["__typename"],
        userCircles: json["userCircles"] == null
            ? null
            : UserCircles.fromJson(json["userCircles"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "userCircles": userCircles?.toJson(),
      };
}

class UserCircles {
  String? typename;
  List<Circle>? circles;
  bool? hasNextPage;
  bool? hasPrevPage;
  dynamic nextPage;
  int? page;
  dynamic prevPage;
  int? totalPages;
  int? totalResults;

  UserCircles({
    this.typename,
    this.circles,
    this.hasNextPage,
    this.hasPrevPage,
    this.nextPage,
    this.page,
    this.prevPage,
    this.totalPages,
    this.totalResults,
  });

  factory UserCircles.fromRawJson(String str) =>
      UserCircles.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCircles.fromJson(Map<String, dynamic> json) => UserCircles(
        typename: json["__typename"],
        circles: json["circles"] == null
            ? []
            : List<Circle>.from(
                json["circles"]!.map((x) => Circle.fromJson(x))),
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
        "circles": circles == null
            ? []
            : List<dynamic>.from(circles!.map((x) => x.toJson())),
        "hasNextPage": hasNextPage,
        "hasPrevPage": hasPrevPage,
        "nextPage": nextPage,
        "page": page,
        "prevPage": prevPage,
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Circle {
  String? id;
  String? name;
  String? description;
  Image? image;
  bool? isPrivate;
  int? limit;
  String? admin;
  Location? location;
  List<String>? members;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? circleId;

  Circle({
    this.id,
    this.name,
    this.description,
    this.image,
    this.isPrivate,
    this.limit,
    this.admin,
    this.location,
    this.members,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.circleId,
  });

  factory Circle.fromRawJson(String str) => Circle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Circle.fromJson(Map<String, dynamic> json) => Circle(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        isPrivate: json["isPrivate"],
        limit: json["limit"],
        admin: json["admin"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        members: json["members"] == null
            ? []
            : List<String>.from(json["members"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        circleId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "image": image?.toJson(),
        "isPrivate": isPrivate,
        "limit": limit,
        "admin": admin,
        "location": location?.toJson(),
        "members":
            members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": circleId,
      };
}

class Image {
  String? image;
  String? imageId;

  Image({
    this.image,
    this.imageId,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json["image"],
        imageId: json["imageId"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "imageId": imageId,
      };
}

