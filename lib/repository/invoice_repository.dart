import 'dart:convert';

import 'package:get/get.dart';
import 'package:kfon_lnp/data_model/subscriber/aadhar_otp_sent_data_model.dart';
import 'package:kfon_lnp/data_services/api_helper.dart';

import '../data_model/recharge/invoice_list_data_model.dart';
import '../data_model/subscriber/aadharDetailsModel.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class InvoiceRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<InvoiceListDataModel?> getInvoiceList({
    required String pageNum,
  }) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "page_num": "$pageNum",
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getInvoiceListURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return InvoiceListDataModel.fromJson(
            data,
          );
        },
      );
    } else {
      return null;
    }
  }

  getInvoiceUrl({required String slno}) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "slno": slno,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getInvoiceURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );

    if (data != null) {
      return data["view_url"];
    }
  }
}
