import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/message_model.dart';
import 'package:kfon_lnp/data_model/subscriber/caf_type_data_model.dart';
import 'package:kfon_lnp/data_services/api_helper.dart';

import '../data_model/recharge/subscriber_lnp_recharge_details_model.dart';
import '../data_model/subscriber/active_subscriber_list.dart';
import '../data_model/subscriber/data_usage_model.dart';
import '../data_model/subscriber/kyc_application_list_model.dart';
import '../data_model/subscriber/package_list_model.dart';
import '../data_model/subscriber/sub_type_model.dart';
import '../data_model/subscriber/subscriber_details_model.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class SubscriberRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<dynamic> getActiveSubscriber(
      int subPage, String? searchValue, String? params, int type) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "list_type": "$type",
      "page_num": "$subPage",
      "search_by": params ?? "",
      "search_val": searchValue ?? ""
    };
    if ((searchValue?.isEmpty ?? false)) {
      body["search_val"] = "";
      body["search_by"] = "";
    }
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETSUBSCRIBERLIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return activeSubscriberListFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getDataUsage(String username, String subID) async {
    var body = {"username": username, "subid": subID};

    // var body = {"username": "kfon.term8", "subid": 223};
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETSUBSCRIBERDATAUSAGE,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return DataUsageModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getKYCList(int page, String selectedFilter) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "page_num": "$page",
      "list_type": selectedFilter
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.KYCLISTIURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return kycApplicationListModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getSubscriberDetails(String subid) async {
    var body = {"partnerid": globalLoginModel?.partnerid, "subid": subid};
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETSUBSCRIBERDEATILS,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return subscriberDetailsModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> topUpUser(String subid) async {
    var body = {"partnerid": globalLoginModel?.partnerid, "subid": subid};
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.SUBSCRIBERTOUP,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return messageModelFromJson(jsonEncode(data));
        },
      );
    } else {
      return null;
    }
  }

  Future<dynamic> getPackages(String subid) async {
    var body = {"partnerid": globalLoginModel?.partnerid, "subid": subid};
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETPACKAGES,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return packageListModelFromJson(jsonEncode(data));
        },
      );
    } else {
      return null;
    }
  }

  Future<dynamic> getConfirmPlanChange(
      String subid, String packageID, String subUrl) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "subid": subid,
      "packageid": packageID,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        subUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return messageModelFromJson(jsonEncode(data));
        },
      );
    } else {
      return null;
    }
  }

  Future<dynamic> getCAFTypes() async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.CAFTYPELIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return cafTypeDataModelFromJson(
            jsonEncode(data),
          );
        },
      );
    } else {
      return null;
    }
  }

  Future<dynamic> getSUBTypes(String caftypeID) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "caftypeid": "$caftypeID",
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.SUBTYPELIST,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return subTypeModelFromJson(
            jsonEncode(data),
          );
        },
      );
    } else {
      return null;
    }
  }

  Future<dynamic> addPonPort({
    String? subId,
    String? oltId,
    String? ponPort,
    String? packageId,
    required String position,
  }) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "subid": "$subId",
      "oltid": "$oltId",
      "ponportid": "$ponPort",
      "ont_position": position,
      "packageid": "$packageId"
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETADDPONSUB,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    return data;
  }

  removePonPort({String? subId, String? subponportId, String? onlAppId}) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "subid": "$subId",
      "subponportid": "$subponportId",
      "onl_app_id": "$onlAppId",
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETREMOVEMPONSUB,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    return data;
  }

  unMapDevice(String? deviceid, String? subId) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "deviceid": "$deviceid",
      "subid": "$subId"
    };

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.removeDevSub,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    return data;
  }

  mapDevice(String deviceId, String? subId) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "deviceid": deviceId,
      "subid": "$subId"
    };

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.addDevSub,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    return data;
  }

  getAvilDevice() async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
    };

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.avilToMap,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    return data;
  }

  Future<SubscriberLnpRechargeDetailsModel?> getRechargeDetails(
      String subId) async {
    var body = {"partnerid": globalLoginModel?.partnerid, "subid": subId};

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.SUBSCRIBER_LNP_RECHARGE_DETAILS,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );

    if (data != null) {
      return modelErrorHandler(
        () {
          return SubscriberLnpRechargeDetailsModel.fromJson(
            data,
          );
        },
      );
    } else {
      return null;
    }
  }
}
