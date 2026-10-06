class DataUsageModel {
  DataUsageModel({
    required this.status,
    required this.totalUpload,
    required this.totalDownload,
    required this.totalUsage,
    required this.remaingVol,
    required this.radsessions,
    required this.message,
  });

  final bool? status;
  final String? totalUpload;
  final String? totalDownload;
  final String? totalUsage;
  final String? remaingVol;
  final List<Radsession> radsessions;
  final String? message;

  factory DataUsageModel.fromJson(Map<String, dynamic> json) {
    return DataUsageModel(
      status: json["status"],
      totalUpload: json["total_upload"]?.toString(),
      totalDownload: json["total_download"]?.toString(),
      totalUsage: json["total_usage"]?.toString(),
      remaingVol: json["remaing_vol"]?.toString(),
      radsessions: json["radsessions"] == null
          ? []
          : List<Radsession>.from(
              json["radsessions"]!.map((x) => Radsession.fromJson(x))),
      message: json["Message"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "total_upload": totalUpload,
        "total_download": totalDownload,
        "total_usage": totalUsage,
        "remaing_vol": remaingVol,
        "radsessions": radsessions.map((x) => x.toJson()).toList(),
        "Message": message,
      };
}

class Radsession {
  Radsession({
    required this.callingstationid,
    required this.framedipaddress,
    required this.acctstarttime,
    required this.acctstoptime,
    required this.upload,
    required this.download,
    required this.nasipaddress,
  });

  final String? callingstationid;
  final String? framedipaddress;
  final DateTime? acctstarttime;
  final String? acctstoptime;
  final String? upload;
  final String? download;
  final String? nasipaddress;

  factory Radsession.fromJson(Map<String, dynamic> json) {
    return Radsession(
      callingstationid: json["callingstationid"]?.toString(),
      framedipaddress: json["framedipaddress"]?.toString(),
      acctstarttime: DateTime.tryParse(json["acctstarttime"] ?? ""),
      acctstoptime: json["acctstoptime"]?.toString(),
      upload: json["upload"]?.toString(),
      download: json["download"]?.toString(),
      nasipaddress: json["nasipaddress"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "callingstationid": callingstationid,
        "framedipaddress": framedipaddress,
        "acctstarttime": acctstarttime?.toIso8601String(),
        "acctstoptime": acctstoptime,
        "upload": upload,
        "download": download,
        "nasipaddress": nasipaddress,
      };
}
