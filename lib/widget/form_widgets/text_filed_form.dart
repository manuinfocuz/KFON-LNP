import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/models/form_type_model.dart';
import 'package:kfon_lnp/utils/global_functions.dart';

import '../../providers/subscriber/sub_create_provider.dart';
import '../utils_widgets/custom_textfiled.dart';

class TextFiledForm extends StatelessWidget {
  final FromTypeModel singleItem;
  final int mainIndex;
  final SubCreateProvider subCreateProvider;

  const TextFiledForm({
    super.key,
    required this.singleItem,
    required this.mainIndex,
    required this.subCreateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: CustomTextField(
        inputFormatter: [
          if (singleItem.isDigit) FilteringTextInputFormatter.digitsOnly
        ],
        onTab: () {
          if (singleItem.key == "DOB") {
            Get.dialog(
              DatePickerDialog(
                restorationId: 'date_picker_dialog',
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                initialDate:
                    DateTime.now().subtract(const Duration(days: 6205)),
                firstDate: DateTime.now().subtract(const Duration(days: 36525)),
                lastDate: DateTime.now().subtract(const Duration(days: 6205)),
              ),
            ).then(
              (value) {
                if (value != null) {
                  value as DateTime;
                  singleItem.textEditingController?.text =
                      value.formatDate(dateFormat: DateFormat('yyyy-MM-dd'));
                }
              },
            );
          }
        },
        errorText: singleItem.errorText,
        maxLength: singleItem.max,
        prefixWidget: singleItem.preFix,
        inputType: singleItem.inputType,
        isPhone: singleItem.isDigit,
        isEditable: singleItem.isEditable,
        lableText: singleItem.name,
        isPassword: false,
        onChangeText: (e) {
          subCreateProvider
              .findByKey(6, "TAXPY")
              ?.textEditingController
              ?.clear();
          subCreateProvider
              .findByKey(6, "LNOB")
              ?.textEditingController
              ?.clear();
          subCreateProvider
              .findByKey(6, "TRAN")
              ?.textEditingController
              ?.clear();

          singleItem.errorText = null;
          if (singleItem.key == "DEU") {
            subCreateProvider.checkUserName(e);
          }

          if (singleItem.key == "GSPA") {
            var keyDatas = subCreateProvider.findByKey(6, "GSTIN");
            keyDatas?.filedController[1].text = e;
            subCreateProvider.checkGSTIN();
          }
          subCreateProvider.refreshState();
        },
        controller: singleItem.textEditingController!,
      ),
    );
  }
}
