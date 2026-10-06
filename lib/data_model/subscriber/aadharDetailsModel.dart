class AadharDetailsModel {
  AadharDetailsModel({
    required this.status,
    required this.message,
    required this.name,
    required this.streetlo,
    required this.doorno,
    required this.cityname,
    required this.pincode,
    required this.userImage,
    required this.gender,
    required this.genderid,
    required this.dob,
    required this.mobileno,
    required this.email,
    required this.resid,
  });

  bool? status;
  String? message;
  String? name;
  String? streetlo;
  String? doorno;
  String? cityname;
  String? pincode;
  String? userImage;
  String? gender;
  String? genderid;
  String? dob;
  String? mobileno;
  String? email;
  String? resid;

  factory AadharDetailsModel.fromJson(Map<String, dynamic> json) {
    return AadharDetailsModel(
      status: json["status"],
      message: json["Message"]?.toString(),
      name: json["name"]?.toString(),
      streetlo: json["streetlo"]?.toString(),
      doorno: json["doorno"]?.toString(),
      cityname: json["cityname"]?.toString(),
      pincode: json["pincode"]?.toString(),
      userImage: json["user_image"]?.toString(),
      gender: json["gender"]?.toString(),
      genderid: json["genderid"]?.toString(),
      dob: json["dob"]?.toString(),
      mobileno: json["mobileno"]?.toString(),
      email: json["email"]?.toString(),
      resid: json["resid"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "name": name,
        "streetlo": streetlo,
        "doorno": doorno,
        "cityname": cityname,
        "pincode": pincode,
        "user_image": userImage,
        "gender": gender,
        "genderid": genderid,
        "dob": dob,
        "mobileno": mobileno,
        "email": email,
        "resid": resid,
      };
}
