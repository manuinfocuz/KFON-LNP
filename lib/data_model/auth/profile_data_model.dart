// To parse this JSON data, do
//
//     final profileDataModel = profileDataModelFromJson(jsonString);

import 'dart:convert';

ProfileDataModel profileDataModelFromJson(String str) =>
    ProfileDataModel.fromJson(json.decode(str));

String profileDataModelToJson(ProfileDataModel data) =>
    json.encode(data.toJson());

class ProfileDataModel {
  bool status;
  RegDetails regDetails;
  SubDetails subDetails;
  BankDetails bankDetails;
  String message;
  String balance;
  String? enableAcs;
  String? oltProvider;

  ProfileDataModel(
      {required this.status,
      required this.regDetails,
      required this.subDetails,
      required this.bankDetails,
      required this.message,
      required this.balance,
      required this.enableAcs,
      required this.oltProvider});

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
        status: json["status"],
        regDetails: RegDetails.fromJson(json["reg_details"]),
        subDetails: SubDetails.fromJson(json["sub_details"]),
        bankDetails: BankDetails.fromJson(json["bank_details"]),
        message: json["Message"]?.toString() ?? "",
        balance: json["balance"]?.toString() ?? "",
        enableAcs: json["enable_acs"]?.toString(),
        oltProvider: json["olt_provider"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "reg_details": regDetails.toJson(),
        "sub_details": subDetails.toJson(),
        "bank_details": bankDetails.toJson(),
        "Message": message,
        "balance": balance,
        "enableAcs": enableAcs,
      };
}

class BankDetails {
  String heading;
  String bankName;
  String bankBranch;
  String bankAcholder;
  String bankAcno;
  String bankIfsc;
  String bankActype;

  BankDetails({
    required this.heading,
    required this.bankName,
    required this.bankBranch,
    required this.bankAcholder,
    required this.bankAcno,
    required this.bankIfsc,
    required this.bankActype,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        heading: json["Heading"]?.toString() ?? "",
        bankName: json["bank_name"]?.toString() ?? "",
        bankBranch: json["bank_branch"]?.toString() ?? "",
        bankAcholder: json["bank_acholder"]?.toString() ?? "",
        bankAcno: json["bank_acno"]?.toString() ?? "",
        bankIfsc: json["bank_ifsc"]?.toString() ?? "",
        bankActype: json["bank_actype"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Heading": heading,
        "bank_name": bankName,
        "bank_branch": bankBranch,
        "bank_acholder": bankAcholder,
        "bank_acno": bankAcno,
        "bank_ifsc": bankIfsc,
        "bank_actype": bankActype,
      };
}

class RegDetails {
  String heading;
  String partnername;
  String address;
  String companyregistrationno;
  String gstin;
  String incometaxno;
  dynamic vatno;
  String cperson;
  String cpersonPhone;
  String cpersonEmail;

  RegDetails({
    required this.heading,
    required this.partnername,
    required this.address,
    required this.companyregistrationno,
    required this.gstin,
    required this.incometaxno,
    required this.vatno,
    required this.cperson,
    required this.cpersonPhone,
    required this.cpersonEmail,
  });

  factory RegDetails.fromJson(Map<String, dynamic> json) => RegDetails(
        heading: json["Heading"]?.toString() ?? "",
        partnername: json["partnername"]?.toString() ?? "",
        address: json["address"]?.toString() ?? "",
        companyregistrationno: json["companyregistrationno"]?.toString() ?? "",
        gstin: json["gstin"]?.toString() ?? "",
        incometaxno: json["incometaxno"]?.toString() ?? "",
        vatno: json["vatno"]?.toString() ?? "",
        cperson: json["cperson"]?.toString() ?? "",
        cpersonPhone: json["cperson_phone"]?.toString() ?? "",
        cpersonEmail: json["cperson_email"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Heading": heading,
        "partnername": partnername,
        "address": address,
        "companyregistrationno": companyregistrationno,
        "gstin": gstin,
        "incometaxno": incometaxno,
        "vatno": vatno,
        "cperson": cperson,
        "cperson_phone": cpersonPhone,
        "cperson_email": cpersonEmail,
      };
}

class SubDetails {
  String? heading;
  String? partnerid;
  String? ptype;

  String? agreementno;
  DateTime? agreementdate;
  DateTime? agreementdateRenew;

  SubDetails({
    required this.heading,
    required this.partnerid,
    required this.ptype,
    required this.agreementno,
    required this.agreementdate,
    required this.agreementdateRenew,
  });

  factory SubDetails.fromJson(Map<String, dynamic> json) => SubDetails(
        heading: json["Heading"]?.toString(),
        partnerid: json["partnerid"]?.toString(),
        ptype: json["ptype"]?.toString(),
        agreementno: json["agreementno"]?.toString(),
        agreementdate: DateTime.tryParse(json["agreementdate"] ?? ''),
        agreementdateRenew:
            DateTime.tryParse(json["agreementdate_renew"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "Heading": heading,
        "partnerid": partnerid,
        "ptype": ptype,
        "agreementno": agreementno,
        "agreementdate":
            "${agreementdate?.year.toString().padLeft(4, '0')}-${agreementdate?.month.toString().padLeft(2, '0')}-${agreementdate?.day.toString().padLeft(2, '0')}",
        "agreementdate_renew":
            "${agreementdateRenew?.year.toString().padLeft(4, '0')}-${agreementdateRenew?.month.toString().padLeft(2, '0')}-${agreementdateRenew?.day.toString().padLeft(2, '0')}",
      };
}
