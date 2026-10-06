// To parse this JSON data, do
//
//     final deviceProviderListModel = deviceProviderListModelFromJson(jsonString);

import 'dart:convert';

DeviceProviderListModel deviceProviderListModelFromJson(String str) =>
    DeviceProviderListModel.fromJson(json.decode(str));

String deviceProviderListModelToJson(DeviceProviderListModel data) =>
    json.encode(data.toJson());

class DeviceProviderListModel {
  bool status;
  String? message;
  List<DevicePlist> devicePlist;

  DeviceProviderListModel({
    required this.status,
    required this.message,
    required this.devicePlist,
  });

  factory DeviceProviderListModel.fromJson(Map<String, dynamic> json) =>
      DeviceProviderListModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        devicePlist: json["device_plist"] == null
            ? []
            : List<DevicePlist>.from(
                json["device_plist"].map((x) => DevicePlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "device_plist": List<dynamic>.from(devicePlist.map((x) => x.toJson())),
      };
}

class DevicePlist {
  String? id;
  String? providerName;

  DevicePlist({
    required this.id,
    required this.providerName,
  });

  factory DevicePlist.fromJson(Map<String, dynamic> json) => DevicePlist(
        id: json["id"]?.toString(),
        providerName: json["provider_name"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provider_name": providerName,
      };
}
