class OntDeviceDetailsDataModel {
  OntDeviceDetailsDataModel({
    required this.status,
    required this.message,
    required this.deviceMake,
    required this.deviceModel,
    required this.deviceMakeAddr,
  });

  final bool? status;
  final String? message;
  final String? deviceMake;
  final String? deviceModel;
  final String? deviceMakeAddr;

  factory OntDeviceDetailsDataModel.fromJson(Map<String, dynamic> json) {
    return OntDeviceDetailsDataModel(
      status: json["status"],
      message: json["Message"],
      deviceMake: json["device_make"]?.toString(),
      deviceModel: json["device_model"]?.toString(),
      deviceMakeAddr: json["device_make_addr"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "device_make": deviceMake,
        "device_model": deviceModel,
        "device_make_addr": deviceMakeAddr,
      };
}
