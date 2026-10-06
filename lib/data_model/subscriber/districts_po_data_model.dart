// To parse this JSON data, do
//
//     final districtsAndPoDataModel = districtsAndPoDataModelFromJson(jsonString);

import 'dart:convert';

DistrictsAndPoDataModel districtsAndPoDataModelFromJson(String str) =>
    DistrictsAndPoDataModel.fromJson(json.decode(str));

String districtsAndPoDataModelToJson(DistrictsAndPoDataModel data) =>
    json.encode(data.toJson());

class DistrictsAndPoDataModel {
  bool? status;
  String? message;
  List<Pflist> pflist;
  List<Dtlist> dtlist;

  DistrictsAndPoDataModel({
    required this.status,
    required this.message,
    required this.pflist,
    required this.dtlist,
  });

  factory DistrictsAndPoDataModel.fromJson(Map<String, dynamic> json) =>
      DistrictsAndPoDataModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        pflist: json["pflist"] == null
            ? []
            : List<Pflist>.from(json["pflist"]!.map((x) => Pflist.fromJson(x))),
        dtlist: json["dtlist"] == null
            ? []
            : List<Dtlist>.from(json["dtlist"]!.map((x) => Dtlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "pflist": List<dynamic>.from(pflist.map((x) => x.toJson())),
        "dtlist": List<dynamic>.from(dtlist.map((x) => x.toJson())),
      };
}

class Dtlist {
  String? districtcode;
  String? district;

  Dtlist({
    required this.districtcode,
    required this.district,
  });

  factory Dtlist.fromJson(Map<String, dynamic> json) => Dtlist(
        districtcode: json["districtcode"]?.toString(),
        district: json["district"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "districtcode": districtcode,
        "district": district,
      };
}

class Pflist {
  String? postOfficeName;

  Pflist({
    required this.postOfficeName,
  });

  factory Pflist.fromJson(Map<String, dynamic> json) => Pflist(
        postOfficeName: json["post_office_name"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "post_office_name": postOfficeName,
      };
}
