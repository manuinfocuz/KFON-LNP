import 'dart:convert';

SupportedDocListModel supportedDocListModelFromJson(String str) =>
    SupportedDocListModel.fromJson(json.decode(str));

String supportedDocListModelToJson(SupportedDocListModel data) =>
    json.encode(data.toJson());

class SupportedDocListModel {
  bool status;
  String? message;
  DocumnetList? documnetList;

  SupportedDocListModel({
    required this.status,
    required this.message,
    required this.documnetList,
  });

  factory SupportedDocListModel.fromJson(Map<String, dynamic> json) =>
      SupportedDocListModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        documnetList: DocumnetList.fromJson(json["documnet_list"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "documnet_list": documnetList?.toJson(),
      };
}

class DocumnetList {
  List<String> residenceProofCopy;
  List<String> identityProofCopy;

  DocumnetList({
    required this.residenceProofCopy,
    required this.identityProofCopy,
  });

  factory DocumnetList.fromJson(Map<String, dynamic> json) => DocumnetList(
        residenceProofCopy: json["residence_proof_copy"] == null
            ? []
            : List<String>.from(json["residence_proof_copy"].map((x) => "$x")),
        identityProofCopy: json["identity_proof_copy"] == null
            ? []
            : List<String>.from(json["identity_proof_copy"].map((x) => "$x")),
      );

  Map<String, dynamic> toJson() => {
        "residence_proof_copy":
            List<dynamic>.from(residenceProofCopy.map((x) => x)),
        "identity_proof_copy":
            List<dynamic>.from(identityProofCopy.map((x) => x)),
      };
}
