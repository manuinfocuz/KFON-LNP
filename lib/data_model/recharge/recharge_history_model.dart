// To parse this JSON data, do
//
//     final rechargeHistoryProvider = rechargeHistoryProviderFromJson(jsonString);

import 'dart:convert';

RechargeHistoryModel rechargeHistoryModelFromJson(String str) =>
    RechargeHistoryModel.fromJson(json.decode(str));

String rechargeHistoryModelToJson(RechargeHistoryModel data) =>
    json.encode(data.toJson());

class RechargeHistoryModel {
  bool? status;
  String? message;
  List<String>? headings;
  List<Tlist>? tlist;
  String? totalRecords;
  String? totalPages;
  String? pageNum;
  String? perPage;

  RechargeHistoryModel({
    this.status,
    this.message,
    this.headings,
    this.tlist,
    this.totalRecords,
    this.totalPages,
    this.pageNum,
    this.perPage,
  });

  factory RechargeHistoryModel.fromJson(Map<String, dynamic> json) =>
      RechargeHistoryModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        headings: json["headings"] == null
            ? []
            : List<String>.from(json["headings"]!.map((x) => x)),
        tlist: json["tlist"] == null
            ? []
            : List<Tlist>.from(json["tlist"]!.map((x) => Tlist.fromJson(x))),
        totalRecords: json["total_records"]?.toString(),
        totalPages: json["total_pages"]?.toString(),
        pageNum: json["page_num"]?.toString(),
        perPage: json["per_page"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "headings":
            headings == null ? [] : List<dynamic>.from(headings!.map((x) => x)),
        "tlist": tlist == null
            ? []
            : List<dynamic>.from(tlist!.map((x) => x.toJson())),
        "total_records": totalRecords,
        "total_pages": totalPages,
        "page_num": pageNum,
        "per_page": perPage,
      };
}

class Tlist {
  String? orderTime;
  String? amount;
  String? ordernumber;
  String? status;
  String? txnid;
  String? respmsg;
  String? pgwName;
  Map<String,dynamic>? jsonData;

  Tlist({
    this.orderTime,
    this.amount,
    this.ordernumber,
    this.status,
    this.txnid,
    this.respmsg,
    this.pgwName,
    this.jsonData,
  });

  factory Tlist.fromJson(Map<String, dynamic> json) => Tlist(
        orderTime: json["order_time"]?.toString(),
        amount: json["amount"]?.toString(),
        ordernumber: json["ordernumber"]?.toString(),
        status: json["status"]?.toString(),
        txnid: json["txnid"]?.toString(),
        respmsg: json["respmsg"]?.toString(),
        pgwName: json["pgw_name"]?.toString(),
        jsonData: json,
      );

  Map<String, dynamic> toJson() => {
        "order_time": orderTime,
        "amount": amount,
        "ordernumber": ordernumber,
        "status": status,
        "txnid": txnid,
        "respmsg": respmsg,
        "pgw_name": pgwName,
      };
}
