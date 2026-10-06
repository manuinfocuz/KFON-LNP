import 'dart:convert';

ActiveSubscriberList activeSubscriberListFromJson(String str) =>
    ActiveSubscriberList.fromJson(json.decode(str));

String activeSubscriberListToJson(ActiveSubscriberList data) =>
    json.encode(data.toJson());

class ActiveSubscriberList {
  ActiveSubscriberList({
    required this.message,
    required this.headings,
    required this.subList,
    required this.tempList,
    required this.searchParams,
    required this.status,
    required this.totalRecords,
  });

  String? message;
  List<String> headings;
  List<ActiveSubscriberSub> subList;
  List<ActiveSubscriberSub> tempList;
  List<String> searchParams;
  bool status;
  final String totalRecords;

  factory ActiveSubscriberList.fromJson(Map<dynamic, dynamic> json) =>
      ActiveSubscriberList(
        message: json["Message"],
        headings: json["headings"] != null
            ? List<String>.from(json["headings"].map((x) => x))
            : [],
        subList: json["sub_lsit"] != null
            ? List<ActiveSubscriberSub>.from(
                json["sub_lsit"].map((x) => ActiveSubscriberSub.fromJson(x)))
            : [],
        tempList: [],
        searchParams: json["search_params"] == null
            ? []
            : List<String>.from(json["search_params"]!.map((x) => x)),
        status: json["status"],
        totalRecords: json["total_records"]?.toString() ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "Message": message,
        "headings": List<dynamic>.from(headings.map((x) => x)),
        "sub_lsit": List<dynamic>.from(subList.map((x) => x.toJson())),
        "temp_list": List<dynamic>.from(tempList.map((x) => x.toJson())),
        "status": status,
        "search_params": searchParams.map((x) => x).toList(),
        "total_records": totalRecords,
      };
}

class ActiveSubscriberSub {
  ActiveSubscriberSub({
    required this.firstname,
    // required this.address,
    // required this.subStatus,
    required this.packagename,
    required this.subscriberid,
     required this.registrationdate,
    required this.mobileno,
    // required this.gstin,
    required this.balance,
    required this.expiry,
    // required this.fallback,
    required this.email,
    required this.username,
    required this.subStatus,
  });

  String? firstname;

  // String? address;
  // String? subStatus;
  String? packagename;
  String? subscriberid;

  DateTime? registrationdate;
  String? mobileno;

  // String? gstin;
  String? balance;
  DateTime? expiry;

  // String? fallback;
  String? email;
  String? username;
  String? subStatus;

  factory ActiveSubscriberSub.fromJson(Map<dynamic, dynamic> json) =>
      ActiveSubscriberSub(
        firstname: json["firstname"]?.toString() ?? "",
        // address: json["address"],
        // subStatus: json["sub_status"],
        packagename: json["packagename"]?.toString() ?? "",
        subscriberid: json["subscriberid"]?.toString() ?? "",
         registrationdate: DateTime.parse(json["registrationdate"]),
        mobileno: json["mobileno"]?.toString() ?? "",
        // gstin: json["gstin"],
        balance: json["balance"],
        expiry: json["expiry"] != null ? DateTime.parse(json["expiry"]) : null,
        // fallback: json["fallback"],
        email: json["email"]?.toString() ?? "",
        username: json["username"]?.toString() ?? "",
        subStatus: json["sub_status"]?.toString() ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "firstname": firstname,
        // "address": address,
        //"sub_status": subStatus,
        "packagename": packagename,
        "subscriberid": subscriberid,

       "registrationdate": registrationdate?.toIso8601String(),
        "mobileno": mobileno,
        // "gstin": gstin,
        "balance": balance,
        "expiry":
            "${expiry?.year.toString().padLeft(4, '0')}-${expiry?.month.toString().padLeft(2, '0')}-${expiry?.day.toString().padLeft(2, '0')}",
        //   "fallback": fallback,
        "email": email,
        "username": username,
      };
}
