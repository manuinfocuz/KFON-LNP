import 'package:get/get.dart';

import '../data_model/sub_finance/sub_fin_data_mode.dart';
import '../data_model/sub_finance/subscriber_list_data_model.dart';
import '../data_services/api_helper.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class SubscriberFinanceRepository {
  final ApiHelper _apiHelper = Get.find();
  Future<List<SubscriberListDataModel>?> getSubscriberList() async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getSubListURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        List<SubscriberListDataModel> listData = [];
        data["sublist"].forEach((element) {
          listData.add(SubscriberListDataModel.fromJson(element));
        });

        return listData;
      });
    } else {
      return null;
    }
  }

  getSubscriberFin(String subId, String page) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "page_num": page,
      "subscriberid": subId
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getSubFinURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return SubsFinDataModel.fromJson(data);
      });
    } else {
      return null;
    }
  }
}
