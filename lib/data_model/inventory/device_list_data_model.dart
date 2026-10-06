class DeviceListDataModel {
  DeviceListDataModel({
    required this.status,
    required this.message,
    required this.totalPages,
    required this.perPage,
    required this.totalRecords,
    required this.list,
    required this.deviceStatusList,
    required this.devStats,
    required this.headings,
  });

  final String? status;
  final String? message;
  final String? totalPages;
  final String? perPage;
  final String? totalRecords;
  final List<String?> headings;
  final List<List<String?>> list;
  final Map<String?, String?> deviceStatusList;
  final DevStats? devStats;

  factory DeviceListDataModel.fromJson(Map<String, dynamic> json) {
    return DeviceListDataModel(
      status: json["status"]?.toString(),
      message: json["Message"]?.toString(),
      totalPages: json["total_pages"]?.toString(),
      perPage: json["per_page"]?.toString(),
      totalRecords: json["total_records"]?.toString(),
      headings: List<String>.from(
        json["headings"]?.map(
          (x) => x?.toString(),
        ),
      ),
      list: json["list"] == null
          ? []
          : List<List<String>>.from(
              json["list"]!.map(
                (x) => x == null
                    ? []
                    : List<String>.from(
                        x!.map(
                          (x) => x?.toString(),
                        ),
                      ),
              ),
            ),
      deviceStatusList: Map.from(
        json["device_status_list"],
      ).map(
        (k, v) => MapEntry<String?, String?>(k, v),
      ),
      devStats: json["dev_stats"] == null
          ? null
          : DevStats.fromJson(
              json["dev_stats"],
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "total_pages": totalPages,
        "per_page": perPage,
        "total_records": headings.map((x) => x).toList(),
        "list": list.map((x) => x.map((x) => x).toList()).toList(),
        "device_status_list": Map.from(deviceStatusList)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "dev_stats": devStats?.toJson(),
      };
}

class DevStats {
  DevStats({
    required this.totalDevices,
    required this.availableAtLnp,
    required this.availableAtSubscribers,
    required this.ontAvalibleAtChurnedSubscribers,
  });

  final String? totalDevices;
  final AvailableAtLnp? availableAtLnp;
  final String? availableAtSubscribers;
  final String? ontAvalibleAtChurnedSubscribers;

  factory DevStats.fromJson(Map<String, dynamic> json) {
    return DevStats(
      totalDevices: json["Total Devices"]?.toString(),
      availableAtLnp: json["Available at LNP"] == null
          ? null
          : AvailableAtLnp.fromJson(json["Available at LNP"]),
      availableAtSubscribers: json["Available at Subscribers"]?.toString(),
      ontAvalibleAtChurnedSubscribers:
          json["ONTs Available at Churned Subscribers"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "Total Devices": totalDevices,
        "Available at LNP": availableAtLnp?.toJson(),
        "Available at Subscribers": availableAtSubscribers,
        "ONTs Available at Churned Subscribers": ontAvalibleAtChurnedSubscribers
      };
}

class AvailableAtLnp {
  AvailableAtLnp({
    required this.working,
    required this.faulty,
    required this.returnRequest,
  });

  final String? working;
  final String? faulty;
  final String? returnRequest;

  factory AvailableAtLnp.fromJson(Map<String, dynamic> json) {
    return AvailableAtLnp(
      working: json["Working"]?.toString(),
      faulty: json["Faulty"]?.toString(),
      returnRequest: json["Return Device Request"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "Working": working,
        "Faulty": faulty,
        "Return Device Request": returnRequest,
      };
}
