import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) =>
    LoginDataModel.fromJson(json.decode(str));

String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  LoginDataModel({
    required this.message,
    required this.partnername,
    required this.ptype,
    required this.partnerid,
    required this.password,
    required this.status,
    required this.messageToDisplay,
  });

  String message;
  String partnername;
  String ptype;
  String partnerid;
  String password;
  bool status;
  String? messageToDisplay;

  factory LoginDataModel.fromJson(Map<dynamic, dynamic> json) => LoginDataModel(
        message: json["Message"],
        partnername: json["partnername"]?.toString() ?? "",
        ptype: json["ptype"]?.toString() ?? "",
        partnerid: json["partnerid"]?.toString() ?? "",
        password: json["password"] ?? "",
        status: json["status"],
    messageToDisplay: json["msg_todisplay"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "partnername": partnername,
        "ptype": ptype,
        "partnerid": partnerid,
        "password": password,
        "status": status,
    'msg_todisplay': messageToDisplay
      };
}
