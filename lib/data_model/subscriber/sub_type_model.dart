// To parse this JSON data, do
//
//     final subTypeModel = subTypeModelFromJson(jsonString);

import 'dart:convert';

SubTypeModel subTypeModelFromJson(String str) =>
    SubTypeModel.fromJson(json.decode(str));

String subTypeModelToJson(SubTypeModel data) => json.encode(data.toJson());

class SubTypeModel {
  bool status;
  String? message;
  List<Stype> stypes;

  SubTypeModel({
    required this.status,
    required this.message,
    required this.stypes,
  });

  factory SubTypeModel.fromJson(Map<String, dynamic> json) => SubTypeModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        stypes: json["stypes"] == null
            ? []
            : List<Stype>.from(json["stypes"].map((x) => Stype.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "stypes": List<dynamic>.from(stypes.map((x) => x.toJson())),
      };
}

class Stype {
  String? profileid;
  String? profilename;

  Stype({
    required this.profileid,
    required this.profilename,
  });

  factory Stype.fromJson(Map<String, dynamic> json) => Stype(
        profileid: json["profileid"]?.toString(),
        profilename: json["profilename"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "profileid": profileid,
        "profilename": profilename,
      };
}
