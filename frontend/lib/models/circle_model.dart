// To parse this JSON data, do
//
//     final circleModel = circleModelFromJson(jsonString);

import 'dart:convert';

class CircleModel {
  CircleModel({
    this.data,
  });

  factory CircleModel.fromJson(Map<String, dynamic> json) => CircleModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  factory CircleModel.fromRawJson(String str) =>
      CircleModel.fromJson(json.decode(str) as Map<String, dynamic>);
  Data? data;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.userCircles,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userCircles: json['userCircles'] == null
            ? null
            : UserCircles.fromJson(json['userCircles'] as Map<String, dynamic>),
      );

  factory Data.fromRawJson(String str) =>
      Data.fromJson(json.decode(str) as Map<String, dynamic>);
  UserCircles? userCircles;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'userCircles': userCircles?.toJson(),
      };
}

class UserCircles {
  UserCircles({
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
      UserCircles.fromJson(json.decode(str) as Map<String, dynamic>);

  factory UserCircles.fromJson(Map<String, dynamic> json) => UserCircles(
        circles: json['circles'] == null
            ? []
            : List<Circle>.from(
                json['circles']!.map(Circle.fromJson) as List<Circle>,
              ),
        hasNextPage: json['hasNextPage'] as bool,
        hasPrevPage: json['hasPrevPage'] as bool,
        nextPage: json['nextPage'] as int,
        page: json['page'] as int,
        prevPage: json['prevPage'] as int,
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
      );
  List<Circle>? circles;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? nextPage;
  int? page;
  int? prevPage;
  int? totalPages;
  int? totalResults;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'circles': circles == null
            ? []
            : List<dynamic>.from(circles!.map((x) => x.toJson())),
        'hasNextPage': hasNextPage,
        'hasPrevPage': hasPrevPage,
        'nextPage': nextPage,
        'page': page,
        'prevPage': prevPage,
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}

class Circle {
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

  factory Circle.fromJson(Map<String, dynamic> json) => Circle(
        id: json['_id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        isPrivate: json['isPrivate'] as bool,
        limit: json['limit'] as int,
        admin: json['admin'] as String,
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        members: json['members'] == null
            ? []
            : List<String>.from(json['members']!.map((x) => x) as List<String>),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        circleId: json['id'] as String,
      );

  factory Circle.fromRawJson(String str) =>
      Circle.fromJson(json.decode(str) as Map<String, dynamic>);
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

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image?.toJson(),
        'isPrivate': isPrivate,
        'limit': limit,
        'admin': admin,
        'location': location?.toJson(),
        'members':
            members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'id': circleId,
      };
}

class Image {
  Image({
    this.image,
    this.imageId,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json['image'] as String,
        imageId: json['imageId'] as String,
      );

  factory Image.fromRawJson(String str) =>
      Image.fromJson(json.decode(str) as Map<String, dynamic>);
  String? image;
  String? imageId;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'image': image,
        'imageId': imageId,
      };
}

class Location {
  Location({
    this.address,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json['address'] as String,
        coordinates: json['coordinates'] == null
            ? []
            : List<double>.from(
                json['coordinates']!.map((x) => x?.toDouble()) as List<double>),
      );

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str) as Map<String, dynamic>);
  String? address;
  List<double>? coordinates;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'address': address,
        'coordinates': coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
