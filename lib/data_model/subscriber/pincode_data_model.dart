// To parse this JSON data, do
//
//     final pincodeDataModel = pincodeDataModelFromJson(jsonString);

import 'dart:convert';

PincodeDataModel pincodeDataModelFromJson(String str) =>
    PincodeDataModel.fromJson(json.decode(str));

String pincodeDataModelToJson(PincodeDataModel data) =>
    json.encode(data.toJson());

class PincodeDataModel {
  bool status;
  String? message;
  List<Pinlist> pinlist;

  PincodeDataModel({
    required this.status,
    required this.message,
    required this.pinlist,
  });

  factory PincodeDataModel.fromJson(Map<String, dynamic> json) =>
      PincodeDataModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        pinlist: json["pinlist"] == null
            ? []
            : List<Pinlist>.from(
                json["pinlist"].map((x) => Pinlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "pinlist": List<dynamic>.from(pinlist.map((x) => x.toJson())),
      };
}

class Pinlist {
  String? pincode;

  Pinlist({
    required this.pincode,
  });

  factory Pinlist.fromJson(Map<String, dynamic> json) => Pinlist(
        pincode: json["pincode"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "pincode": pincode,
      };
}
