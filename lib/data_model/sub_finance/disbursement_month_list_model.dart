class DisbursementMonthDataModel {
  DisbursementMonthDataModel({
    required this.mlist,
  });

  final List<Mlist> mlist;

  factory DisbursementMonthDataModel.fromJson(Map<String, dynamic> json) {
    return DisbursementMonthDataModel(
      mlist: json["mlist"] == null
          ? []
          : List<Mlist>.from(json["mlist"]!.map((x) => Mlist.fromJson(x))),
    );
  }
}

class Mlist {
  Mlist({
    required this.dmonth,
  });

  final String? dmonth;

  factory Mlist.fromJson(Map<String, dynamic> json) {
    return Mlist(
      dmonth: json["dmonth"]?.toString(),
    );
  }
}
