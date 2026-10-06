class TicketListModel {
  TicketListModel({
    required this.status,
    required this.message,
    required this.tlist,
    required this.totalRecords,
    required this.totalPages,
    required this.pageNum,
    required this.perPage,
  });

  final bool? status;
  final String? message;
  final List<Tlist> tlist;
  final String? totalRecords;
  final String? totalPages;
  final String? pageNum;
  final String? perPage;

  factory TicketListModel.fromJson(Map<String, dynamic> json) {
    return TicketListModel(
      status: json["status"],
      message: json["Message"],
      tlist: json["tlist"] == null
          ? []
          : List<Tlist>.from(json["tlist"]!.map((x) => Tlist.fromJson(x))),
      totalRecords: json["total_records"]?.toString(),
      totalPages: json["total_pages"]?.toString(),
      pageNum: json["page_num"]?.toString(),
      perPage: json["per_page"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "tlist": tlist.map((x) => x.toJson()).toList(),
        "total_records": totalRecords,
        "total_pages": totalPages,
        "page_num": pageNum,
        "per_page": perPage,
      };
}

class Tlist {
  Tlist({
    required this.ticketid,
    required this.createdDate,
    required this.status,
    required this.createdBy,
    required this.subject,
  });

  final String? ticketid;
  final DateTime? createdDate;
  final String? status;
  final String? createdBy;
  final String? subject;

  factory Tlist.fromJson(Map<String, dynamic> json) {
    return Tlist(
      ticketid: json["ticketid"]?.toString(),
      createdDate: DateTime.tryParse(json["created_date"] ?? ""),
      status: json["status"]?.toString(),
      createdBy: json["created_by"]?.toString(),
      subject: json["subject"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "ticketid": ticketid,
        "created_date": createdDate?.toIso8601String(),
        "status": status,
        "created_by": createdBy,
        "subject": subject,
      };
}
