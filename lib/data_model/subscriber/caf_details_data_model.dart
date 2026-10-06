class CafDetailsDataModel {
  CafDetailsDataModel({
    required this.status,
    required this.personalData,
    required this.paddressData,
    required this.iaddressData,
    required this.supportDocs,
    required this.message,
  });

  final bool? status;
  final Map<String, dynamic>? personalData;
  final Map<String, dynamic>? paddressData;
  final Map<String, dynamic>? iaddressData;
  final Map<String, dynamic>? supportDocs;
  final String? message;

  factory CafDetailsDataModel.fromJson(Map<String, dynamic> json) {
    return CafDetailsDataModel(
      status: json["status"],
      personalData: json["personal_data"],
      paddressData: json["paddress_data"],
      iaddressData: json["iaddress_data"],
      supportDocs: json["support_docs"],
      message: json["Message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "personal_data": personalData,
        "paddress_data": paddressData,
        "iaddress_data": iaddressData,
        "support_docs": supportDocs,
        "Message": message,
      };
}

class AddressData {
  AddressData({
    required this.installationAddress,
    required this.doorNo,
    required this.streetLocalityName,
    required this.state,
    required this.blockName,
    required this.district,
    required this.city,
    required this.villageName,
    required this.pincode,
    required this.permanentAddress,
  });

  final String? installationAddress;
  final String? doorNo;
  final String? streetLocalityName;
  final String? state;
  final String? blockName;
  final String? district;
  final String? city;
  final String? villageName;
  final String? pincode;
  final String? permanentAddress;

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      installationAddress: json["Installation Address"]?.toString(),
      doorNo: json["Door No"]?.toString(),
      streetLocalityName: json["Street/Locality Name"]?.toString(),
      state: json["State"]?.toString(),
      blockName: json["Block Name"]?.toString(),
      district: json["District"]?.toString(),
      city: json["City"]?.toString(),
      villageName: json["Village Name"]?.toString(),
      pincode: json["Pincode"]?.toString(),
      permanentAddress: json["Permanent Address"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "Installation Address": installationAddress,
        "Door No": doorNo,
        "Street/Locality Name": streetLocalityName,
        "State": state,
        "Block Name": blockName,
        "District": district,
        "City": city,
        "Village Name": villageName,
        "Pincode": pincode,
        "Permanent Address": permanentAddress,
      };
}

class PersonalData {
  PersonalData({
    required this.kycType,
    required this.kycStatus,
    required this.applicationNo,
    required this.applicantName,
    required this.mobileNo,
    required this.email,
    required this.dateOfBirth,
    required this.subscriptionType,
    required this.appliedPackage,
  });

  final String? kycType;
  final String? kycStatus;
  final String? applicationNo;
  final String? applicantName;
  final String? mobileNo;
  final String? email;
  final DateTime? dateOfBirth;
  final String? subscriptionType;
  final String? appliedPackage;

  factory PersonalData.fromJson(Map<String, dynamic> json) {
    return PersonalData(
      kycType: json["KYC Type"]?.toString(),
      kycStatus: json["KYC Status"]?.toString(),
      applicationNo: json["Application No"]?.toString(),
      applicantName: json["Applicant Name"]?.toString(),
      mobileNo: json["Mobile No"]?.toString(),
      email: json["Email"]?.toString(),
      dateOfBirth: DateTime.tryParse(json["Date of Birth"] ?? ""),
      subscriptionType: json["Subscription Type"]?.toString(),
      appliedPackage: json["Applied Package"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "KYC Type": kycType,
        "KYC Status": kycStatus,
        "Application No": applicationNo,
        "Applicant Name": applicantName,
        "Mobile No": mobileNo,
        "Email": email,
        "Date of Birth": dateOfBirth,
        "Subscription Type": subscriptionType,
        "Applied Package": appliedPackage,
      };
}

class SupportDocs {
  SupportDocs({
    required this.applicationFormCopy,
    required this.residenceProofCopy,
    required this.residenceProofNo,
    required this.pan,
  });

  final String? applicationFormCopy;
  final String? residenceProofCopy;
  final String? residenceProofNo;
  final String? pan;

  factory SupportDocs.fromJson(Map<String, dynamic> json) {
    return SupportDocs(
      applicationFormCopy: json["Application Form Copy"]?.toString(),
      residenceProofCopy: json["Residence Proof Copy"]?.toString(),
      residenceProofNo: json["Residence Proof No"]?.toString(),
      pan: json["Pan"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "Application Form Copy": applicationFormCopy,
        "Residence Proof Copy": residenceProofCopy,
        "Residence Proof No": residenceProofNo,
        "Pan": pan,
      };
}
