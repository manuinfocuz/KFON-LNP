// To parse this JSON data, do
//
//     final gstinModel = gstinModelFromJson(jsonString);

import 'dart:convert';

GstinModel gstinModelFromJson(String str) =>
    GstinModel.fromJson(json.decode(str));

String gstinModelToJson(GstinModel data) => json.encode(data.toJson());

class GstinModel {
  bool? status;
  String? gststatus;
  String? taxpayertype;
  String? taxpayertypeName;
  String? tradename;
  String? legalname;
  String? message;

  GstinModel({
    this.status,
    this.gststatus,
    this.taxpayertype,
    this.taxpayertypeName,
    this.tradename,
    this.legalname,
    this.message,
  });

  factory GstinModel.fromJson(Map<String, dynamic> json) => GstinModel(
        status: json["status"],
        gststatus: json["gststatus"]?.toString(),
        taxpayertype: json["taxpayertype"]?.toString(),
        taxpayertypeName: json["taxpayertype_name"]?.toString(),
        tradename: json["tradename"]?.toString(),
        legalname: json["legalname"]?.toString(),
        message: json["Message"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "gststatus": gststatus,
        "taxpayertype": taxpayertype,
        "taxpayertype_name": taxpayertypeName,
        "tradename": tradename,
        "legalname": legalname,
        "Message": message,
      };
}
