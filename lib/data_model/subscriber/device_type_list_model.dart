// To parse this JSON data, do
//
//     final deviceTypeListModel = deviceTypeListModelFromJson(jsonString);

import 'dart:convert';

DeviceTypeListModel deviceTypeListModelFromJson(String str) =>
    DeviceTypeListModel.fromJson(json.decode(str));

String deviceTypeListModelToJson(DeviceTypeListModel data) =>
    json.encode(data.toJson());

class DeviceTypeListModel {
  bool status;
  String? message;
  List<DeviceTlist> deviceTlist;

  DeviceTypeListModel({
    required this.status,
    required this.message,
    required this.deviceTlist,
  });

  factory DeviceTypeListModel.fromJson(Map<String, dynamic> json) =>
      DeviceTypeListModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        deviceTlist: json["device_tlist"] == null
            ? []
            : List<DeviceTlist>.from(
                json["device_tlist"].map((x) => DeviceTlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "device_tlist": List<dynamic>.from(deviceTlist.map((x) => x.toJson())),
      };
}

class DeviceTlist {
  String? id;
  String? deviceTypeName;

  DeviceTlist({
    required this.id,
    required this.deviceTypeName,
  });

  factory DeviceTlist.fromJson(Map<String, dynamic> json) => DeviceTlist(
        id: json["id"]?.toString(),
        deviceTypeName: json["device_type_name"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_type_name": deviceTypeName,
      };
}
