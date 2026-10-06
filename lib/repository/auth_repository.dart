import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data_services/api_helper.dart';
import '../../data_services/api_type_enum.dart';
import '../../helper/error_handler.dart';
import '../../utils/api_end_points.dart';
import '../../utils/global_functions.dart';
import '../data_model/auth/login_data_model.dart';
import '../data_model/auth/profile_data_model.dart';
import '../data_model/auth/token_model.dart';
import '../data_model/message_model.dart';
import '../utils/global_variables.dart';

var tag = "AuthRepository";

class AuthRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<dynamic> getTokeKey() async {
    var body = {
      "username": un,
      "password": pw,
    };

    var data = await errorHandler(
      _apiHelper.multiMethod(AppEndPoints.BASEURL, AppEndPoints.GETTOKEN,
          methodtype: ApiTypeEnum.POST, body: body),
    );
    if (data != null) {
      return modelErrorHandler(() {
        return tokenModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }



  // Future<dynamic> callLogin(String username, String password) async {
  //   var body = {
  //     "username": username,
  //     "password": password,
  //   };
  //   var data = await errorHandler(
  //     _apiHelper.multiMethod(
  //       AppEndPoints.BASEURL,
  //       AppEndPoints.POSTLOGIN,
  //       methodtype: ApiTypeEnum.POST,
  //       body: body,
  //       type: 2,
  //       token: "$tokenTemp",
  //     ),
  //   );
  //   myPrint(data, tag);
  //   if (data != null) {
  //     return modelErrorHandler(() {
  //       return loginDataModelFromJson(jsonEncode(data));
  //     });
  //   } else {
  //     return null;
  //   }
  // }


  Future<dynamic> reLoginCheck(String username, String password) async {
    var body = {
      "username": username,
      "password": password,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.SUB_LOGIN_RE,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    print('>>>>>>>>  $data');
    myPrint(data, tag);
    if (data != null) {
      return modelErrorHandler(() {
        return loginDataModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }


  Future<dynamic> sendOtpForLogin(String username, String password) async {
    var body = {
      "username": username,
      "password": password,
    };
    print('>>>>>>>>> body  $body');
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.SEND_OTP_FOR_LOGIN,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    print('>>>>>>>>>> sendotp$data');
    myPrint(data, tag);
    if (data != null) {
      return modelErrorHandler(() {
        return loginDataModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> verifyOtpForLogin(String username, String password, String otp) async {
    var body = {
      "username": username,
      "password": password,
      "otp": otp,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.SUB_LOGIN,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    print('>>>>>>>> verifyotp$data');
    myPrint(data, tag);
    if (data != null) {
      return modelErrorHandler(() {
        return loginDataModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> sendOTP(String partnerID) async {
    var body = {
      "partnerid": partnerID,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.FOGETPASSWORD,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    myPrint(data, tag);
    if (data != null) {
      return modelErrorHandler(() {
        return messageModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

  Future<dynamic> verifyOTP(String partnerID, String otp) async {
    var body = {"partnerid": partnerID, "otp": otp};
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.VALIDATEOTP,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    myPrint(data, tag);
    if (data != null) {
      return modelErrorHandler(() {
        return messageModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

//
  Future<dynamic> getProfile() async {
    var body = {
      "partnerid": "${globalLoginModel?.partnerid}",
      // "password": password,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.POSTPROFILE,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    myPrint(data, tag);
    if (data != null) {
      return modelErrorHandler(() {
        return profileDataModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }

//
// Future<dynamic> getHomeData() async {
//   var body = {
//     "username": "${globalLoginModel?.username}",
//     "subid": "${globalLoginModel?.subscriberid}",
//     // "password": password,
//   };
//   var data = await errorHandler(
//     _apiHelper.multiMethod(
//       BASEURL,
//       SUB_GET_HOME_DATA,
//       methodtype: ApiTypeEnum.POST,
//       body: body,
//       type: 2,
//       token: "$tokenTemp",
//     ),
//   );
//   myPrint(data, tag);
//   if (data != null) {
//     return modelErrorHandler(() {
//       return imageListModelFromJson(jsonEncode(data));
//     });
//   } else {
//     return null;
//   }
// }
//
// Future<dynamic> getAboutData() async {
//   var body = {
//     "username": "${globalLoginModel?.username}",
//     "subid": "${globalLoginModel?.subscriberid}",
//     // "password": password,
//   };
//   var data = await errorHandler(
//     _apiHelper.multiMethod(
//       BASEURL,
//       SUB_GET_ABOUT,
//       methodtype: ApiTypeEnum.POST,
//       body: body,
//       type: 2,
//       token: "$tokenTemp",
//     ),
//   );
//   myPrint(data, tag);
//   if (data != null) {
//     return modelErrorHandler(() {
//       return aboutDataModelFromJson(jsonEncode(data));
//     });
//   } else {
//     return null;
//   }
// }
//
  Future<dynamic> changePass(
      String oldPass, String newPass, String confirmPass) async {
    var body = {
      "partnerid": "${globalLoginModel?.partnerid}",
      "chnagefor": "1",
      "oldpass": oldPass,
      "newpass": newPass,
      "confpass": confirmPass,
    };
    var data = await errorHandler(
      _apiHelper.multiMethod(
        AppEndPoints.BASEURL,
        AppEndPoints.CHANGEPASSWORD,
        methodtype: ApiTypeEnum.POST,
        body: body,
        type: 2,
        token: "$tokenTemp",
      ),
    );
    myPrint(data, tag);
    if (data != null) {
      return modelErrorHandler(() {
        return messageModelFromJson(jsonEncode(data));
      });
    } else {
      return null;
    }
  }
//
}
