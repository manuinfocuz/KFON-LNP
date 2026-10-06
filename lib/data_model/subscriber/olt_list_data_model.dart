class OltListDataModel {
  OltListDataModel({
    // required this.status,
    // required this.message,
    required this.oltList,
  });

  // final bool? status;
  // final String? message;
  final List<OltList> oltList;

  factory OltListDataModel.fromJson(Map<String, dynamic> json) {
    return OltListDataModel(
      // status: json["status"],
      // message: json["Message"],
      oltList: json["olt_list"] == null
          ? []
          : List<OltList>.from(
              json["olt_list"]!.map((x) => OltList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        // "status": status,
        // "Message": message,
        "olt_list": oltList.map((x) => x?.toJson()).toList(),
      };
}

class OltList {
  OltList({
    required this.oltid,
    required this.deviceSerial,
  });

  final String? oltid;
  final String? deviceSerial;

  factory OltList.fromJson(Map<String, dynamic> json) {
    return OltList(
      oltid: json["oltid"]?.toString(),
      deviceSerial: json["device_serial"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "oltid": oltid,
        "device_serial": deviceSerial,
      };
}
