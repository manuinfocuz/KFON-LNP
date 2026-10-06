// To parse this JSON data, do
//
//     final paymentGatewayDetails = paymentGatewayDetailsFromJson(jsonString);

import 'dart:convert';

PaymentGatewayDetails paymentGatewayDetailsFromJson(String str) =>
    PaymentGatewayDetails.fromJson(json.decode(str));

String paymentGatewayDetailsToJson(PaymentGatewayDetails data) =>
    json.encode(data.toJson());

class PaymentGatewayDetails {
  bool? status;
  String? pgwUrl;
  String? pgbreqStr;
  String? pgtuid;
  String? encryptedData;
  String? accessCode;
  String? message;

  PaymentGatewayDetails({
    this.status,
    this.pgwUrl,
    this.pgbreqStr,
    this.pgtuid,
    this.accessCode,
    this.encryptedData,
    this.message,
  });

  factory PaymentGatewayDetails.fromJson(Map<String, dynamic> json) =>
      PaymentGatewayDetails(
        status: json["status"],
        pgwUrl: json["pgw_url"]?.toString() ?? "",
        pgbreqStr: json["PGBREQ_STR"]?.toString() ?? "",
        pgtuid: json["PGTUID"]?.toString() ?? "",
        encryptedData: json["encrypted_data"]?.toString() ?? "",
        accessCode: json["access_code"]?.toString() ?? "",
        message: json["Message"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pgw_url": pgwUrl,
        "PGBREQ_STR": pgbreqStr,
        "PGTUID": pgtuid,
        "encrypted_data": encryptedData,
        "access_code": accessCode,
        "Message": message,
      };
}
