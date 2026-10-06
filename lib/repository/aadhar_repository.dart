import 'dart:convert';

import 'package:get/get.dart';
import 'package:kfon_lnp/data_model/subscriber/aadhar_otp_sent_data_model.dart';
import 'package:kfon_lnp/data_services/api_helper.dart';

import '../data_model/subscriber/aadharDetailsModel.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../utils/api_end_points.dart';
import '../utils/global_variables.dart';

class AadharRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<dynamic> validateAadhar(
      String aadharNumber, String email, String mobileNumber) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "aadhaarnumber": aadharNumber,
      "email": email,
      "mbnumber": mobileNumber
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.GETAADHAROTP,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return aadharOtpSentDataModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> verifyOTP(
      String aadharNumber, String txnID, String reqID, String OTP) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "aadhaarnumber": aadharNumber,
      "txnid": txnID,
      "reqsid": reqID,
      "otp": OTP
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.AADHARVERIFYOTP,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return AadharDetailsModel.fromJson(data);
      });
    } else {
      return null;
    }
  }

  Future<dynamic> aadharDetails(
    String aadharNumber,
    String reqID,
  ) async {
    var body = {
      "partnerid": globalLoginModel?.partnerid,
      "aadhaarnumber": aadharNumber,
      "reqsid": reqID,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.AADHARDETAILS,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return AadharDetailsModel.fromJson(data);
      });
    } else {
      return null;
    }
  }
}
