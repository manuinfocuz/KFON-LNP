import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/message_model.dart';
import 'package:kfon_lnp/data_model/subscriber/caf_type_data_model.dart';
import 'package:kfon_lnp/data_model/subscriber/new_plan_list_model.dart';
import 'package:kfon_lnp/data_model/subscriber/olt_list_data_model.dart';
import 'package:kfon_lnp/data_model/subscriber/pon_port_list_data_model.dart';
import 'package:kfon_lnp/data_services/api_helper.dart';

import '../data_model/subscriber/active_subscriber_list.dart';
import '../data_model/subscriber/device_provider_list_model.dart';
import '../data_model/subscriber/device_type_list_model.dart';
import '../data_model/subscriber/districts_po_data_model.dart';
import '../data_model/subscriber/gstin_model.dart';
import '../data_model/subscriber/local_body_list_data_model.dart';
import '../data_model/subscriber/normal_application_post_model.dart';
import '../data_model/subscriber/olt_list_model.dart';
import '../data_model/subscriber/ont_device_details_model.dart';
import '../data_model/subscriber/ont_device_list_data_model.dart';
import '../data_model/subscriber/package_list_model.dart';
import '../data_model/subscriber/pincode_data_model.dart';
import '../data_model/subscriber/plan_type_list_model.dart';
import '../data_model/subscriber/sub_type_model.dart';
import '../data_model/subscriber/subscriber_details_model.dart';
import '../data_model/subscriber/supported_list_doc_model.dart';
import '../data_model/subscriber/village_block_munsi_data_list.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class SubscriberCreateRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<dynamic> getApplicationID(String cafID, String profileID) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "caftypeid": cafID,
      "profileid": profileID,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.SUBGETAPPID,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return messageModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getPinCodes() async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETALLPINCODE,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return pincodeDataModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getPlans(String caf, String profileID) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "caftypeid": caf,
      "profileid": profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETPLANLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return newPlanListModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getPlanType(String caf, String profileID) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "caftypeid": caf,
      "profileid": profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETPLSNTYPE,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return PlanTypeListModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getDistrictsAndPo(String pinCode) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "pincode": pinCode,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETDISTRICTSANDPO,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return districtsAndPoDataModelFromJson(
          jsonEncode(data),
        );
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getLocalBodyList(String pinCode, String poName,
      String disCode, String locationType) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "pincode": pinCode,
      "post_office_name": poName,
      "districtcode": disCode,
      "loc_type": locationType
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETLOCALBODYLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return localBodyListDataModelFromJson(
          jsonEncode(data),
        );
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getVMBList(String pinCode, String poName, String disCode,
      String locationType, String vilageTypeID) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "pincode": pinCode,
      "post_office_name": poName,
      "districtcode": disCode,
      "loc_type": locationType,
      "village_type_id": vilageTypeID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETVVBMLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return villageBlkMunsiDatalistFromJson(
          jsonEncode(data),
        );
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getDeviceProviderList(
      /*String  caf, String profileID*/) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      // "caftypeid": caf,
      // "profileid":profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETDEVICEPROVIDERLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return deviceProviderListModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getDeviceTypeList(/*String  caf, String profileID*/) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      // "caftypeid": caf,
      // "profileid":profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETDEVICETYPELIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return deviceTypeListModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getONTList(/*String  caf, String profileID*/) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      // "caftypeid": caf,
      // "profileid":profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETONTLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return oltListModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<OltListDataModel?> getOLTList(
      /*String  caf, String profileID*/) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      // "caftypeid": caf,
      // "profileid":profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETOLTLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return OltListDataModel.fromJson(data);
        },
      );
    } else {
      return null;
    }
  }

  Future<PonPortListDataModel?> getPONPortList(String? oltId) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "oltid": "$oltId"
      // "caftypeid": caf,
      // "profileid":profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETPONLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return PonPortListDataModel.fromJson(data);
        },
      );
    } else {
      return null;
    }
  }

  Future<dynamic> getSupoDocList(/*String  caf, String profileID*/) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      // "caftypeid": caf,
      // "profileid":profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETSUPDOCLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return supportedDocListModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> checkUserName(String userName) async {
    var body = {
      "username": "kfon.$userName",
      // "caftypeid": caf,
      // "profileid":profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.USERNAMEAVAILABLE,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
      canShowError: false,
      canReturn: true,
    );
    if (data != null) {
      return modelErrorHandler(() {
        return messageModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> checkGSTIN(String GSTIN) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "gstin": GSTIN,
      // "caftypeid": caf,
      // "profileid":profileID
    };

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GSTINCHECKUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
      canShowError: true,
      canReturn: false,
    );
    if (data != null) {
      return modelErrorHandler(() {
        return gstinModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }
  Future<dynamic> createSubscriber(
      NormalApplicationPostModel body) async {
    try {
      Map<String, String> tempBody = {};
      Map<String, dynamic> files = {};

      // Partner ID
      tempBody["partnerid"] =
      "${globalLoginModel?.partnerid}";

      // Convert model to JSON
      final Map<String, dynamic> modelBody = body.toJson();

      // Separate normal fields and files
      modelBody.forEach((key, value) {
        if (value == null) {
          return;
        }

        if (value.toString().trim().isEmpty) {
          return;
        }

        // File fields
        if (value is File) {
          files[key] = [value.path];

          print(
            "FILE => $key : ${value.path}",
          );
        } else {
          tempBody[key] = value.toString();

          print(
            "BODY => $key : ${value.toString()}",
          );
        }
      });

      print("========== CREATE KYC ==========");
      print(
        "BASE URL    : ${AppEndPoints.BASEURL}",
      );
      print(
        "CREATE KEYC : ${AppEndPoints.CREATEKEYC}",
      );
      print("METHOD      : POST");

      // FIXED NULL-SAFETY
      print(
        "TOKEN       : "
            "${tokenTemp?.isNotEmpty == true ? 'AVAILABLE' : 'EMPTY'}",
      );

      print("BODY        : $tempBody");
      print("FILES       : $files");
      print("================================");

      final data = await errorHandler(
        _apiHelper.multiPart(
          AppEndPoints.BASEURL,
          AppEndPoints.CREATEKEYC,
          methodtype: ApiTypeEnum.POST,
          body: tempBody,
          type: 2,
          token: "$tokenTemp",
          files: files,
        ),
        canShowError: true,
        canReturn: false,
      );

      print(
        "========== CREATE KYC RESPONSE ==========",
      );
      print("RESPONSE => $data");
      print("=========================================");

      if (data != null) {
        return modelErrorHandler(() {
          return messageModelFromJson(
            jsonEncode(data),
          );
        });
      }

      return null;
    } catch (e, stackTrace) {
      print(
        "========== CREATE KYC ERROR ==========",
      );
      print("ERROR => $e");
      print("STACK => $stackTrace");
      print("======================================");

      return null;
    }
  }
  // Future<dynamic> createSubscriber(NormalApplicationPostModel body) async {
  //   Map<String, String> finalBody = {};
  //
  //   //var tempBody = Map.from(body);
  //   Map<String, dynamic> modelBody = body.toJson();
  //   Map<String, String> tempBody = {};
  //   Map<String, dynamic> files = {};
  //   tempBody["partnerid"] = "${globalLoginModel?.partnerid}";
  //
  //   modelBody.forEach(
  //     (key, value) {
  //       if (value != null && value.toString().isNotEmpty) {
  //         if (value.runtimeType.toString() == "_File") {
  //           value as File;
  //           files[key] = [value.path];
  //         } else {
  //           tempBody[key] = value;
  //         }
  //       }
  //     },
  //   );
  //   print("start");
  //   tempBody.forEach((key, value) {
  //     print("$key:$value");
  //   });
  //
  //   var data = await errorHandler(
  //     _apiHelper.multiPart(
  //       AppEndPoints.BASEURL,
  //       AppEndPoints.CREATEKEYC,
  //       methodtype: ApiTypeEnum.POST,
  //       body: tempBody,
  //       type: 2,
  //       token: "$tokenTemp",
  //       files: files,
  //     ),
  //     canShowError: true,
  //     canReturn: false,
  //   );
  //   if (data != null) {
  //     return modelErrorHandler(() {
  //       return messageModelFromJson(jsonEncode(data));
  //     });
  //   } else {
  //     return null;
  //   }
  // }

  Future<dynamic> getONTDeviceList() async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      // "caftypeid": caf,
      // "profileid":profileID
    };

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETONTDEVICELIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
      canShowError: true,
      canReturn: false,
    );
    if (data != null) {
      return modelErrorHandler(() {
        return OntDeviceListDataModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getONTDeviceDetails(String? selectedONTDeviceID) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "deviceid": "$selectedONTDeviceID",
      // "caftypeid": caf,
      // "profileid":profileID
    };

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETONTDEVICEDETAILS,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
      canShowError: true,
      canReturn: false,
    );
    if (data != null) {
      return modelErrorHandler(() {
        return OntDeviceDetailsDataModel.fromJson(data);
      });
    } else {
      return null;
    }
  }
}
