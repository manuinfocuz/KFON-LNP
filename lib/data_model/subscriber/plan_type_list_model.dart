class PlanTypeListModel {
  bool status;
  PlanTypes? plantypes;
  String message;

  PlanTypeListModel({
    required this.status,
    this.plantypes,
    required this.message,
  });

  factory PlanTypeListModel.fromJson(Map<String, dynamic> json) {
    return PlanTypeListModel(
      status: json['status'],
      plantypes: json['plantypes'] != null
          ? PlanTypes.fromJson(json['plantypes'])
          : null,
      message: json['Message'],
    );
  }
}

class PlanTypes {
  String? type1;
  String? type2;

  PlanTypes({
    this.type1,
    this.type2,
  });

  factory PlanTypes.fromJson(Map<String, dynamic> json) {
    return PlanTypes(
      type1: json['1'],
      type2: json['2'],
    );
  }

  List<String> toList() {
    return [type1 ?? "", type2 ?? ""];
  }
}
