import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data_services/api_helper.dart';
import '../data_model/my_sup/sub_enq_details_data_model.dart';
import '../data_model/my_sup/sub_enq_list_data_model.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

var tag = "NewEnquiresRepository";

class NewEnquiresRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<SubEnqListDataModel?> getEnqList(
      String page, String? filterBy, String? filterValue) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "page_num": page,
      "filterby":
          filterValue == null || filterValue.isEmpty ? "" : filterBy ?? "",
      "filtervalue": filterValue ?? "",
    };
    // searchParams?.forEach((e) {
    //   if (e.controller.text.isNotEmpty) {
    //     body["${e.headings}"] = e.controller.text;
    //   }
    // });

    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getSubEnqListUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return SubEnqListDataModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<SubEnqDetailsDataModel?> getSingleitemView(String enqid) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "enqid": enqid,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getSubEnqViewUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return SubEnqDetailsDataModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  getAllStatusList() async {
    // var body = {
    //   "partnerid": globalLoginModel?.partnerid,
    //   "enqid": enqid,
    // };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getSubEnqStatusList,
        methodtype: ApiTypeEnum.GET,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    return data;
  }

  updateEnqStatus(String enqid, String status, String remarks) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "enqid": enqid,
      "status": status,
      "remarks": remarks,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.updateSubEnqStatus,
        methodtype: ApiTypeEnum.POST,
        type: 2,
        body: body,
        token: "$tokenTemp",
      ),
    );

    return data;
  }
}
