import 'dart:ffi';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:open_file/open_file.dart';

import '../../models/form_type_model.dart';
import '../../providers/subscriber/sub_create_provider.dart';
import '../../utils/global_functions.dart';
import '../../utils/style.dart';
import '../global_bottomsheet_widget.dart';
import '../utils_widgets/custom_button.dart';
import '../utils_widgets/custom_textfiled.dart';
import '../utils_widgets/value_picker.dart';

class FormUpload extends StatelessWidget {
  final double maxSize;
  final String title;
  final bool showTypePicker;
  final bool showIdNumber;
  final SubCreateProvider subCreateProvider;
  final String? selectedPath;
  final String? dropDownSelectedID;
  final String? dropDownSelected;
  final List<DropDownDataModel> dropDownData;
  final Function callBackValuedDropDown;
  final Function(DropDownDataModel value)? callBackDropDownClick;
  final Function(String? value) onDocPicked;
  final TextEditingController? textEditingController;
  final bool isOnlyView;
  final bool isRequired;
  const FormUpload({
    super.key,
    required this.subCreateProvider,
    required this.title,
    required this.showTypePicker,
    required this.showIdNumber,
    required this.selectedPath,
    required this.dropDownSelected,
    required this.dropDownSelectedID,
    required this.callBackValuedDropDown,
    required this.onDocPicked,
    this.dropDownData = const [],
    this.callBackDropDownClick,
    this.textEditingController,
    this.maxSize = 1.5,
    this.isOnlyView = false,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Text(
            //   title,
            //   style: appTextStyle(fontSize: 16),
            // ),

            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    child: Text(
                      title ?? "",
                      style: appTextStyle(fontSize: 16),
                    ),
                  ),
                  if (isRequired)
                    const WidgetSpan(
                      child: Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            if (showTypePicker)
              ValuePicker(
                callback: () async {
                  callBackValuedDropDown().then((e) {
                    Get.bottomSheet(
                      GlobalBottomSheetWidget(
                        onClick: (value) {
                          if (callBackDropDownClick != null) {
                            callBackDropDownClick!(value);
                          }
                        },
                        listData: e ?? dropDownData ?? [],
                        dropDownValue: dropDownSelectedID ?? "",
                        title: 'Select $title',
                      ),
                      backgroundColor: Colors.transparent,
                    );
                  });
                },
                canClick: !isOnlyView,
                selectedValue: dropDownSelected ?? "Select $title",
                hint: "",
              ),
            if (showIdNumber)
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isEditable: !isOnlyView,
                    lableText: "ID Number",
                    isPassword: false,
                    onChangeText: (e) {},
                    controller:
                        textEditingController ?? TextEditingController(),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isOnlyView)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: Get.size.width / 2,
                    child: CustomButton(
                      icon: selectedPath == null ? Icons.upload : Icons.clear,
                      title: selectedPath == null ? "Upload" : "Clear",
                      onClickFunction: () async {
                        if (selectedPath == null) {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          double size = await getFileSizeInMB(result?.paths[0]);
                          if (size > maxSize) {
                            GlobalFunctions.showToast(
                                "File is more than $maxSize Mb", false);
                          } else {
                            onDocPicked(result?.paths.firstOrNull);
                          }
                        } else {
                          onDocPicked(null);
                        }

                        subCreateProvider.refreshState();
                      },
                    ),
                  ),
                if (selectedPath != null)
                  IconButton(
                    onPressed: () {
                      OpenFile.open(selectedPath);
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                    ),
                  )
              ],
            ),
            if (!isOnlyView)
              Text(
                "* Document should be less then $maxSize Mb",
                style: appTextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
