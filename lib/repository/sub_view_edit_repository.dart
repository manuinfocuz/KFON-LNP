import 'package:get/get.dart';
import 'package:kfon_lnp/data_model/subscriber/caf_details_data_model.dart';
import 'package:kfon_lnp/data_services/api_helper.dart';

import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class SubViewEditRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<dynamic> getSubmittedCAFDetails(String cafID) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "cafid": cafID,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getCAFDetailsURL,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(
        () {
          return CafDetailsDataModel.fromJson(data);
        },
      );
    } else {
      return null;
    }
  }
}
