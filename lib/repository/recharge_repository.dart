import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/message_model.dart';
import 'package:kfon_lnp/data_model/recharge/payment_gateway_details.dart';
import 'package:kfon_lnp/data_model/recharge/recharge_history_model.dart';

import '../data_services/api_helper.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class RechargeRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<dynamic> getRechargeHistory(int page) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "page_num": page,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.RECHARGEHISTORYURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return rechargeHistoryModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getPaymentGatewayDetails(int type, String amount) async {
    var body = {"partnerid": globalLoginModel?.partnerid, "amount": amount};
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        type == 0 ? AppEndPoints.IKMGATEWAYURL : AppEndPoints.HDFCGATEWAYURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return paymentGatewayDetailsFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> checkStatusById(String orderNumber) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "ordernumber": orderNumber
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.CHECKREACHARGE,
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
}
