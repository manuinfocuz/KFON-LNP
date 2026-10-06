import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/main_dashboard_model.dart';

import '../data_services/api_helper.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_functions.dart';
import '../utils/global_variables.dart';

class LocalRepository {
  final ApiHelper _apiHelper = Get.find();
  Future<dynamic> getDashBoardData(/*String  caf, String profileID*/) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      // "caftypeid": caf,
      // "profileid":profileID
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETDASHBAORD,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return mainDashBoardModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }


  Future<dynamic> callBackRequest( ) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,

    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.callBackReqUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      GlobalFunctions.showToast(data['Message'], true);
    } else {
      return null;
    }
  }


}
