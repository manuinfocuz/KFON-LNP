// To parse this JSON data, do
//
//     final villageBlkMunsiDatalist = villageBlkMunsiDatalistFromJson(jsonString);

import 'dart:convert';

VillageBlkMunsiDatalist villageBlkMunsiDatalistFromJson(String str) =>
    VillageBlkMunsiDatalist.fromJson(json.decode(str));

String villageBlkMunsiDatalistToJson(VillageBlkMunsiDatalist data) =>
    json.encode(data.toJson());

class VillageBlkMunsiDatalist {
  bool? status;
  String? message;
  List<VillageList> villageList;
  List<BlockList> blockList;
  List<MuniciplaityList> municiplaityList;

  VillageBlkMunsiDatalist({
    required this.status,
    required this.message,
    required this.villageList,
    required this.blockList,
    required this.municiplaityList,
  });

  factory VillageBlkMunsiDatalist.fromJson(Map<String, dynamic> json) =>
      VillageBlkMunsiDatalist(
        status: json["status"],
        message: json["Message"].toString(),
        villageList: json["village_list"] == null
            ? []
            : List<VillageList>.from(
                json["village_list"]!.map((x) => VillageList.fromJson(x))),
        blockList: json["block_list"] == null
            ? []
            : List<BlockList>.from(
                json["block_list"]!.map((x) => BlockList.fromJson(x))),
        municiplaityList: json["municiplaity_list"] == null
            ? []
            : List<MuniciplaityList>.from(json["municiplaity_list"]!
                .map((x) => MuniciplaityList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "village_list": List<dynamic>.from(villageList.map((x) => x.toJson())),
        "block_list": List<dynamic>.from(blockList.map((x) => x.toJson())),
        "municiplaity_list":
            List<dynamic>.from(municiplaityList.map((x) => x.toJson())),
      };
}

class BlockList {
  String? blockId;
  String? blockName;

  BlockList({
    required this.blockId,
    required this.blockName,
  });

  factory BlockList.fromJson(Map<String, dynamic> json) => BlockList(
        blockId: json["block_id"].toString(),
        blockName: json["block_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "block_id": blockId,
        "block_name": blockName,
      };
}

class MuniciplaityList {
  String? municipalityName;

  MuniciplaityList({
    required this.municipalityName,
  });

  factory MuniciplaityList.fromJson(Map<String, dynamic> json) =>
      MuniciplaityList(
        municipalityName: json["municipality_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "municipality_name": municipalityName,
      };
}

class VillageList {
  String? villageName;

  VillageList({
    required this.villageName,
  });

  factory VillageList.fromJson(Map<String, dynamic> json) => VillageList(
        villageName: json["village_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "village_name": villageName,
      };
}
