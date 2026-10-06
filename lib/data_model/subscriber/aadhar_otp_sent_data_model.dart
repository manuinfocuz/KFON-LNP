// To parse this JSON data, do
//
//     final aadharOtpSentDataModel = aadharOtpSentDataModelFromJson(jsonString);

import 'dart:convert';

AadharOtpSentDataModel aadharOtpSentDataModelFromJson(String str) => AadharOtpSentDataModel.fromJson(json.decode(str));

String aadharOtpSentDataModelToJson(AadharOtpSentDataModel data) => json.encode(data.toJson());

class AadharOtpSentDataModel {
  bool status;
  String? message;
  String? txnid;
  String? aadhaarnumber;
  String? reqsid;

  AadharOtpSentDataModel({
    required this.status,
    required this.message,
    required this.txnid,
    required this.aadhaarnumber,
    required this.reqsid,
  });

  factory AadharOtpSentDataModel.fromJson(Map<String, dynamic> json) => AadharOtpSentDataModel(
    status: json["status"],
    message: json["Message"]?.toString(),
    txnid: json["txnid"]?.toString(),
    aadhaarnumber: json["aadhaarnumber"]?.toString(),
    reqsid: json["reqsid"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "Message": message,
    "txnid": txnid,
    "aadhaarnumber": aadhaarnumber,
    "reqsid": reqsid,
  };
}
