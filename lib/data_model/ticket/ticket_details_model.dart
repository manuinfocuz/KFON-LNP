class TicketDetailsModel {
  TicketDetailsModel({
    required this.status,
    required this.message,
    required this.tdetails,
    required this.chathistory,
  });

  final bool? status;
  final String? message;
  final Tdetails? tdetails;
  final List<Chathistory> chathistory;

  factory TicketDetailsModel.fromJson(Map<String, dynamic> json) {
    return TicketDetailsModel(
      status: json["status"],
      message: json["Message"]?.toString(),
      tdetails:
          json["tdetails"] == null ? null : Tdetails.fromJson(json["tdetails"]),
      chathistory: json["chathistory"] == null
          ? []
          : List<Chathistory>.from(
              json["chathistory"]!.map((x) => Chathistory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "tdetails": tdetails?.toJson(),
        "chathistory": chathistory.map((x) => x?.toJson()).toList(),
      };
}

class Chathistory {
  Chathistory({
    required this.noteid,
    required this.note,
    required this.createdBy,
    required this.createDate,
    required this.status,
    required this.attachment,
  });

  final String? noteid;
  final String? note;
  final String? createdBy;
  final DateTime? createDate;
  final String? status;
  final String? attachment;

  factory Chathistory.fromJson(Map<String, dynamic> json) {
    return Chathistory(
      noteid: json["noteid"]?.toString(),
      note: json["note"]?.toString(),
      createdBy: json["created_by"]?.toString(),
      createDate: DateTime.tryParse(json["create_date"] ?? ""),
      status: json["status"]?.toString(),
      attachment: json["attachment"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "noteid": noteid,
        "note": note,
        "created_by": createdBy,
        "create_date": createDate?.toIso8601String(),
        "status": status,
        "attachment": attachment,
      };
}

class Tdetails {
  Tdetails({
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

  factory Tdetails.fromJson(Map<String, dynamic> json) {
    return Tdetails(
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
