// To parse this JSON data, do
//
//     final kycApplicationListModel = kycApplicationListModelFromJson(jsonString);

import 'dart:convert';

KycApplicationListModel kycApplicationListModelFromJson(String str) =>
    KycApplicationListModel.fromJson(json.decode(str));

String kycApplicationListModelToJson(KycApplicationListModel data) =>
    json.encode(data.toJson());

class KycApplicationListModel {
  bool? status;
  String? message;
  List<String>? headings;
  List<Klist>? klist;
  int? totalRecords;
  int? totalPages;
  String? pageNum;
  int? perPage;

  KycApplicationListModel({
    this.status,
    this.message,
    this.headings,
    this.klist,
    this.totalRecords,
    this.totalPages,
    this.pageNum,
    this.perPage,
  });

  factory KycApplicationListModel.fromJson(Map<String, dynamic> json) =>
      KycApplicationListModel(
        status: json["status"],
        message: json["Message"],
        headings: json["headings"] == null
            ? []
            : List<String>.from(json["headings"]!.map((x) => x)),
        klist: json["klist"] == null
            ? []
            : List<Klist>.from(json["klist"]!.map((x) => Klist.fromJson(x))),
        totalRecords: json["total_records"],
        totalPages: json["total_pages"],
        pageNum: json["page_num"],
        perPage: json["per_page"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "headings":
            headings == null ? [] : List<dynamic>.from(headings!.map((x) => x)),
        "klist": klist == null
            ? []
            : List<dynamic>.from(klist!.map((x) => x.rawData)),
        "total_records": totalRecords,
        "total_pages": totalPages,
        "page_num": pageNum,
        "per_page": perPage,
      };
}

class Klist {
  String? id;
  DateTime? createDate;
  String? apno;
  String? firstname;
  String? mobileno;
  String? status;
  String? address;
  String? kycType;
  String? nextStatus;
  Map<String, dynamic>? rawData;
  Klist({
    this.id,
    this.createDate,
    this.apno,
    this.firstname,
    this.mobileno,
    this.status,
    this.address,
    this.kycType,
    this.nextStatus,
    this.rawData,
  });

  factory Klist.fromJson(Map<String, dynamic> json) => Klist(
      id: json["id"],
      createDate: json["create_date"] == null
          ? null
          : DateTime.parse(json["create_date"]),
      apno: json["apno"],
      firstname: json["firstname"],
      mobileno: json["mobileno"],
      status: json["status"],
      address: json["address"],
      kycType: json["kyc_type"],
      nextStatus: json['next_status'],
      rawData: json,
  );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "create_date":
  //           "${createDate!.day.toString().padLeft(2, '0')}-${createDate!.month.toString().padLeft(2, '0')}-${createDate!.year.toString().padLeft(4, '0')}",
  //       "apno": apno,
  //       "firstname": firstname,
  //       "mobileno": mobileno,
  //       "status": status,
  //       "address": address,
  //       "kyc_type": kycType,
  //       "next_status": nextStatus
  //     };
}
