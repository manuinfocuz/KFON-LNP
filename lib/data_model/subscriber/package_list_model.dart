// To parse this JSON data, do
//
//     final packageListModel = packageListModelFromJson(jsonString);

import 'dart:convert';

PackageListModel packageListModelFromJson(String str) =>
    PackageListModel.fromJson(json.decode(str));

String packageListModelToJson(PackageListModel data) =>
    json.encode(data.toJson());

class PackageListModel {
  bool status;
  String? message;
  List<List<dynamic>> plans;
  String currentValue;

  PackageListModel({
    required this.status,
    required this.message,
    required this.plans,
    required this.currentValue,
  });

  factory PackageListModel.fromJson(Map<String, dynamic> json) =>
      PackageListModel(
          status: json["status"],
          message: json["Message"],
          plans: json["plans"] != null
              ? List<List<dynamic>>.from(
                  json["plans"].map(
                    (x) => List<dynamic>.from(
                      x.map((x) => x),
                    ),
                  ),
                )
              : [],
          currentValue: "");

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "plans": List<dynamic>.from(
          plans.map(
            (x) => List<dynamic>.from(
              x.map((x) => x),
            ),
          ),
        ),
        "current_value": currentValue
      };
}
