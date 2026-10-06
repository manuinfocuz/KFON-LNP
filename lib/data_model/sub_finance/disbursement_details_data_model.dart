class DisbursementDetailsDataModel {
  DisbursementDetailsDataModel({
    required this.headings,
    required this.rlist,
    required this.partnerGST,
  });

  final List<String> headings;
  final List<List<String?>> rlist;
  final PartnerGSTDataModel? partnerGST;

  factory DisbursementDetailsDataModel.fromJson(Map<String, dynamic> json) {
    return DisbursementDetailsDataModel(
      headings: json["headings"] == null
          ? []
          : List<String>.from(json["headings"]!.map((x) => x)),

      rlist: json["rlist"] == null
          ? []
          : List<List<String?>>.from(
              json["rlist"]!.map(
                (x) => x == null
                    ? []
                    : List<String?>.from(
                        x!.map(
                          (x) => x?.toString(),
                        ),
                      ),
              ),
            ),
      // rlist: json["rlist"] == null
      //     ? []
      //     : List<Rlist>.from(json["rlist"]!.map((x) => Rlist.fromJson(x))),

      partnerGST: json["partnergst"] == null
          ? null
          : PartnerGSTDataModel.fromJson(json["partnergst"]),
    );
  }
}

class Rlist {
  Rlist({
    required this.subscriberid,
    required this.username,
    required this.revenue,
    required this.anpshare,
    required this.netshare,
    required this.tds,
    required this.gstin,
    required this.pan,
    required this.taxpayertype,
    required this.inotype,
    required this.dot,
    required this.revenueshareid,
    required this.lastupdate,
    required this.dotshare,
    required this.amount,
  });

  final String? subscriberid;
  final String? username;
  final String? revenue;
  final String? anpshare;
  final String? netshare;
  final String? tds;
  final String? gstin;
  final String? pan;
  final String? taxpayertype;
  final String? inotype;
  final String? dot;
  final String? revenueshareid;
  final String? lastupdate;
  final String? dotshare;

  final String? amount;

  factory Rlist.fromJson(Map<String, dynamic> json) {
    return Rlist(
      subscriberid: json["subscriberid"]?.toString(),
      username: json["username"]?.toString(),
      revenue: json["revenue"]?.toString(),
      anpshare: json["anpshare"]?.toString(),
      netshare: json["netshare"]?.toString(),
      tds: json["tds"]?.toString(),
      gstin: json["gstin"]?.toString(),
      pan: json["Pan"]?.toString(),
      taxpayertype: json["taxpayertype"]?.toString(),
      inotype: json["inotype"]?.toString(),
      dot: json["dot"]?.toString(),
      revenueshareid: json["revenueshareid"]?.toString(),
      lastupdate: json["lastupdate"]?.toString(),
      dotshare: json["dotshare"]?.toString(),
      amount: json["amount"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subscriberid": subscriberid,
      "username": username,
      "revenue": revenue,
      "anpshare": anpshare,
      "netshare": netshare,
      "tds": tds,
      "gstin": gstin,
      "Pan": pan,
      "taxpayertype": taxpayertype,
      "inotype": inotype,
      "dot": dot,
      "revenueshareid": revenueshareid,
      "lastupdate": lastupdate,
      "dotshare": dotshare,
      "amount": amount,
    };
  }
}

class PartnerGSTDataModel {
  PartnerGSTDataModel({
    required this.pan,
    required this.gstin,
    required this.taxpayertype,
  });

  final String? pan;
  final String? gstin;
  final String? taxpayertype;

  factory PartnerGSTDataModel.fromJson(Map<String, dynamic> json) {
    return PartnerGSTDataModel(
      pan: json["pan"]?.toString(),
      gstin: json["gstin"]?.toString(),
      taxpayertype: json["taxpayertype"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "pan": pan,
        "gstin": gstin,
        "taxpayertype": taxpayertype,
      };
}
