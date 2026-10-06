// To parse this JSON data, do
//
//     final subscriberDetailsModel = subscriberDetailsModelFromJson(jsonString);

import 'dart:convert';

SubscriberDetailsModel subscriberDetailsModelFromJson(String str) =>
    SubscriberDetailsModel.fromJson(json.decode(str));

String subscriberDetailsModelToJson(SubscriberDetailsModel data) =>
    json.encode(data.toJson());

class SubscriberDetailsModel {
  bool status;

  // String message;
  List<String> headings;
  List<String> subData;
  bool allowTopup;
  bool pontPortMapped;
  final PonData? ponData;
  final String? subPonPortId;

  final String? onlAppId;
  final String? subId;
  final String? packageId;

  final OntData? ontData;
  final String? ontMapped;
  final String? deviceid;
  final bool showTopUp;
  final String? topUpMessage;
  final String? subStatus;

  SubscriberDetailsModel({
    required this.status,
    // required this.message,
    required this.headings,
    required this.subData,
    required this.allowTopup,
    required this.pontPortMapped,
    required this.ponData,
    required this.subPonPortId,
    required this.onlAppId,
    required this.subId,
    required this.packageId,
    required this.ontData,
    required this.ontMapped,
    required this.deviceid,
    required this.showTopUp,
    required this.topUpMessage,
    required this.subStatus,
  });

  factory SubscriberDetailsModel.fromJson(Map<String, dynamic> json) =>
      SubscriberDetailsModel(
        status: json["status"],
        // message: json["Message"],
        headings: json["headings"] != null
            ? List<String>.from(json["headings"].map((x) => x))
            : [],
        subData: json["sub_data"] != null
            ? List<String>.from(json["sub_data"].map((x) => x))
            : [],
        allowTopup: json["allow_topup"] ?? false,
        pontPortMapped: json["pont_port_mapped"] ?? false,
        ponData: json["pon_data"] == null || json["pon_data"] is List
            ? null
            : PonData.fromJson(json["pon_data"]),
        subPonPortId: json["subponportid"]?.toString(),
        onlAppId: json["onl_app_id"]?.toString(),
        subId: json["subid"]?.toString(),
        packageId: json["packageid"]?.toString(),

        ontData: json["ont_data"] == null
            ? null
            : OntData.fromJson(json["ont_data"]),
        ontMapped: json["ont_mapped"]?.toString(),
        deviceid: json["deviceid"]?.toString(),
        showTopUp: json["show_topup"] ?? false,
        topUpMessage:
            (json["topup_message"] ?? json["topupmessage"])?.toString(),
        subStatus: json["sub_status"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        //   "Message": message,
        "headings": List<dynamic>.from(headings.map((x) => x)),
        "sub_data": List<dynamic>.from(subData.map((x) => x)),
        "allow_topup": allowTopup,
        "pont_port_mapped": pontPortMapped,
        "pon_data": ponData?.toJson(),
        "subponportid": subPonPortId,
        "onl_app_id": onlAppId,
        "subid": subId,
        "packageid": packageId,
        "ont_data": ontData?.toJson(),
        "ont_mapped": ontMapped,
        "deviceid": deviceid,
        "show_topup": showTopUp,
        "topup_message": topUpMessage,
        "sub_status": subStatus,
      };
}

class PonData {
  PonData({
    required this.oltSerialNumber,
    required this.oltMacAddress,
    required this.ponPortNumber,
    required this.ontPosition,
  });

  final String? oltSerialNumber;
  final String? oltMacAddress;
  final String? ponPortNumber;
  final String? ontPosition;

  factory PonData.fromJson(Map<String, dynamic> json) {
    return PonData(
      oltSerialNumber: json["OLT Serial Number"],
      oltMacAddress: json["OLT Mac Address"],
      ponPortNumber: json["PON Port Number"],
      ontPosition: json["ONT Position"],
    );
  }

  Map<String, dynamic> toJson() => {
        "OLT Serial Number": oltSerialNumber,
        "OLT Mac Address": oltMacAddress,
        "PON Port Number": ponPortNumber,
        "ONT Position": ontPosition,
      };
}

class OntData {
  OntData({
    required this.deviceProvider,
    required this.deviceType,
    required this.deviceMake,
    required this.deviceCategory,
    required this.deviceModel,
    required this.gponSerialNumber,
    required this.deviceSerialNumber,
    required this.macAddress,
  });

  final String? deviceProvider;
  final String? deviceType;
  final String? deviceMake;
  final String? deviceCategory;
  final String? deviceModel;
  final String? gponSerialNumber;
  final String? deviceSerialNumber;
  final String? macAddress;

  factory OntData.fromJson(Map<String, dynamic> json) {
    return OntData(
      deviceProvider: json["Device Provider"],
      deviceType: json["Device Type"],
      deviceMake: json["Device Make"],
      deviceCategory: json["Device Category"],
      deviceModel: json["Device Model"],
      gponSerialNumber: json["GPON Serial Number"],
      deviceSerialNumber: json["Device Serial Number"],
      macAddress: json["Mac Address"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Device Provider": deviceProvider,
        "Device Type": deviceType,
        "Device Make": deviceMake,
        "Device Category": deviceCategory,
        "Device Model": deviceModel,
        "GPON Serial Number": gponSerialNumber,
        "Device Serial Number": deviceSerialNumber,
        "Mac Address": macAddress,
      };
}

// class DeviceListDataModel {
//   DeviceListDataModel({
//     required this.ontData,
//     required this.ontMapped,
//     required this.deviceid,
//   });
//
//   final OntData? ontData;
//   final bool? ontMapped;
//   final String? deviceid;
//
//   factory DeviceListDataModel.fromJson(Map<String, dynamic> json) {
//     return DeviceListDataModel(
//       ontData:
//           json["ont_data"] == null ? null : OntData.fromJson(json["ont_data"]),
//       ontMapped: json["ont_mapped"],
//       deviceid: json["deviceid"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "ont_data": ontData?.toJson(),
//         "ont_mapped": ontMapped,
//         "deviceid": deviceid,
//       };
// }
