import 'package:flutter/cupertino.dart';

class SubEnqListDataModel {
  SubEnqListDataModel({
    // required this.status,
    // required this.message,
    required this.headings,
    required this.enqlist,
    required this.searchParams,
    required this.totalRecords,
    // required this.totalPages,
    // required this.pageNum,
    // required this.perPage,
  });

  // final bool? status;
  // final String? message;
  final List<String> headings;
  final List<Enqlist> enqlist;
  late List<FilterData> searchParams;

  final String? totalRecords;
  // final int? totalPages;
  // final String? pageNum;
  // final int? perPage;

  factory SubEnqListDataModel.fromJson(Map<String, dynamic> json) {
    return SubEnqListDataModel(
      // status: json["status"],
      // message: json["Message"],
      headings: json["headings"] == null
          ? []
          : List<String>.from(json["headings"]!.map((x) => x)),
      enqlist: json["enqlist"] == null
          ? []
          : List<Enqlist>.from(
              json["enqlist"]!.map((x) => Enqlist.fromJson(x))),
      searchParams: json["search_params"] == null
          ? []
          : List<FilterData>.from(
              json["search_params"]!.map(
                (x) => FilterData(
                  headings: '$x',
                  controller: TextEditingController(),
                ),
              ),
            ),
       totalRecords: json["total_records"],
      // totalPages: json["total_pages"],
      // pageNum: json["page_num"],
      // perPage: json["per_page"],
    );
  }
}

class Enqlist {
  Enqlist({
    required this.id,
    required this.status,
    required this.name,
    required this.mobile,
    required this.email,
    required this.district,
    required this.location,
    required this.pincode,
    required this.connType,
    required this.trackingid,
    required this.createddate,
  });

  late String? id;
  late String? status;
  late String? name;
  late String? mobile;
  late String? email;
  late String? district;
  late String? location;
  late String? pincode;
  late String? connType;
  late String? trackingid;
  late String? createddate;

  factory Enqlist.fromJson(Map<String, dynamic> json) {
    return Enqlist(
      id: json["id"]?.toString(),
      status: json["status"]?.toString(),
      name: json["name"]?.toString(),
      mobile: json["mobile"]?.toString(),
      email: json["email"]?.toString(),
      district: json["district"]?.toString(),
      location: json["location"]?.toString(),
      pincode: json["pincode"]?.toString(),
      connType: json["connType"]?.toString(),
      trackingid: json["trackingid"]?.toString(),
      createddate: json["createddate"]?.toString(),
    );
  }
}

class FilterData {
  String? headings;
  TextEditingController controller;

  FilterData({required this.headings, required this.controller});
}
