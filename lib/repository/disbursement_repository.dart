import 'package:get/get.dart';

import 'package:kfon_lnp/data_model/sub_finance/disbursement_month_list_model.dart';
import 'package:kfon_lnp/data_services/api_helper.dart';

import '../data_model/sub_finance/disbursement_data_model.dart';
import '../data_model/sub_finance/disbursement_details_data_model.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class DisbursementRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<DisbursementDataModel?> getDisbursementList(
      {required String pageNo, String? dMonth}) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "page_num": pageNo,
      "dmonth": dMonth ?? ""
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getDisburURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return DisbursementDataModel.fromJson(data);
        },
      );
    } else {
      return null;
    }
  }

  Future<DisbursementMonthDataModel?> getMonthList() async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getMonthListURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return DisbursementMonthDataModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<DisbursementDetailsDataModel?> getRevShare({
    required String date,
    required String pageNo, required int cause,
  }) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "cause": cause,
      "ddate": date,
      "page_num": pageNo
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getRevShareURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return DisbursementDetailsDataModel.fromJson(data);
      });
    } else {
      return null;
    }
  }
}
