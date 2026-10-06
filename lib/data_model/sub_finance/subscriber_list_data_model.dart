class SubscriberListDataModel {
  SubscriberListDataModel({
    required this.subscriberid,
    required this.username,
  });

  final String? subscriberid;
  final String? username;

  factory SubscriberListDataModel.fromJson(Map<String, dynamic> json) {
    return SubscriberListDataModel(
      subscriberid: json["subscriberid"]?.toString(),
      username: json["username"]?.toString(),
    );
  }
}
