import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:io' as io;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data_services/api_helper.dart';
import '../data_services/api_type_enum.dart';
import '../widget/global_loader/global_loading_dialog_controller.dart';

class GlobalFunctions {
  static showToast(String msg, bool issuccess) {
    if (msg == "null" || msg.isEmpty) {
      return;
    }
    Fluttertoast.cancel(); //will cancel if old toast is running
    return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: issuccess ? primaryColor : dangerColor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static myPrint(dynamic value, dynamic myClass) {
    if (kDebugMode) {
      print(value);
    }
  }

  static void showDynamicDialog({
    required String title,
    required String content,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    required Function onConfirmClick,
    required Function onCancelClick,
    Widget? child,
  }) {
    Get.defaultDialog(
      title: title,
      content: child ?? Text(content),
      confirm: ElevatedButton(
        onPressed: () {
          onConfirmClick();
// Add your confirm button logic here
        },
        child: Text(confirmButtonTitle),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          onCancelClick();
        },
        child: Text(cancelButtonTitle),
      ),
    );
  }

  static void scrollListener(ScrollController scrollController,
      {required Function scrollEnd, Function? scrollTop}) {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      scrollEnd();
    }
  }
}

myPrint(dynamic value, dynamic myClass) {
  if (kDebugMode) {
    print(value);
  }
}

Color getRandomContrastColor() {
  final Random random = Random();
  while (true) {
    final int red = random.nextInt(256);
    final int green = random.nextInt(256);
    final int blue = random.nextInt(256);
    final double luminance = (0.299 * red + 0.587 * green + 0.114 * blue) / 255;

    if (luminance > 0.5 && red > 160 && green > 200 && blue > 160) {
// Skip light colors and near-gray colors
      continue;
    }

    return Color.fromARGB(255, red, green, blue);
  }
}

Widget buildAppVersionText() {
/* (${packageInfo?.buildNumber})*/
  return Text(
    '${'v'}${packageInfo?.version}',
  );
}

extension StringExtension on String {
  String? textCaps() {
    return isEmpty ? "" : replaceRange(0, 1, this[0].toUpperCase());
  }

  bool checkData() {
    var status = true;

    if (trim() == "null") {
      status = false;
    } else if (isEmpty) {
      status = false;
    }
    return status;
  }

  String removeExtraSpaces() {
    return this?.replaceAll(RegExp(r'\s+'), ' ').trim() ?? "";
  }
}

extension DateTimeExtension on DateTime {
  String? weekdayName() {
    const Map<int, String> weekdayName = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday",
      7: "Sunday"
    };
    return weekdayName[weekday];
  }

  String? monthName() {
    const Map<int, String> monthName = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December"
    };
    return monthName[month];
  }

  bool isSameDate(DateTime? other) {
    if (other == null) return false;
    return year == other.year && month == other.month && day == other.day;
  }

  String formatDate({DateFormat? dateFormat}) {
    final DateFormat formatter = dateFormat ?? DateFormat('dd-MMM-yy');
    final String formatted = formatter.format(this);
    return formatted;
  }

  bool isSameMonthAndYear(DateTime dateTime) {
    return month == dateTime.month && year == dateTime.year;
  }

  bool isSameMonth(DateTime dateTime) {
    return month == dateTime.month;
  }

  bool isSameDay(DateTime dateTime) {
    return month == dateTime.month &&
        year == dateTime.year &&
        day == dateTime.day;
  }

  String get ordinal => ordinalFun(day);

  int get lastDayOfMonth => DateTime(year, month + 1, 0).day;

  DateTime get lastDateOfMonth => DateTime(year, month + 1, 0);
}

String ordinalFun(int number) {
  if (!(number >= 1 && number <= 100)) {
//here you change the range
    throw Exception('Invalid number');
  }

  if (number >= 11 && number <= 13) {
    return '${number}th';
  }

  switch (number % 10) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}

Future<String> fileToBase64(String? filePath) async {
  if (filePath == null || filePath == "null") {
    return "";
  }
  try {
    File file = File(filePath);
    List<int> fileBytes = await file.readAsBytes();
    String base64String = base64Encode(fileBytes);
    return base64String;
  } catch (e) {
    print('Error converting file to base64: $e');
    return '';
  }
}

File? fileOrNull(String? path) {
  try {
    if (path == null) {
      return null;
    } else {
      return File(path);
    }
  } catch (e) {
    return null;
  }
  return null;
}

Future<double> getFileSizeInMB(String? path) async {
  if (path == null) return 0;
  int fileSize = await File(path).length();
  double fileSizeInMB = fileSize / (1024 * 1024);
  return fileSizeInMB;
}

Future<void> launchUrlLocal(String url) async {
  Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

closeKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<File?> downloadPDFByUrl({
  required String pdfUrl,
  String? invoiceNo = "in",
}) async {
  var pdfData = await ApiHelper().downloadFile(
    baseUrlLocal: pdfUrl,
    fullUrl: true,
    methodType: ApiTypeEnum.GET,
  );
  String dir = (await getApplicationDocumentsDirectory()).path;
  var filePath = '$dir/${"$invoiceNo".replaceAll("/", "_")}-Invoice.pdf';
  var file = File(filePath);
  File? fileLast;
  try {
    fileLast = await file.writeAsBytes(pdfData);
  } catch (e) {
    //  print(e);
  }

  if (fileLast == null) {
    return null;
  }
  return fileLast;
}

Future<void> launchInBrowser(
  String url, {
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  // GlobalLoadingDialogController.openDialog();
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
      mode: mode,
    );
  } else {
    GlobalFunctions.showToast("Could not launch $url", false);
    GlobalLoadingDialogController.closeDialog();
    throw 'Could not launch $url';
  }
  //GlobalLoadingDialogController.closeDialog();
}

extension SafeParsing on String? {
  /// Safely converts the string to a double.
  /// If the string is null, cannot be parsed, or is empty, it returns 0.0.
  double safeToDouble() {
    // 1. Check if the string itself is null.
    // 2. Use double.tryParse() which returns null on failure.
    // 3. Use the null-aware operator (??) to return 0.0 if either tryParse()
    //    fails or the original string was null.
    return double.tryParse(this ?? '') ?? 0.0;
  }

  /// Safely converts the string to an integer.
  /// If the string is null, cannot be parsed, or is empty, it returns 0.
  int safeToInt() {
    // Same logic as safeToDouble, but using int.tryParse() and defaulting to 0.
    return int.tryParse(this ?? '') ?? 0;
  }
}
