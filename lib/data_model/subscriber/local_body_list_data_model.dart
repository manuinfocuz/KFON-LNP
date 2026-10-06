// To parse this JSON data, do
//
//     final localBodyListDataModel = localBodyListDataModelFromJson(jsonString);

import 'dart:convert';

LocalBodyListDataModel localBodyListDataModelFromJson(String str) =>
    LocalBodyListDataModel.fromJson(json.decode(str));

String localBodyListDataModelToJson(LocalBodyListDataModel data) =>
    json.encode(data.toJson());

class LocalBodyListDataModel {
  bool? status;
  String? message;
  List<LocalBodyList> localBodyList;

  LocalBodyListDataModel({
    required this.status,
    required this.message,
    required this.localBodyList,
  });

  factory LocalBodyListDataModel.fromJson(Map<String, dynamic> json) =>
      LocalBodyListDataModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        localBodyList: json["local_body_list"] == null
            ? []
            : List<LocalBodyList>.from(
                json["local_body_list"]!.map((x) => LocalBodyList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "local_body_list":
            List<dynamic>.from(localBodyList.map((x) => x.toJson())),
      };
}

class LocalBodyList {
  String? villageTypeId;
  String? villageType;

  LocalBodyList({
    required this.villageTypeId,
    required this.villageType,
  });

  factory LocalBodyList.fromJson(Map<String, dynamic> json) => LocalBodyList(
        villageTypeId: json["village_type_id"]?.toString(),
        villageType: json["village_type"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "village_type_id": villageTypeId,
        "village_type": villageType,
      };
}
