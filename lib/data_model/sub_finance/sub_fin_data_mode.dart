class SubsFinDataModel {
  SubsFinDataModel({
    required this.headings,
    required this.flist,
    required this.total,
  });

  final List<String> headings;
  final List<List<String?>> flist;
  final String? total;

  factory SubsFinDataModel.fromJson(Map<String, dynamic> json) {
    return SubsFinDataModel(
      headings: json["headings"] == null
          ? []
          : List<String>.from(json["headings"]!.map((x) => x)),
      flist: json["flist"] == null
          ? []
          : List<List<String?>>.from(
              json["flist"]!.map(
                (x) => x == null
                    ? []
                    : List<String?>.from(
                        x!.map(
                          (x) => x?.toString(),
                        ),
                      ),
              ),
            ),
      // flist: json["flist"] == null
      //     ? []
      //     : List<Flist>.from(json["flist"]!.map((x) => Flist.fromJson(x))),
      total: json["Total"]?.toString(),
    );
  }
}

class Flist {
  Flist({
    required this.amount,
    required this.date,
    required this.description,
  });

  final String? amount;
  final String? date;
  final String? description;

  factory Flist.fromJson(Map<String, dynamic> json) {
    return Flist(
      amount: json["amount"]?.toString(),
      date: json["date"]?.toString(),
      description: json["description"]?.toString(),
    );
  }
}
