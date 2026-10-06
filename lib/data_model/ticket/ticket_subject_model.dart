class TicketSubjectModel {
  TicketSubjectModel({
    required this.status,
    required this.message,
    required this.issuesList,
  });

  final bool? status;
  final String? message;
  final List<IssuesList> issuesList;

  factory TicketSubjectModel.fromJson(Map<String, dynamic> json) {
    return TicketSubjectModel(
      status: json["status"],
      message: json["Message"],
      issuesList: json["issues_list"] == null
          ? []
          : List<IssuesList>.from(
              json["issues_list"]!.map((x) => IssuesList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "issues_list": issuesList.map((x) => x.toJson()).toList(),
      };
}

class IssuesList {
  IssuesList({
    required this.slno,
    required this.msg,
  });

  final String? slno;
  final String? msg;

  factory IssuesList.fromJson(Map<String, dynamic> json) {
    return IssuesList(
      slno: json["slno"]?.toString(),
      msg: json["msg"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "slno": slno,
        "msg": msg,
      };
}
