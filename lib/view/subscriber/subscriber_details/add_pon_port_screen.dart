import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/providers/subscriber/subscriber_details_provider.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_button.dart';

import '../../../models/form_type_model.dart';
import '../../../widget/global_bottomsheet_widget.dart';
import '../../../widget/utils_widgets/custom_textfiled.dart';
import '../../../widget/utils_widgets/value_picker.dart';

class AddPonPortScreen extends StatefulWidget {
  final SubscriberDetailsProvider provider;

  const AddPonPortScreen({
    super.key,
    required this.provider,
  });

  @override
  State<AddPonPortScreen> createState() => _AddPonPortScreenState();
}

class _AddPonPortScreenState extends State<AddPonPortScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add PON Port",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  ValuePicker(
                    callback: () async {
                      if (widget.provider.oltDropDown.isEmpty) {
                        await widget.provider.getOLTList();
                      }
                      Get.bottomSheet(
                        GlobalBottomSheetWidget(
                          canClear: true,
                          clearClick: () {
                            widget.provider.selectedOLTID = null;
                            widget.provider.selectedOLT = null;

                            widget.provider.selectedPonPortID = null;
                            widget.provider.selectedPonPort = null;
                            setState(() {});
                          },
                          title: 'OLT Devices',
                          listData: widget.provider.oltDropDown,
                          dropDownValue: widget.provider.selectedOLTID ?? "",
                          onClick: (DropDownDataModel value) async {
                            widget.provider.selectedPonPortID = null;
                            widget.provider.selectedPonPort = null;

                            widget.provider.selectedOLTID = value.id;
                            widget.provider.selectedOLT = value.value;
                            await widget.provider.getPonList();
                            setState(() {});
                          },
                        ),
                      );
                    },
                    selectedValue:
                        widget.provider.selectedOLT ?? "Select OLT Device",
                    canClick: true,
                    hint: "Select OLT Device",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValuePicker(
                    callback: () async {
                      if (widget.provider.ponPortDropDown.isEmpty) {
                        await widget.provider.getPonList();
                      }
                      Get.bottomSheet(
                        GlobalBottomSheetWidget(
                          canClear: true,
                          clearClick: () {
                            widget.provider.selectedPonPortID = null;
                            widget.provider.selectedPonPort = null;
                            setState(() {});
                          },
                          title: 'PON Port Number',
                          listData: widget.provider.ponPortDropDown,
                          dropDownValue:
                              widget.provider.selectedPonPortID ?? "",
                          onClick: (DropDownDataModel value) {
                            widget.provider.selectedPonPortID = value.id;
                            widget.provider.selectedPonPort = value.value;
                            setState(() {});
                          },
                        ),
                      );
                    },
                    selectedValue: widget.provider.selectedPonPort ??
                        "Select PON Port Number",
                    canClick: true,
                    hint: "Select PON Port Number",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    inputType: TextInputType.number,
                    lableText: "ONT Position",
                    controller: widget.provider.oltPosition,
                    needIncrease: true,
                    onIncrease: () {
                      widget.provider.oltPosition.text =
                          "${(int.tryParse(widget.provider.oltPosition.text) ?? 0) + 1}";
                    },
                    onDecrease: () {
                      var nowData =
                          (int.tryParse(widget.provider.oltPosition.text) ??
                                  0) -
                              1;
                      if (nowData < 0) {
                        return;
                      }
                      widget.provider.oltPosition.text = "$nowData";
                    },
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: CustomButton(
              title: "Save",
              onClickFunction: () {
                widget.provider.addPonPort();
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
