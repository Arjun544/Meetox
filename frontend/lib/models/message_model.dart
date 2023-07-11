import 'dart:convert';

import 'package:frontend/models/user_model.dart';

class MessageModel {
  String? id;
  String? message;
  String? type;
  int? latitude;
  int? longitude;
  dynamic sender;
  String? conversationId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MessageModel({
    this.id,
    this.message,
    this.type,
    this.latitude,
    this.longitude,
    this.sender,
    this.conversationId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["_id"],
        message: json["message"],
        type: json["type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        sender: json["sender"].runtimeType == String
            ? json["sender"]
            : User.fromJson(json["sender"]),
        conversationId: json["conversationId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
        "sender": sender?.toJson(),
        "conversationId": conversationId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
