import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/widget/error_text_build.dart';

import '../../models/form_type_model.dart';
import '../../providers/subscriber/sub_create_provider.dart';
import '../global_bottomsheet_widget.dart';
import '../utils_widgets/value_picker.dart';

class DropDownForm extends StatelessWidget {
  final FromTypeModel singleItem;
  final int mainIndex;
  final SubCreateProvider subCreateProvider;

  const DropDownForm({
    super.key,
    required this.singleItem,
    required this.mainIndex,
    required this.subCreateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ValuePicker(
            canClick: singleItem.dropDownDataModel?.isNotEmpty ?? false,
            callback: () {
              if (!singleItem.isEditable) {
                return;
              }
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  onClick: (value) {
                    singleItem.selectedValue = value.key;
                    singleItem.selectedDisplayValue = value.value;

                    print(singleItem.key);
                    if ((mainIndex == 1 || mainIndex == 2) &&
                        singleItem.key == "PIE") {
                      singleItem.selectedValue = value.key;
                      singleItem.selectedDisplayValue = value.value;

                      subCreateProvider.removeValueByKey(mainIndex, "PON");
                      subCreateProvider.removeValueByKey(mainIndex, "DIT");
                      subCreateProvider.removeValueByKey(mainIndex, "LBY");

                      subCreateProvider
                          .findByKey(mainIndex, "LBY")
                          ?.dropDownDataModel = [];

                      // subCreateProvider.getDistrictAndPostOffice(
                      //     value.key, mainIndex);
                    } else if ((mainIndex == 1 || mainIndex == 2) &&
                        singleItem.key == "PON") {
                      singleItem.selectedValue = value.key;
                      singleItem.selectedDisplayValue = value.value;
                      subCreateProvider.removeValueByKey(mainIndex, "DIT");
                      subCreateProvider.removeValueByKey(mainIndex, "LBY");
                      subCreateProvider
                          .findByKey(mainIndex, "LBY")
                          ?.dropDownDataModel = [];
                    } else if ((mainIndex == 1 || mainIndex == 2) &&
                        singleItem.key == "DIT") {
                      subCreateProvider.removeValueByKey(mainIndex, "LBY");
                      singleItem.selectedValue = value.key;
                      singleItem.selectedDisplayValue = value.value;
                      subCreateProvider
                          .findByKey(mainIndex, "LBY")
                          ?.dropDownDataModel = [];
                      if (subCreateProvider
                                  .findByKey(mainIndex, "LTY")
                                  ?.selectedValue !=
                              null &&
                          subCreateProvider
                              .findByKey(mainIndex, "LTY")!
                              .selectedValue
                              .toString()
                              .isNotEmpty) {
                        // subCreateProvider.getLocalBodyList(mainIndex);
                      }
                    } else if ((mainIndex == 1 || mainIndex == 2) &&
                        singleItem.key == "LBY") {
                      singleItem.selectedValue = value.key;
                      singleItem.selectedDisplayValue = value.value;
                      // subCreateProvider.getVBM(mainIndex);
                    } else if ((mainIndex == 1 || mainIndex == 2) &&
                        singleItem.key == "VIN") {
                      singleItem.selectedValue = value.key;
                      singleItem.selectedDisplayValue = value.value;
                    } else if ((mainIndex == 1 || mainIndex == 2) &&
                        singleItem.key == "BLN") {
                      singleItem.selectedValue = value.key;
                      singleItem.selectedDisplayValue = value.value;
                    } else if ((mainIndex == 1 || mainIndex == 2) &&
                        singleItem.key == "CMN") {
                      singleItem.selectedValue = value.key;
                      singleItem.selectedDisplayValue = value.value;
                    }
                    singleItem.errorText = null;
                    subCreateProvider.refreshState();
                  },
                  listData: singleItem.dropDownDataModel ?? [],
                  dropDownValue: singleItem.selectedValue,
                  title: 'Select ${singleItem.name}',
                ),
                backgroundColor: Colors.transparent,
              );
            },
            selectedValue: singleItem.selectedDisplayValue!.toString().isEmpty
                ? 'Select ${singleItem.name}'
                : singleItem.selectedDisplayValue!.toString(),
            hint: "",
          ),
        ),
        if (singleItem.errorText != null)
          Row(
            children: [
              errorTextBuilder(singleItem.errorText),
            ],
          )
      ],
    );
  }
}
