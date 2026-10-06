// To parse this JSON data, do
//
//     final oltListModel = oltListModelFromJson(jsonString);

import 'dart:convert';

OltListModel oltListModelFromJson(String str) =>
    OltListModel.fromJson(json.decode(str));

String oltListModelToJson(OltListModel data) => json.encode(data.toJson());

class OltListModel {
  bool status;
  String? message;
  List<Oltlist> oltlist;

  OltListModel({
    required this.status,
    required this.message,
    required this.oltlist,
  });

  factory OltListModel.fromJson(Map<String, dynamic> json) => OltListModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        oltlist: json["oltlist"] == null
            ? []
            : List<Oltlist>.from(
                json["oltlist"].map((x) => Oltlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "oltlist": List<dynamic>.from(oltlist.map((x) => x.toJson())),
      };
}

class Oltlist {
  String? oltType;
  String? oltTypeName;

  Oltlist({
    required this.oltType,
    required this.oltTypeName,
  });

  factory Oltlist.fromJson(Map<String, dynamic> json) => Oltlist(
        oltType: json["olt_type"]?.toString(),
        oltTypeName: json["olt_type_name"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "olt_type": oltType,
        "olt_type_name": oltTypeName,
      };
}
