// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  bool status;
  bool tokenExpired;
  String token;

  TokenModel({
    required this.status,
    required this.tokenExpired,
    required this.token,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        status: json["status"],
        tokenExpired: json["token_expired"],
        token: json["token"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token_expired": tokenExpired,
        "token": token,
      };
}
