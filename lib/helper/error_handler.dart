import 'dart:convert';
import 'dart:io';

import 'package:localization/localization.dart';

import '../data_services/app_exception.dart';
import '../utils/global_functions.dart';

var tag = "errorHandler";

Future<dynamic> errorHandler(Future multiMethod,
    {bool canShowError = true, bool canReturn = false}) async {
  try {
    var data = await multiMethod;
    if (canReturn) {
      return data;
    }
    if (data["status"]) {
      return data;
    } else {
      canShowError
          ? GlobalFunctions.showToast("${data["Message"]}", false)
          : null;
      return null;
    }

    return data;
  } on BadRequestException catch (e) {
    canShowError ? GlobalFunctions.showToast("$e", false) : null;
  } on UnauthorisedException catch (e) {
    canShowError ? GlobalFunctions.showToast("$e", false) : null;
  } on SocketException catch (e) {
    canShowError ? GlobalFunctions.showToast(e.message, false) : null;
  } on TokenExpiredException catch (e) {
    print("Data token is :${e}");
  } catch (e) {
    print(e);
    canShowError ? GlobalFunctions.showToast("apiError".i18n(), false) : null;
  }
  return null;
}

dynamic modelErrorHandler(dynamic method) {
  try {
    return method();
  } catch (e) {
    print("${e}");
    GlobalFunctions.showToast("modelError".i18n(["$e"]), false);
    rethrow;
    return null;
  }
}
