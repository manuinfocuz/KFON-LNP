import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> datePickerWidget(Function(DateTime? dateTime) callback) {
  return Get.dialog(
    DatePickerDialog(
      restorationId: 'date_picker_dialog',
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime
          .now() /*.subtract(
        const Duration(days: 6574),
      )*/
      ,
      firstDate: DateTime.now().subtract(
        const Duration(days: 36525),
      ),
      lastDate: DateTime
          .now() /*.subtract(
        const Duration(days: 6574),
      )*/
      ,
    ),
  ).then(
    (value) {
      if (value != null) {
        value as DateTime;
        callback(value);
      }
    },
  );
}
