// To parse this JSON data, do
//
//     final conversationModel = conversationModelFromJson(jsonString);

import 'dart:convert';

import 'message_model.dart';
import 'user_model.dart';

class ConversationModel {
  String? typename;
  Conversations? conversations;

  ConversationModel({
    this.typename,
    this.conversations,
  });

  factory ConversationModel.fromRawJson(String str) =>
      ConversationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        typename: json["__typename"],
        conversations: json["conversations"] == null
            ? null
            : Conversations.fromJson(json["conversations"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "conversations": conversations?.toJson(),
      };
}

class Conversations {
  String? typename;
  int? page;
  dynamic nextPage;
  dynamic prevPage;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? totalPages;
  int? totalResults;
  List<Conversation>? conversations;

  Conversations({
    this.typename,
    this.page,
    this.nextPage,
    this.prevPage,
    this.hasNextPage,
    this.hasPrevPage,
    this.totalPages,
    this.totalResults,
    this.conversations,
  });

  factory Conversations.fromRawJson(String str) =>
      Conversations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversations.fromJson(Map<String, dynamic> json) => Conversations(
        typename: json["__typename"],
        page: json["page"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        conversations: json["conversations"] == null
            ? []
            : List<Conversation>.from(
                json["conversations"]!.map((x) => Conversation.fromJson(x))),
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
        "conversations": conversations == null
            ? []
            : List<dynamic>.from(conversations!.map((x) => x.toJson())),
      };
}

class Conversation {
  String? id;
  List<User>? participants;
  List<Extra>? extra;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Message? lastMessage;
  String? conversationId;

  Conversation({
    this.id,
    this.participants,
    this.extra,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastMessage,
    this.conversationId,
  });

  factory Conversation.fromRawJson(String str) =>
      Conversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["_id"],
        participants: json["participants"] == null
            ? []
            : List<User>.from(
                json["participants"]!.map((x) => User.fromJson(x))),
        extra: json["extra"] == null
            ? []
            : List<Extra>.from(json["extra"]!.map((x) => Extra.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        lastMessage: json["lastMessage"] == null
            ? null
            : Message.fromJson(json["lastMessage"]),
        conversationId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "participants": participants == null
            ? []
            : List<User>.from(participants!.map((x) => x.toJson())),
        "extra": extra == null
            ? []
            : List<dynamic>.from(extra!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "lastMessage": lastMessage?.toJson(),
        "id": conversationId,
      };
}

class Extra {
  String? participant;
  bool? hasSeenLastMessage;
  String? id;

  Extra({
    this.participant,
    this.hasSeenLastMessage,
    this.id,
  });

  factory Extra.fromRawJson(String str) => Extra.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        participant: json["participant"],
        hasSeenLastMessage: json["hasSeenLastMessage"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "participant": participant!,
        "hasSeenLastMessage": hasSeenLastMessage,
        "_id": id,
      };
}
