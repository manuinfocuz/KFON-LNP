// To parse this JSON data, do
//
//     final cafTypeDataModel = cafTypeDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:kfon_lnp/data_model/subscriber/sub_type_model.dart';
import 'package:kfon_lnp/data_model/subscriber/sub_type_model.dart';
import 'package:kfon_lnp/data_model/subscriber/sub_type_model.dart';

CafTypeDataModel cafTypeDataModelFromJson(String str) =>
    CafTypeDataModel.fromJson(json.decode(str));

String cafTypeDataModelToJson(CafTypeDataModel data) =>
    json.encode(data.toJson());

class CafTypeDataModel {
  bool status;
  String? message;
  List<Caftype> caftypes;

  CafTypeDataModel({
    required this.status,
    required this.message,
    required this.caftypes,
  });

  factory CafTypeDataModel.fromJson(Map<String, dynamic> json) =>
      CafTypeDataModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        caftypes: json["caftypes"] == null
            ? []
            : List<Caftype>.from(
                json["caftypes"].map((x) => Caftype.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "caftypes": List<dynamic>.from(caftypes.map((x) => x.toJson())),
      };
}

class Caftype {
  String? cafname;
  String? caftypeid;
  bool isExpended;
  List<Stype> sType;

  Caftype({
    required this.cafname,
    required this.caftypeid,
    this.isExpended = false,
    required this.sType,
  });

  factory Caftype.fromJson(Map<String, dynamic> json) => Caftype(
        cafname: json["cafname"]?.toString(),
        caftypeid: json["caftypeid"]?.toString(),
        isExpended: false,
        sType: [],
      );

  Map<String, dynamic> toJson() => {
        "cafname": cafname,
        "caftypeid": caftypeid,
      };
}
