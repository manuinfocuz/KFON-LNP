import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app_exception.dart';

dynamic ResponseHandler(http.Response response) {

  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      var resjson = json.decode(response.body.toString());
      print("error is....$resjson");
      throw BadRequestException(resjson["error"]);
    case 401:
      var resjson = json.decode(response.body.toString());
      throw TokenExpiredException(resjson["error"]);
    case 403:
      var resjson = json.decode(response.body.toString());
      throw UnauthorisedException(resjson["error"]);
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
