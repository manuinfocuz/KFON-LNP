class SubEnqDetailsDataModel {
  SubEnqDetailsDataModel({
    // required this.status,
    // required this.message,
    required this.headings,
    required this.enquiry,
  });

  // final bool? status;
  // final String? message;
  final List<String> headings;
  final List<Enquiry> enquiry;

  factory SubEnqDetailsDataModel.fromJson(Map<String, dynamic> json) {
    return SubEnqDetailsDataModel(
      // status: json["status"],
      // message: json["Message"],
      headings: json["headings"] == null
          ? []
          : List<String>.from(json["headings"]!.map((x) => x)),
      enquiry: json["enquiry"] == null
          ? []
          : List<Enquiry>.from(
              json["enquiry"]!.map((x) => Enquiry.fromJson(x))),
    );
  }
}

class Enquiry {
  Enquiry({
    required this.id,
    required this.applieddate,
    required this.customername,
    required this.mobile,
    required this.email,
    required this.address,
    required this.district,
    required this.location,
    required this.pincode,
    required this.postoffice,
    required this.connType,
    required this.rationcard,
    required this.aadharnumber,
    required this.description,
    required this.status,
    required this.remarks,
    required this.fename,
  });

  final String? id;
  final String? applieddate;
  final String? customername;
  final String? mobile;
  final String? email;
  final String? address;
  final String? district;
  final String? location;
  final String? pincode;
  final String? postoffice;
  final String? connType;
  final String? rationcard;
  final String? aadharnumber;
  final String? description;
  final String? status;
  final String? remarks;
  final String? fename;

  factory Enquiry.fromJson(Map<String, dynamic> json) {
    return Enquiry(
      id: json["id"]?.toString(),
      applieddate: json["applieddate"]?.toString(),
      customername: json["customername"]?.toString(),
      mobile: json["mobile"]?.toString(),
      email: json["email"]?.toString(),
      address: json["address"]?.toString(),
      district: json["district"]?.toString(),
      location: json["location"]?.toString(),
      pincode: json["pincode"]?.toString(),
      postoffice: json["postoffice"]?.toString(),
      connType: json["connType"]?.toString(),
      rationcard: json["rationcard"]?.toString(),
      aadharnumber: json["aadhar_number"]?.toString(),
      description: json["description"]?.toString(),
      status: json["status"]?.toString(),
      remarks: json["remarks"]?.toString(),
      fename: json["fename"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "applieddate": applieddate,
        "customername": customername,
        "mobile": mobile,
        "email": email,
        "address": address,
        "district": district,
        "location": location,
        "pincode": pincode,
        "postoffice": postoffice,
        "connType": connType,
        "rationcard": rationcard,
        "aadhar_number": aadharnumber,
        "description": description,
        "status": status,
        "remarks": remarks,
        "fename": fename,
      };
}
