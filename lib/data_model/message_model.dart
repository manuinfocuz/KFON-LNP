// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  bool status;
  String? viewUrl;
  String? ticketId;
  String message;
  String? appno;

  MessageModel(
      {required this.status,
      required this.message,
      required this.viewUrl,
      required this.ticketId,
      required this.appno});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        status: json["status"],
        message: json["Message"] ?? "",
        viewUrl: json["view_url"] ?? "",
        ticketId: json["ticketid"]?.toString(),
        appno: json["appno"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "view_url": viewUrl,
        "ticketid": ticketId
      };
}
