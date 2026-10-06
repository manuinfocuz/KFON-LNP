/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

import 'package:flutter/cupertino.dart';

HomeGrid homeGridFromJson(String str) => HomeGrid.fromJson(json.decode(str));

String homeGridToJson(HomeGrid data) => json.encode(data.toJson());

class HomeGrid {
    HomeGrid({
        required this.name,
        required this.icon,
        required this.count,
        required this.onClick
    });

    String name;
    IconData icon;
    int count;
    Function() onClick;

    factory HomeGrid.fromJson(Map<dynamic, dynamic> json) => HomeGrid(
        name: json["name"],
        icon: json["icon"],
        count: json["count"],
        onClick: (){}
    );

    Map<dynamic, dynamic> toJson() => {
        "name": name,
        "icon": icon,
        "count": count,
    };
}
