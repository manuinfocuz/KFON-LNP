import 'dart:convert';
import 'dart:io';

// NormalApplicationPostModel normalApplicationPostModelFromJson(String str) =>
//     NormalApplicationPostModel.fromJson(json.decode(str));

String normalApplicationPostModelToJson(NormalApplicationPostModel data) =>
    json.encode(data.toJson());

class NormalApplicationPostModel {
  String? partnerid;
  String? caftypeid;
  String? profileid;
  String? apno;
  String? firstname;
  String? dateofbirth;
  String? gender;
  String? mobileno;
  String? email;
  String? doorno;
  String? streetlo;
  String? cityname;
  String? pincode;
  String? postOfficeName;
  String? district;
  String? locType;
  String? villageName;
  String? block;
  String? municipalityName;
  String? localbodyType;
  String? doornoInsta;
  String? streetloInsta;
  String? citynameInsta;
  String? pincodeInsta;
  String? postOfficeNameInsta;
  String? districtInsta;
  String? locTypeInsta;
  String? villageNameInsta;
  String? blockInsta;
  String? municipalityNameInsta;
  String? localBodyInsta;
  String? addressSameasPadd;
  String? username;
  String? packageid;
  String? planType;
  String? deviceProvider;

  ///new
  String? lnpVlanID;

  ///new
  String? deviceID;
  String? deviceType;
  String? deviceMake;
  String? deviceModel;
  String? deviceMacAddress;
  String? oltType;

  ///new
  String? configSSID;
  String? ssid24ghz;
  String? preShared24ghz;
  String? ssid50ghz;
  String? preShared50ghz;
  String? oltId;
  String? ponPortId;
  String? ontPosition;

  ///new
  File? appliformcopy;
  String? residenceType;
  String? addressproofNo;
  File? addressproofCopy;
  String? idproofType;
  String? idproofNo;
  File? idproofCopy;
  String? gstinAvailable;
  File? gstinproof;
  File? lutproof;
  String? panNumber;
  File? panProof;
  String? gstinSub1;
  String? gstinSub2;
  String? gstinSub3;
  String? gstinSub4;
  String? gstinSub5;
  String? taxpayertype;
  String? gstStatus;
  String? legalname;
  String? tradename;
  String? contactManager;
  String? contactManagerNo;
  String? ekycRequestid;
  String? iaddressSameasPadd;

  NormalApplicationPostModel({
    this.partnerid,
    this.caftypeid,
    this.profileid,
    this.apno,
    this.firstname,
    this.dateofbirth,
    this.gender,
    this.mobileno,
    this.email,
    this.doorno,
    this.streetlo,
    this.cityname,
    this.pincode,
    this.postOfficeName,
    this.district,
    this.locType,
    this.villageName,
    this.block,
    this.municipalityName,
    this.localbodyType,
    this.doornoInsta,
    this.streetloInsta,
    this.citynameInsta,
    this.pincodeInsta,
    this.postOfficeNameInsta,
    this.districtInsta,
    this.locTypeInsta,
    this.villageNameInsta,
    this.blockInsta,
    this.municipalityNameInsta,
    this.localBodyInsta,
    this.addressSameasPadd,
    this.username,
    this.packageid,
    this.planType,
    this.deviceProvider,
    this.deviceID,
    this.deviceType,

    ///new
    this.lnpVlanID,

    ///new
    this.deviceMake,
    this.deviceModel,
    this.deviceMacAddress,
    this.oltType,

    ///new
    this.configSSID,
    this.ssid24ghz,
    this.preShared24ghz,
    this.ssid50ghz,
    this.preShared50ghz,
    this.oltId,
    this.ponPortId,
    this.ontPosition,

    ///new
    this.appliformcopy,
    this.residenceType,
    this.addressproofNo,
    this.addressproofCopy,
    this.idproofType,
    this.idproofNo,
    this.idproofCopy,
    this.gstinAvailable,
    this.gstinproof,
    this.lutproof,
    this.panNumber,
    this.panProof,
    this.gstinSub1,
    this.gstinSub2,
    this.gstinSub3,
    this.gstinSub4,
    this.gstinSub5,
    this.taxpayertype,
    this.gstStatus,
    this.legalname,
    this.tradename,
    this.contactManager,
    this.contactManagerNo,
    this.ekycRequestid,
    this.iaddressSameasPadd,
  });

  // factory NormalApplicationPostModel.fromJson(Map<String, dynamic> json) =>
  //     NormalApplicationPostModel(
  //       partnerid: json["partnerid"].toString(),
  //       caftypeid: json["caftypeid"].toString(),
  //       profileid: json["profileid"].toString(),
  //       apno: json["apno"].toString(),
  //       firstname: json["firstname"].toString(),
  //       dateofbirth: json["dateofbirth"],
  //       gender: json["gender"].toString(),
  //       mobileno: json["mobileno"].toString(),
  //       email: json["email"].toString(),
  //       doorno: json["doorno"].toString(),
  //       streetlo: json["streetlo"].toString(),
  //       cityname: json["cityname"].toString(),
  //       pincode: json["pincode"].toString(),
  //       postOfficeName: json["post_office_name"].toString(),
  //       district: json["district"].toString(),
  //       locType: json["loc_type"].toString(),
  //       villageName: json["village_name"].toString(),
  //       block: json["block"].toString(),
  //       municipalityName: json["municipality_name"].toString(),
  //       localbodyType: json["localbody_type"].toString(),
  //       doornoInsta: json["doorno_insta"].toString(),
  //       streetloInsta: json["streetlo_insta"].toString(),
  //       citynameInsta: json["cityname_insta"].toString(),
  //       pincodeInsta: json["pincode_insta"].toString(),
  //       postOfficeNameInsta: json["post_office_name_insta"].toString(),
  //       districtInsta: json["district_insta"].toString(),
  //       locTypeInsta: json["loc_type_insta"].toString(),
  //       villageNameInsta: json["village_name_insta"].toString(),
  //       blockInsta: json["block_insta"].toString(),
  //       municipalityNameInsta: json["municipality_name_insta"].toString(),
  //       localBodyInsta: json["local_body_insta"].toString(),
  //       addressSameasPadd: json["address_sameas_padd"].toString(),
  //       username: json["username"].toString(),
  //       packageid: json["packageid"].toString(),
  //       planType: json["plan_type"].toString(),
  //       deviceProvider: json["device_provider"].toString(),
  //       deviceType: json["device_type"].toString(),
  //       deviceMake: json["device_make"].toString(),
  //       deviceModel: json["device_model"].toString(),
  //       deviceMacAddress: json["device_mac_address"].toString(),
  //       oltType: json["olt_type"].toString(),
  //       appliformcopy: json["appliformcopy"].toString(),
  //       residenceType: json["residence_type"].toString(),
  //       addressproofNo: json["addressproof_no"].toString(),
  //       addressproofCopy: json["addressproof_copy"].toString(),
  //       idproofType: json["idproof_type"].toString(),
  //       idproofNo: json["idproof_no"].toString(),
  //       idproofCopy: json["idproof_copy"].toString(),
  //       gstinAvailable: json["gstin_available"].toString(),
  //       gstinproof: json["gstinproof"].toString(),
  //       panNumber: json["pan_number"].toString(),
  //       panProof: json["pan_proof"].toString(),
  //       gstinSub1: json["gstin_sub1"].toString(),
  //       gstinSub2: json["gstin_sub2"].toString(),
  //       gstinSub3: json["gstin_sub3"].toString(),
  //       gstinSub4: json["gstin_sub4"].toString(),
  //       gstinSub5: json["gstin_sub5"].toString(),
  //       taxpayertype: json["taxpayertype"].toString(),
  //       gstStatus: json["gst_status"].toString(),
  //       legalname: json["legalname"].toString(),
  //       tradename: json["tradename"].toString(),
  //       contactManager: json["contact_manager"].toString(),
  //       contactManagerNo: json["contact_manager_no"].toString(),
  //       ekycRequestid: json["ekyc_requestid"].toString(),
  //       iaddressSameasPadd: json["iaddress_sameas_padd"].toString(),
  //     );

  Map<String, dynamic> toJson() => {
        "partnerid": partnerid,
        "caftypeid": caftypeid,
        "profileid": profileid,
        "apno": apno,
        "firstname": firstname,
        "dateofbirth": dateofbirth,
        "gender": gender,
        "mobileno": mobileno,
        "email": email,
        "doorno": doorno,
        "streetlo": streetlo,
        "cityname": cityname,
        "pincode": pincode,
        "post_office_name": postOfficeName,
        "district": district,
        "loc_type": locType,
        "village_name": villageName,
        "block": block,
        "municipality_name": municipalityName,
        "localbody_type": localbodyType,
        "doorno_insta": doornoInsta,
        "streetlo_insta": streetloInsta,
        "cityname_insta": citynameInsta,
        "pincode_insta": pincodeInsta,
        "post_office_name_insta": postOfficeNameInsta,
        "district_insta": districtInsta,
        "loc_type_insta": locTypeInsta,
        "village_name_insta": villageNameInsta,
        "block_insta": blockInsta,
        "municipality_name_insta": municipalityNameInsta,
        "local_body_insta": localBodyInsta,
        "address_sameas_padd": addressSameasPadd,
        "username": username,
        "packageid": packageid,
        "plan_type": planType,
        "deviceid": deviceID,
        "device_provider": deviceProvider,
        "device_type": deviceType,

        ///new
        "lnp_vlanid": lnpVlanID,

        ///new
        "device_make": deviceMake,
        "device_model": deviceModel,
        "device_mac_address": deviceMacAddress,
        "olt_type": oltType,

        ///new
        "config_ssid": configSSID,

        "ssid_2_4ghz": ssid24ghz,
        "preshared_2_4ghz": preShared24ghz,

        "ssid_5_0ghz": ssid50ghz,
        "preshared_5_0ghz": preShared50ghz,
        "oltid": oltId,
        "ponport_id": ponPortId,
        "ont_position": ontPosition,

        ///new
        "appliformcopy": appliformcopy,
        "residence_type": residenceType,
        "addressproof_no": addressproofNo,
        "addressproof_copy": addressproofCopy,
        "idproof_type": idproofType,
        "idproof_no": idproofNo,
        "idproof_copy": idproofCopy,
        "gstin_available": gstinAvailable,
        "gstinproof": gstinproof,
        "lut_proof": lutproof,
        "pan_number": panNumber,
        "pan_proof": panProof,
        "gstin_sub1": gstinSub1,
        "gstin_sub2": gstinSub2,
        "gstin_sub3": gstinSub3,
        "gstin_sub4": gstinSub4,
        "gstin_sub5": gstinSub5,
        "taxpayertype": taxpayertype,
        "gst_status": gstStatus,
        "legalname": legalname,
        "tradename": tradename,
        "contact_manager": contactManager,
        "contact_manager_no": contactManagerNo,
        "ekyc_requestid": ekycRequestid,
        "iaddress_sameas_padd": iaddressSameasPadd
      };
}
