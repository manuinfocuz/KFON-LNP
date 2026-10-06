import 'dart:convert';

MainDashBoardModel mainDashBoardModelFromJson(String str) =>
    MainDashBoardModel.fromJson(json.decode(str));

String mainDashBoardModelToJson(MainDashBoardModel data) =>
    json.encode(data.toJson());

class MainDashBoardModel {
  bool status;
  String? message;
  List<TopPanel> topPanels;
  List<BottomPanel> bottomPanels;
  RecentTrans? recentTrans;

  MainDashBoardModel({
    required this.status,
    required this.message,
    required this.topPanels,
    required this.bottomPanels,
    required this.recentTrans,
  });

  factory MainDashBoardModel.fromJson(Map<String, dynamic> json) =>
      MainDashBoardModel(
        status: json["status"],
        message: json["Message"]?.toString(),
        topPanels: json["top_panels"] == null
            ? []
            : List<TopPanel>.from(
                json["top_panels"]?.map((x) => TopPanel.fromJson(x))),
        bottomPanels: json["bottom_panels"] == null
            ? []
            : List<BottomPanel>.from(
                json["bottom_panels"]?.map((x) => BottomPanel.fromJson(x))),
        recentTrans: json["recent_trans"] == null
            ? null
            : RecentTrans.fromJson(json["recent_trans"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "top_panels": List<dynamic>.from(topPanels.map((x) => x.toJson())),
        "bottom_panels":
            List<dynamic>.from(bottomPanels.map((x) => x.toJson())),
        "recent_trans": recentTrans?.toJson(),
      };
}

class BottomPanel {
  String? heading;
  String? value;
  String? apiUrl;

  BottomPanel({
    required this.heading,
    required this.value,
    required this.apiUrl,
  });

  factory BottomPanel.fromJson(Map<String, dynamic> json) => BottomPanel(
        heading: json["Heading"]?.toString(),
        value: json["value"]?.toString(),
        apiUrl: json["api_url"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "Heading": heading,
        "value": value,
        "api_url": apiUrl,
      };
}

class RecentTrans {
  String? heading;
  List<TransList> transList;

  RecentTrans({
    required this.heading,
    required this.transList,
  });

  factory RecentTrans.fromJson(Map<String, dynamic> json) => RecentTrans(
        heading: json["Heading"]?.toString(),
        transList: List<TransList>.from(
            json["trans_list"].map((x) => TransList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Heading": heading,
        "trans_list": List<dynamic>.from(transList.map((x) => x.toJson())),
      };
}

class TransList {
  String? username;
  String? amount;
  DateTime createdDate;
  String? cause;
  String? rechargeMode;

  TransList({
    required this.username,
    required this.amount,

    required this.createdDate,
    required this.cause,
    required this.rechargeMode,
  });

  factory TransList.fromJson(Map<String, dynamic> json) => TransList(
        username: json["username"]?.toString(),
        amount: json["amount"]?.toString(),
        createdDate: DateTime.parse(json["created_date"]),
        cause: json["cause"]?.toString(),
        rechargeMode: json["rechargemode"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "amount": amount,
        "created_date": createdDate.toIso8601String(),
        "cause": cause,
      };
}

class TopPanel {
  String? heading;
  String? value;
  String? apiUrl;

  TopPanel({
    required this.heading,
    required this.value,
    required this.apiUrl,
  });

  factory TopPanel.fromJson(Map<String, dynamic> json) => TopPanel(
        heading: json["Heading"]?.toString(),
        value: json["value"]?.toString(),
        apiUrl: json["api_url"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "Heading": heading,
        "value": value,
        "api_url": apiUrl,
      };
}
