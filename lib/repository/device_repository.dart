import 'package:get/get.dart';
import 'package:kfon_lnp/data_services/api_helper.dart';

import '../data_model/inventory/device_list_data_model.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class DeviceRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<DeviceListDataModel?> getDeviceList({
    required String pageNo,
    required String? filter,
    required String? searchValue,
  }) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "page_num": pageNo,
      'device_status': filter ?? "",
      'sarchval': searchValue ?? ''
    };

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.inveDeviceListUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return DeviceListDataModel.fromJson(data);
        },
      );
    } else {
      return null;
    }
  }
}
