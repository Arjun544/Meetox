// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

class MessageModel {
  String? typename;
  Messages? messages;

  MessageModel({
    this.typename,
    this.messages,
  });

  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        typename: json["__typename"],
        messages: json["messages"] == null
            ? null
            : Messages.fromJson(json["messages"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "messages": messages?.toJson(),
      };
}

class Messages {
  String? typename;
  int? page;
  dynamic nextPage;
  dynamic prevPage;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? totalPages;
  int? totalResults;
  List<Message>? messages;

  Messages({
    this.typename,
    this.page,
    this.nextPage,
    this.prevPage,
    this.hasNextPage,
    this.hasPrevPage,
    this.totalPages,
    this.totalResults,
    this.messages,
  });

  factory Messages.fromRawJson(String str) =>
      Messages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        typename: json["__typename"],
        page: json["page"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
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
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  String? id;
  String? message;
  String? type;
  double? latitude;
  double? longitude;
  dynamic sender;
  String? conversationId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? messageId;

  Message({
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
    this.messageId,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        message: json["message"],
        type: json["type"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
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
        messageId: json["id"],
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
        "id": messageId,
      };
}
