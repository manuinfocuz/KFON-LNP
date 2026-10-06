import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/form_type_model.dart';
import '../../../providers/subscriber/sub_create_provider.dart';
import '../../../utils/style.dart';
import '../../../widget/global_bottomsheet_widget.dart';
import '../../../widget/new_from_widget/radio_from.dart';
import '../../../widget/utils_widgets/custom_textfiled.dart';
import '../../../widget/utils_widgets/value_picker.dart';

class AddressDetailsScreen extends StatefulWidget {
  final SubCreateProvider subCreateProvider;
  final String caf;
  final String profileID;
  final bool isPermanent;

  const AddressDetailsScreen({
    super.key,
    required this.subCreateProvider,
    required this.caf,
    required this.profileID,
    required this.isPermanent,
  });

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Permanent Address",
            style: appTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            isEditable: true,
            lableText: "Door No/Apartment",
            controller: widget.subCreateProvider.doorNoController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            isEditable: true,
            lableText: "Street/Locality Name",
            controller: widget.subCreateProvider.streetNameController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            isEditable: true,
            lableText: "City",
            controller: widget.subCreateProvider.cityController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () async {
              if (widget.subCreateProvider.pinCodeDropDown.isEmpty) {
                await widget.subCreateProvider.getPinCodes(widget.isPermanent);
              }

              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select PinCode',
                  listData: widget.subCreateProvider.pinCodeDropDown,
                  dropDownValue:
                      widget.subCreateProvider.selectedPinCodeID ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.selectedPinCodeID = value.id;
                    widget.subCreateProvider.selectedPinCode = value.value;

                    widget.subCreateProvider.selectedDistrictID = null;
                    widget.subCreateProvider.selectedDistrict = null;

                    widget.subCreateProvider.selectedPostOfficeID = null;
                    widget.subCreateProvider.selectedPostOffice = null;

                    widget.subCreateProvider.getDistrictAndPostOffice(
                        value.value, widget.isPermanent);
                    setState(() {});

                    clearPostOffice();
                    clearDistrict();
                    clearLocationType();
                    clearLocalBody();
                    clearVillage();
                    clearBlock();
                    clearCorporation();
                  },
                ),
              );
            },
            selectedValue:
                widget.subCreateProvider.selectedPinCode ?? "Select PinCode",
            canClick: true,
            hint: "Select PinCode",
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () {
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select PostOffice',
                  listData: widget.subCreateProvider.postOfficeDropDown,
                  dropDownValue:
                      widget.subCreateProvider.selectedPostOfficeID ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.selectedPostOffice = value.id;
                    widget.subCreateProvider.selectedPostOfficeID = value.value;

                    if (widget.subCreateProvider.selectedDistrictID != null &&
                        widget.subCreateProvider.selectedLocationType != null) {
                      widget.subCreateProvider
                          .getLocalBodyList(widget.isPermanent);
                    }
                    setState(() {});
                    clearLocationType();
                    clearLocalBody();
                    clearVillage();
                    clearBlock();
                    clearCorporation();
                  },
                ),
              );
            },
            selectedValue: widget.subCreateProvider.selectedPostOffice ??
                'Post Office Name',
            canClick: widget.subCreateProvider.postOfficeDropDown.isNotEmpty,
            hint: "Post Office Name",
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () {
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select District',
                  listData: widget.subCreateProvider.districtDropDown,
                  dropDownValue:
                      widget.subCreateProvider.selectedDistrictID ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.selectedDistrictID = value.id;
                    widget.subCreateProvider.selectedDistrict = value.value;
                    if (widget.subCreateProvider.selectedPostOfficeID != null &&
                        widget.subCreateProvider.selectedLocationType != null) {
                      widget.subCreateProvider
                          .getLocalBodyList(widget.isPermanent);
                    }
                    setState(() {});
                    clearLocationType();
                    clearLocalBody();
                    clearVillage();
                    clearBlock();
                    clearCorporation();
                  },
                ),
              );
            },
            selectedValue:
                widget.subCreateProvider.selectedDistrict ?? 'District',
            canClick: widget.subCreateProvider.districtDropDown.isNotEmpty,
            hint: "District",
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          radioForm(
            "Location Type",
            [
              ["Urban", "1"],
              ["Rural", "2"],
            ],
            widget.subCreateProvider.selectedLocationType,
            widget.subCreateProvider,
            (value) {
              widget.subCreateProvider.selectedLocationType = value;
              if (widget.subCreateProvider.selectedPostOfficeID != null &&
                  widget.subCreateProvider.selectedDistrictID != null) {
                widget.subCreateProvider.getLocalBodyList(widget.isPermanent);
              }
              widget.subCreateProvider.notifyListeners();

              clearLocalBody();
              clearVillage();
              clearBlock();
              clearCorporation();
            },
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () {
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Local body Type',
                  listData: widget.subCreateProvider.locationBodyDropDown,
                  dropDownValue:
                      widget.subCreateProvider.selectedLocationBodyID ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.selectedLocationBodyID = value.id;
                    widget.subCreateProvider.selectedLocationBody = value.value;
                    widget.subCreateProvider.getVBM(widget.isPermanent);
                    setState(() {});

                    clearVillage();
                    clearBlock();
                    clearCorporation();
                  },
                ),
              );
            },
            selectedValue: widget.subCreateProvider.selectedLocationBody ??
                'Local body Type',
            canClick: widget.subCreateProvider.locationBodyDropDown.isNotEmpty,
            hint: "Local body Type",
            isRequired: true,
          ),
          if (widget.subCreateProvider.selectedLocationType == "2")
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ValuePicker(
                  callback: () {
                    Get.bottomSheet(
                      GlobalBottomSheetWidget(
                        title: 'Village Name',
                        listData: widget.subCreateProvider.villageDropDown,
                        dropDownValue:
                            widget.subCreateProvider.selectedVillageNameID ??
                                "",
                        onClick: (DropDownDataModel value) {
                          widget.subCreateProvider.selectedVillageNameID =
                              value.id;
                          widget.subCreateProvider.selectedVillageName =
                              value.value;
                          setState(() {});
                        },
                      ),
                    );
                  },
                  selectedValue: widget.subCreateProvider.selectedVillageName ??
                      'Village Name',
                  canClick: widget.subCreateProvider.villageDropDown.isNotEmpty,
                  hint: "Village Name",
                  isRequired: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                ValuePicker(
                  callback: () {
                    Get.bottomSheet(
                      GlobalBottomSheetWidget(
                        title: 'Block Name',
                        listData: widget.subCreateProvider.blockDropDown,
                        dropDownValue:
                            widget.subCreateProvider.selectedBlockNameID ?? "",
                        onClick: (DropDownDataModel value) {
                          widget.subCreateProvider.selectedBlockNameID =
                              value.id;
                          widget.subCreateProvider.selectedBlockName =
                              value.value;
                          setState(() {});
                        },
                      ),
                    );
                  },
                  selectedValue: widget.subCreateProvider.selectedBlockName ??
                      'Block Name',
                  canClick: widget.subCreateProvider.blockDropDown.isNotEmpty,
                  hint: "Block Name",
                  isRequired: true,
                ),
              ],
            ),
          if (widget.subCreateProvider.selectedLocationType == "1")
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ValuePicker(
                  callback: () {
                    Get.bottomSheet(
                      GlobalBottomSheetWidget(
                        title: 'Corporation/Municipality Name',
                        listData: widget.subCreateProvider.corporationDropDown,
                        dropDownValue:
                            widget.subCreateProvider.selectedCorporationID ??
                                "",
                        onClick: (DropDownDataModel value) {
                          widget.subCreateProvider.selectedCorporationID =
                              value.id;
                          widget.subCreateProvider.selectedCorporation =
                              value.value;
                          setState(() {});
                        },
                      ),
                    );
                  },
                  selectedValue: widget.subCreateProvider.selectedCorporation ??
                      'Corporation/Municipality Name',
                  canClick:
                      widget.subCreateProvider.corporationDropDown.isNotEmpty,
                  hint: "Corporation/Municipality Name",
                  isRequired: true,
                ),
              ],
            ),
        ],
      ),
    );
  }

  void clearPostOffice() {
    var provider = widget.subCreateProvider;
    if (widget.isPermanent) {
      provider.postOfficeDropDown = [];
      provider.selectedPostOfficeID = null;
      provider.selectedPostOffice = null;
    }
    setState(() {});
  }

  void clearDistrict() {
    var provider = widget.subCreateProvider;
    if (widget.isPermanent) {
      provider.districtDropDown = [];
      provider.selectedDistrictID = null;
      provider.selectedDistrict = null;
    }
    setState(() {});
  }

  void clearLocationType() {
    var provider = widget.subCreateProvider;
    if (widget.isPermanent) {
      provider.selectedLocationType = null;
    }
    setState(() {});
  }

  void clearLocalBody() {
    var provider = widget.subCreateProvider;
    if (widget.isPermanent) {
      provider.locationBodyDropDown = [];
      provider.selectedLocationBody = null;
      provider.selectedLocationBodyID = null;
    }
    setState(() {});
  }

  void clearVillage() {
    var provider = widget.subCreateProvider;

    if (widget.isPermanent) {
      provider.villageDropDown = [];
      provider.selectedVillageNameID = null;
      provider.selectedVillageName = null;
    }
    setState(() {});
  }

  void clearBlock() {
    var provider = widget.subCreateProvider;
    if (widget.isPermanent) {
      provider.blockDropDown = [];
      provider.selectedBlockNameID = null;
      provider.selectedBlockName = null;
    }
    setState(() {});
  }

  void clearCorporation() {
    var provider = widget.subCreateProvider;
    if (widget.isPermanent) {
      provider.corporationDropDown = [];
      provider.selectedCorporation = null;
      provider.selectedCorporationID = null;
    }
    setState(() {});
  }
}
