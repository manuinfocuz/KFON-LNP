import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/message_model.dart';
import 'package:kfon_lnp/utils/global_functions.dart';

import '../data_model/ticket/ticket_details_model.dart';
import '../data_model/ticket/ticket_list_model.dart';
import '../data_model/ticket/ticket_subject_model.dart';
import '../data_services/api_helper.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class TicketRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<dynamic> getTicketSubject() async {
    var body = {};
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getTicketSubjectUrl,
        methodtype: ApiTypeEnum.POST,
        //  body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return TicketSubjectModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<dynamic> postNewIssue(
    String issueID,
    String desc,
    String? imagePath,
    String? imageName,
  ) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid ?? "",
      "slno": issueID,
      "description": desc,
    };

    Map<String, dynamic> files = {
      "attachment": [
        imagePath,
      ]
    };
    var data = await errorHandler(
      _apiHelper.multiPart(
        AppEndPoints.BASEURL,
        AppEndPoints.createTicketUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        files: files,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return MessageModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getTicketListScreen(int pageNum) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "page_num": "$pageNum"
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getTicketListUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return TicketListModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<dynamic> getTicketDetails(String ticketID) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "ticketid": "${ticketID}"
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.getTicketDetailsUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return TicketDetailsModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<dynamic> replyTicket(String ticketID, String reply) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "ticketid": ticketID,
      "description": reply
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.addTicketCmdUrl,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return MessageModel.fromJson(data);
      });
    } else {
      return null;
    }
  }
}
