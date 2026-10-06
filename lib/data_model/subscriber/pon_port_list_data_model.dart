class PonPortListDataModel {
  PonPortListDataModel({
    // required this.status,
    // required this.message,
    required this.ponList,
  });

  // final bool? status;
  // final String? message;
  final List<PonList> ponList;

  factory PonPortListDataModel.fromJson(Map<String, dynamic> json) {
    return PonPortListDataModel(
      // status: json["status"],
      // message: json["Message"],
      ponList: json["pon_list"] == null
          ? []
          : List<PonList>.from(
              json["pon_list"]!.map((x) => PonList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        // "status": status,
        // "Message": message,
        "pon_list": ponList.map((x) => x.toJson()).toList(),
      };
}

class PonList {
  PonList({
    required this.ponportId,
    required this.ponportNumber,
  });

  final String? ponportId;
  final String? ponportNumber;

  factory PonList.fromJson(Map<String, dynamic> json) {
    return PonList(
      ponportId: json["ponport_id"]?.toString(),
      ponportNumber: json["ponport_number"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "ponport_id": ponportId,
        "ponport_number": ponportNumber,
      };
}
