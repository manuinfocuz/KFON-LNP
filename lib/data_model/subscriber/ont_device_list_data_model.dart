class OntDeviceListDataModel {
  OntDeviceListDataModel({
    required this.status,
    required this.message,
    required this.devlist,
  });

  final bool? status;
  final String? message;
  final List<Devlist> devlist;

  factory OntDeviceListDataModel.fromJson(Map<String, dynamic> json) {
    return OntDeviceListDataModel(
      status: json["status"],
      message: json["Message"],
      devlist: json["devlist"] == null
          ? []
          : List<Devlist>.from(
              json["devlist"]!.map((x) => Devlist.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "devlist": devlist.map((x) => x.toJson()).toList(),
      };
}

class Devlist {
  Devlist({
    required this.deviceSlno,
    required this.deviceid,
  });

  final String? deviceSlno;
  final String? deviceid;

  factory Devlist.fromJson(Map<String, dynamic> json) {
    return Devlist(
      deviceSlno: json["device_slno"]?.toString(),
      deviceid: json["deviceid"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "device_slno": deviceSlno,
        "deviceid": deviceid,
      };
}
