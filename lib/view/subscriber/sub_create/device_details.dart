import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/providers/subscriber/sub_create_provider.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';
import 'package:provider/provider.dart';

import '../../../models/form_type_model.dart';
import '../../../providers/local_providers/local_provider.dart';
import '../../../utils/style.dart';
import '../../../widget/global_bottomsheet_widget.dart';
import '../../../widget/global_loader/global_loading_dialog_controller.dart';
import '../../../widget/utils_widgets/value_picker.dart';

class DeviceDetails extends StatefulWidget {
  final SubCreateProvider subCreateProvider;
  final String caf;
  final String profileID;

  const DeviceDetails({
    super.key,
    required this.subCreateProvider,
    required this.caf,
    required this.profileID,
  });

  @override
  State<DeviceDetails> createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  LocaleProvider localeProvider = Get.find();

  @override
  Widget build(BuildContext context) {

    // widget.subCreateProvider.selectedONTDeviceID = null;
    // widget.subCreateProvider.selectedONTDeviceSLNO = null;
    // widget.subCreateProvider.ontDeviceDropDown = [];
    // bool canEditDevice =
    //     widget.subCreateProvider.selectedDeviceProviderID == "1";
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "ONT Device Details",
            style: appTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ValuePicker(
            callback: () async {
              if (widget.subCreateProvider.deviceProviderDropDown.isEmpty) {
                await widget.subCreateProvider.getDeviceProviderList();
              }
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select Device Provider',
                  listData: widget.subCreateProvider.deviceProviderDropDown,
                  dropDownValue:
                      widget.subCreateProvider.selectedDeviceProviderID ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.selectedDeviceProviderID =
                        value.id;
                    widget.subCreateProvider.selectedDeviceProvider =
                        value.value;

                    if (value.id == "1") {
                      widget.subCreateProvider.getDeviceONTList();
                    } else {
                      widget.subCreateProvider.configureSSID.value = false;
                      clearConfigSSID();

                      widget.subCreateProvider.deviceMakeController.text = "";
                      widget.subCreateProvider.deviceModelController.text = "";
                      widget.subCreateProvider.deviceMacAddress.text = "";
                    }

                    setState(() {});
                  },
                ),
              );
            },
            selectedValue: widget.subCreateProvider.selectedDeviceProvider ??
                "Select Device Provider",
            canClick: true,
            hint: "Select Device Provider",
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          if (widget.subCreateProvider.selectedDeviceProviderID == "1")
            Column(
              children: [
                ValuePicker(
                  callback: () async {
                    if (widget
                        .subCreateProvider.deviceProviderDropDown.isEmpty) {
                      await widget.subCreateProvider.getDeviceProviderList();
                    }
                    Get.bottomSheet(
                      GlobalBottomSheetWidget(
                        title: 'Select Device',
                        listData: widget.subCreateProvider.ontDeviceDropDown,
                        dropDownValue:
                            widget.subCreateProvider.selectedONTDeviceID ?? "",
                        onClick: (DropDownDataModel value) {
                          widget.subCreateProvider.selectedONTDeviceID =
                              value.id;
                          widget.subCreateProvider.selectedONTDeviceSLNO =
                              value.value;
                          widget.subCreateProvider.getONTDeviceDetails();
                          setState(() {});
                        },
                        canClear: true,
                        clearClick: () {
                          widget.subCreateProvider.selectedONTDeviceID = null;
                          widget.subCreateProvider.selectedONTDeviceSLNO = null;
                          widget.subCreateProvider.configureSSID.value = false;
                          clearConfigSSID();

                          widget.subCreateProvider.deviceMakeController.text =
                              "";
                          widget.subCreateProvider.deviceModelController.text =
                              "";
                          widget.subCreateProvider.deviceMacAddress.text = "";
                        },
                      ),
                    );
                  },
                  selectedValue:
                      widget.subCreateProvider.selectedONTDeviceSLNO ??
                          "Select Device",
                  canClick: true,
                  hint: "Select Device",
                  // isRequired: true,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ValuePicker(
            callback: () async {
              if (widget.subCreateProvider.deviceTypeDropDown.isEmpty) {
                await widget.subCreateProvider.getDeviceTypeList();
              }
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select Device Type',
                  listData: widget.subCreateProvider.deviceTypeDropDown,
                  dropDownValue:
                      widget.subCreateProvider.selectedDeviceTypeID ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.selectedDeviceTypeID = value.id;
                    widget.subCreateProvider.selectedDeviceType = value.value;

                    if (value.id == "1") {
                      widget.subCreateProvider.ssid5Controller.clear();
                      widget.subCreateProvider.ssidPassword5Controller.clear();
                    }
                    setState(() {});
                  },
                ),
              );
            },
            selectedValue: widget.subCreateProvider.selectedDeviceType ??
                "Select Device Type",
            canClick: true,
            hint: "Select Device Type",
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            lableText: "VLAN ID",
            controller: widget.subCreateProvider.vlanIDController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            isEditable: widget.subCreateProvider.selectedONTDeviceID == null,
            lableText: "Device Make",
            controller: widget.subCreateProvider.deviceMakeController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            isEditable: widget.subCreateProvider.selectedONTDeviceID == null,
            lableText: "Device Model",
            controller: widget.subCreateProvider.deviceModelController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            isEditable: widget.subCreateProvider.selectedONTDeviceID == null,
            lableText: "Device Mac Address",
            controller: widget.subCreateProvider.deviceMacAddress,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () async {
              if (widget.subCreateProvider.ontDropDown.isEmpty) {
                await widget.subCreateProvider.getONTList();
              }
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select OLT Type',
                  listData: widget.subCreateProvider.ontDropDown,
                  dropDownValue: widget.subCreateProvider.selectedONTID ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.selectedONTID = value.id;
                    widget.subCreateProvider.selectedONT = value.value;
                    setState(() {});
                  },
                ),
              );
            },
            selectedValue:
                widget.subCreateProvider.selectedONT ?? "Select OLT Type",
            canClick: true,
            hint: "Select OLT Type",
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          if (localeProvider.profileDataModel?.enableAcs == "1")
            Row(
              children: [
                Obx(
                  () => Switch(
                    value: widget.subCreateProvider.configureSSID.value,
                    onChanged: (bool status) {
                      if (widget.subCreateProvider.selectedDeviceTypeID !=
                              null &&
                          widget.subCreateProvider.selectedDeviceProviderID ==
                              "1") {
                        if (!status) {
                          clearConfigSSID();
                        }
                        widget.subCreateProvider.configureSSID.value = status;
                      }
                    },
                  ),
                ),
                const Text(
                  "Configure SSID",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          if (widget.subCreateProvider.selectedDeviceTypeID != null &&
              widget.subCreateProvider.selectedDeviceProviderID == "1")
            Obx(
              () => widget.subCreateProvider.configureSSID.value
                  ? Column(
                      children: [
                        getSsidDetails(
                          widget.subCreateProvider,
                          "2.4GHz",
                        ),
                        if (widget.subCreateProvider.selectedDeviceTypeID ==
                            "4")
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              getSsidDetails(
                                widget.subCreateProvider,
                                "5GHz",
                              ),
                            ],
                          ),
                      ],
                    )
                  : const SizedBox(),
            ),
          if (localeProvider.profileDataModel?.oltProvider?.toUpperCase() ==
              "KFON")
            Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "OLT Device Details",
                  style: appTextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ValuePicker(
                  callback: () async {
                    if (widget.subCreateProvider.oltDropDown.isEmpty) {
                      await widget.subCreateProvider.getOLTList();
                    }
                    Get.bottomSheet(
                      GlobalBottomSheetWidget(
                        canClear: true,
                        clearClick: () {
                          widget.subCreateProvider.selectedOLTID = null;
                          widget.subCreateProvider.selectedOLT = null;

                          widget.subCreateProvider.selectedPonPortID = null;
                          widget.subCreateProvider.selectedPonPort = null;
                          setState(() {});
                        },
                        title: 'OLT Devices',
                        listData: widget.subCreateProvider.oltDropDown,
                        dropDownValue:
                            widget.subCreateProvider.selectedOLTID ?? "",
                        onClick: (DropDownDataModel value) async {
                          widget.subCreateProvider.selectedPonPortID = null;
                          widget.subCreateProvider.selectedPonPort = null;

                          widget.subCreateProvider.selectedOLTID = value.id;
                          widget.subCreateProvider.selectedOLT = value.value;
                          await widget.subCreateProvider.getPonList();
                          setState(() {});
                        },
                      ),
                    );
                  },
                  selectedValue: widget.subCreateProvider.selectedOLT ??
                      "Select OLT Device",
                  canClick: true,
                  hint: "Select OLT Device",
                ),
                const SizedBox(
                  height: 10,
                ),
                ValuePicker(
                  callback: () async {
                    if (widget.subCreateProvider.ponPortDropDown.isEmpty) {
                      await widget.subCreateProvider.getPonList();
                    }
                    Get.bottomSheet(
                      GlobalBottomSheetWidget(
                        canClear: true,
                        clearClick: () {
                          widget.subCreateProvider.selectedPonPortID = null;
                          widget.subCreateProvider.selectedPonPort = null;
                          setState(() {});
                        },
                        title: 'PON Port Number',
                        listData: widget.subCreateProvider.ponPortDropDown,
                        dropDownValue:
                            widget.subCreateProvider.selectedPonPortID ?? "",
                        onClick: (DropDownDataModel value) {
                          widget.subCreateProvider.selectedPonPortID = value.id;
                          widget.subCreateProvider.selectedPonPort =
                              value.value;
                          setState(() {});
                        },
                      ),
                    );
                  },
                  selectedValue: widget.subCreateProvider.selectedPonPort ??
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
                  controller: widget.subCreateProvider.oltPosition,
                  needIncrease: true,
                  onIncrease: () {
                    widget.subCreateProvider.oltPosition.text =
                        "${(int.tryParse(widget.subCreateProvider.oltPosition.text) ?? 0) + 1}";
                  },
                  onDecrease: () {
                    var nowData = (int.tryParse(
                                widget.subCreateProvider.oltPosition.text) ??
                            0) -
                        1;
                    if (nowData < 0) {
                      return;
                    }
                    widget.subCreateProvider.oltPosition.text = "$nowData";
                  },
                ),
              ],
            ),
          Row(
            children: [
              Obx(
                () => Switch(
                  value: widget.subCreateProvider.isGSTINAdd.value,
                  onChanged: (bool status) {
                    widget.subCreateProvider.isGSTINAdd.value = status;
                    widget.subCreateProvider.panController.clear();
                  //  widget.subCreateProvider.gstinOneController.clear();
                    widget.subCreateProvider.gstinThreeController.clear();
                   // widget.subCreateProvider.gstinFourController.clear();
                    widget.subCreateProvider.gstinFiveController.clear();

                    widget.subCreateProvider.texPayerController.clear();
                    widget.subCreateProvider.legalBusNameController.clear();
                    widget.subCreateProvider.tradeNameController.clear();

                    if (widget.caf == "2" &&
                        widget.subCreateProvider.isSameAsPermanent &&
                        !widget.subCreateProvider.isGSTINAdd.value) {
                      widget.subCreateProvider.formInSubmitStatus.value = true;
                    } else {
                      widget.subCreateProvider.formInSubmitStatus.value = false;
                    }
                  },
                ),
              ),
              const Text(
                "GST Information to be added",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getSsidDetails(SubCreateProvider subCreateProvider, String subText) {
    return Column(
      children: [
        CustomTextField(
          lableText: "SSID ($subText)",
          controller: subText == "5GHz"
              ? widget.subCreateProvider.ssid5Controller
              : widget.subCreateProvider.ssid24Controller,
          isRequired: true,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          intialPasswordVisible: true,
          isPassword: true,
          //  isEditable: !canEditDevice,
          lableText: "SSID Password ($subText)",
          controller: subText == "5GHz"
              ? widget.subCreateProvider.ssidPassword5Controller
              : widget.subCreateProvider.ssidPassword24Controller,
          isRequired: true,
        ),
      ],
    );
  }

  void clearConfigSSID() {
    widget.subCreateProvider.ssid24Controller.clear();
    widget.subCreateProvider.ssidPassword24Controller.clear();

    widget.subCreateProvider.ssid5Controller.clear();
    widget.subCreateProvider.ssidPassword5Controller.clear();
  }
}
