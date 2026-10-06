// To parse this JSON data, do
//
//     final newPlanListModel = newPlanListModelFromJson(jsonString);

import 'dart:convert';

NewPlanListModel newPlanListModelFromJson(String str) =>
    NewPlanListModel.fromJson(json.decode(str));

String newPlanListModelToJson(NewPlanListModel data) =>
    json.encode(data.toJson());

class NewPlanListModel {
  bool status;
  String? message;
  List<PlansList> plantypesList;
  List<String> planlistHeadings;

  NewPlanListModel({
    required this.status,
    required this.message,
    required this.plantypesList,
    required this.planlistHeadings,
  });

  factory NewPlanListModel.fromJson(Map<String, dynamic> json) {
    var planType = json["plantypes_list"] as List<dynamic>;
    List<PlansList> listPlan = [];

    planType.forEach((element) {
      listPlan.add(
        PlansList(
          title: element,
          data: List<List<String>>.from(
            json["plans_list"][element].map(
              (x) => List<String>.from(
                x.map((x) => x),
              ),
            ),
          ),
        ),
      );
    });

    return NewPlanListModel(
      status: json["status"],
      message: json["Message"]?.toString(),
      plantypesList: listPlan,
      planlistHeadings: json["planlist_headings"] == null
          ? []
          : List<String>.from(json["planlist_headings"].map((x) => "$x")),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "plantypes_list": List<dynamic>.from(plantypesList.map((x) => x)),
        "planlist_headings": List<dynamic>.from(planlistHeadings.map((x) => x)),
      };
}

class PlansList {
  String title;
  List<List<String>> data;

  PlansList({
    required this.title,
    required this.data,
  });
}
