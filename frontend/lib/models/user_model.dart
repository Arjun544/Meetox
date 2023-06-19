// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  UserModel({
    this.typename,
    this.loginWithGmail,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(
        json.decode(str) as Map<String, UserModel>,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        typename: json['__typename'] as String,
        loginWithGmail: json['loginWithGmail'] == null
            ? null
            : LoginWithGmail.fromJson(
                json['loginWithGmail'] as Map<String, dynamic>,
              ),
      );
  String? typename;
  LoginWithGmail? loginWithGmail;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        '__typename': typename,
        'loginWithGmail': loginWithGmail?.toJson(),
      };
}

class LoginWithGmail {
  LoginWithGmail({
    this.typename,
    this.token,
    this.user,
  });

  factory LoginWithGmail.fromRawJson(String str) => LoginWithGmail.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory LoginWithGmail.fromJson(Map<String, dynamic> json) => LoginWithGmail(
        typename: json['__typename'] as String,
        token: json['token'] as String,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );
  String? typename;
  String? token;
  User? user;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        '__typename': typename,
        'token': token,
        'user': user?.toJson(),
      };
}

class User {
  User({
    this.location,
    this.id,
    this.name,
    this.email,
    this.displayPic,
    this.isPremium,
    this.createdAt,
    this.userId,
    this.followers,
    this.followings,
  });

  factory User.fromRawJson(String str) => User.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        location: json['location'] == null
            ? null
            : Location.fromJson(
                json['location'] as Map<String, dynamic>,
              ),
        id: json['id'] ?? json['_id'],
        name: json['name'] as String,
        email: json['email'] ?? '',
        displayPic: json['display_pic'] == null
            ? null
            : DisplayPic.fromJson(json['display_pic'] as Map<String, dynamic>),
        isPremium: json['isPremium'] as bool,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        userId: json['id']?? "",
        followers: json['followers'] ?? 0,
        followings: json['followings'] ?? 0,
      );
  Location? location;
  String? id;
  String? name;
  String? email;
  DisplayPic? displayPic;
  bool? isPremium;
  DateTime? createdAt;
  String? userId;
  int? followers;
  int? followings;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        '_id': id,
        'name': name,
        'email': email,
        'display_pic': displayPic?.toJson(),
        'isPremium': isPremium,
        'createdAt': createdAt?.toIso8601String(),
        'id': userId,
      };
}

class DisplayPic {
  DisplayPic({
    this.profile,
    this.profileId,
  });

  factory DisplayPic.fromRawJson(String str) => DisplayPic.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory DisplayPic.fromJson(Map<String, dynamic> json) => DisplayPic(
        profile: json['profile'] as String,
        profileId: json['profileId'] as String,
      );
  String? profile;
  String? profileId;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'profile': profile,
        'profileId': profileId,
      };
}

class Location {
  Location({
    this.address,
    this.coordinates,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str) as Map<String, dynamic>);

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json['address'] as String,
        coordinates: json['coordinates'] == null
            ? []
            : List<double>.from(
                json['coordinates']!.map((x) => x?.toDouble()).toList()
                    as List<dynamic>,
              ),
      );
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
