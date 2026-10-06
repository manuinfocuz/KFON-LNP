class SubscriberLnpRechargeDetailsModel {
  SubscriberLnpRechargeDetailsModel({
    // required this.status,
    required this.pbalance,
    required this.rechAmount,
    required this.username,
    required this.topupmessage,
    // required this.message,
  });

  // final bool? status;
  final String? pbalance;
  final String? rechAmount;
  final String? username;
  final String? topupmessage;
  // final String? message;

  factory SubscriberLnpRechargeDetailsModel.fromJson(
      Map<String, dynamic> json) {
    return SubscriberLnpRechargeDetailsModel(
      // status: json["status"],
      pbalance: json["pbalance"],
      rechAmount: json["rech_amount"],
      username: json["username"],
      topupmessage: json["topupmessage"],
      // message: json["Message"],
    );
  }

  Map<String, dynamic> toJson() => {
        // "status": status,
        "pbalance": pbalance,
        "rech_amount": rechAmount,
        "username": username,
        "topupmessage": topupmessage,
        // "Message": message,
      };
}
