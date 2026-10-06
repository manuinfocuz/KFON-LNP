class DisbursementDataModel {
  DisbursementDataModel({
    required this.headings,
    required this.dlist,
  });

  final List<String> headings;
  final List<List<String?>> dlist;

  factory DisbursementDataModel.fromJson(Map<String, dynamic> json) {
    return DisbursementDataModel(
      headings: json["headings"] == null
          ? []
          : List<String>.from(json["headings"]!.map((x) => x)),
      dlist: json["dlist"] == null
          ? []
          : List<List<String?>>.from(
              json["dlist"]!.map(
                (x) => x == null
                    ? []
                    : List<String?>.from(
                        x!.map(
                          (x) => x?.toString(),
                        ),
                      ),
              ),
            ),

      // dlist: json["dlist"] == null
      //     ? []
      //     : List<Dlist>.from(json["dlist"]!.map((x) => Dlist.fromJson(x))),
    );
  }
}

class Dlist {
  Dlist({
    required this.lastupdate,
    required this.cause,
    required this.amount,
  });

  final String? lastupdate;
  final String? cause;
  final String? amount;

  factory Dlist.fromJson(Map<String, dynamic> json) {
    return Dlist(
      lastupdate: json["lastupdate"]?.toString(),
      cause: json["cause"]?.toString(),
      amount: json["amount"]?.toString(),
    );
  }
}
