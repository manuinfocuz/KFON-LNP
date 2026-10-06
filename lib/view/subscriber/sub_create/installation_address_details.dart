import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/utils/global_variables.dart';

import '../../../models/form_type_model.dart';
import '../../../providers/subscriber/sub_create_provider.dart';
import '../../../utils/style.dart';
import '../../../widget/global_bottomsheet_widget.dart';
import '../../../widget/new_from_widget/radio_from.dart';
import '../../../widget/utils_widgets/custom_textfiled.dart';
import '../../../widget/utils_widgets/value_picker.dart';

class InstallationAddressDetailsScreen extends StatefulWidget {
  final SubCreateProvider subCreateProvider;
  final String caf;
  final String profileID;
  final bool isPermanent;

  const InstallationAddressDetailsScreen({
    super.key,
    required this.subCreateProvider,
    required this.caf,
    required this.profileID,
    required this.isPermanent,
  });

  @override
  State<InstallationAddressDetailsScreen> createState() =>
      _InstallationAddressDetailsScreenState();
}

class _InstallationAddressDetailsScreenState
    extends State<InstallationAddressDetailsScreen> {
  @override
  void initState() {
    if (widget.subCreateProvider.isSameAsPermanent) {
      copyPermanentAddressToInstallAddress();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Installation Address",
            style: appTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            onChangeText: (e) {
              widget.subCreateProvider.isSameAsPermanent = false;
              setState(() {});
            },
            isEditable: true,
            lableText: "Door No/Apartment",
            controller: widget.subCreateProvider.doorNoControllerInstall,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            onChangeText: (e) {
              widget.subCreateProvider.isSameAsPermanent = false;
              setState(() {});
            },
            isEditable: true,
            lableText: "Street/Locality Name",
            controller: widget.subCreateProvider.streetNameControllerInstall,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            onChangeText: (e) {
              widget.subCreateProvider.isSameAsPermanent = false;
              setState(() {});
            },
            isEditable: true,
            lableText: "City",
            controller: widget.subCreateProvider.cityControllerInstall,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () async {
              widget.subCreateProvider.selectedDistrictIDInstall = null;
              widget.subCreateProvider.selectedDistrictInstall = null;

              widget.subCreateProvider.selectedPostOfficeIDInstall = null;
              widget.subCreateProvider.selectedPostOfficeInstall = null;

              if (widget.subCreateProvider.pinCodeDropDownInstall.isEmpty) {
                await widget.subCreateProvider.getPinCodes(widget.isPermanent);
              }

              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select PinCode',
                  listData: widget.subCreateProvider.pinCodeDropDownInstall,
                  dropDownValue:
                      widget.subCreateProvider.selectedPinCodeIDInstall ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.isSameAsPermanent = false;
                    setState(() {});
                    clearPostOffice();
                    clearDistrict();
                    clearLocationType();
                    clearLocalBody();
                    clearVillage();
                    clearBlock();
                    clearCorporation();

                    widget.subCreateProvider.selectedPinCodeIDInstall =
                        value.id;
                    widget.subCreateProvider.selectedPinCodeInstall =
                        value.value;
                    widget.subCreateProvider.getDistrictAndPostOffice(
                        value.value, widget.isPermanent);
                    setState(() {});
                  },
                ),
              );
            },
            selectedValue: widget.subCreateProvider.selectedPinCodeInstall ??
                "Select PinCode",
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
                  listData: widget.subCreateProvider.postOfficeDropDownInstall,
                  dropDownValue:
                      widget.subCreateProvider.selectedPostOfficeIDInstall ??
                          "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.isSameAsPermanent = false;
                    setState(() {});
                    widget.subCreateProvider.selectedPostOfficeInstall =
                        value.id;
                    widget.subCreateProvider.selectedPostOfficeIDInstall =
                        value.value;

                    if (widget.subCreateProvider.selectedDistrictIDInstall !=
                            null &&
                        widget.subCreateProvider.selectedLocationTypeInstall !=
                            null) {
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
            selectedValue: widget.subCreateProvider.selectedPostOfficeInstall ??
                'Post Office Name',
            canClick:
                widget.subCreateProvider.postOfficeDropDownInstall.isNotEmpty,
            hint: 'Post Office Name',
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () {
              widget.subCreateProvider.isSameAsPermanent = false;
              setState(() {});
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select District',
                  listData: widget.subCreateProvider.districtDropDownInstall,
                  dropDownValue:
                      widget.subCreateProvider.selectedDistrictIDInstall ?? "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.isSameAsPermanent = false;
                    setState(() {});
                    widget.subCreateProvider.selectedDistrictIDInstall =
                        value.id;
                    widget.subCreateProvider.selectedDistrictInstall =
                        value.value;
                    if (widget.subCreateProvider.selectedPostOfficeIDInstall !=
                            null &&
                        widget.subCreateProvider.selectedLocationTypeInstall !=
                            null) {
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
                widget.subCreateProvider.selectedDistrictInstall ?? 'District',
            canClick:
                widget.subCreateProvider.districtDropDownInstall.isNotEmpty,
            hint: 'District',
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          radioForm(
            isRequired: true,
            "Location Type",
            [
              ["Urban", "1"],
              ["Rural", "2"],
            ],
            widget.subCreateProvider.selectedLocationTypeInstall,
            widget.subCreateProvider,
            (value) {
              widget.subCreateProvider.isSameAsPermanent = false;
              setState(() {});
              widget.subCreateProvider.selectedLocationTypeInstall = value;
              if (widget.subCreateProvider.selectedPostOfficeIDInstall !=
                      null &&
                  widget.subCreateProvider.selectedDistrictIDInstall != null) {
                widget.subCreateProvider.getLocalBodyList(widget.isPermanent);
              }
              widget.subCreateProvider.notifyListeners();

              clearLocalBody();
              clearVillage();
              clearBlock();
              clearCorporation();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () {
              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Local body Type',
                  listData:
                      widget.subCreateProvider.locationBodyDropDownInstall,
                  dropDownValue:
                      widget.subCreateProvider.selectedLocationBodyIDInstall ??
                          "",
                  onClick: (DropDownDataModel value) {
                    widget.subCreateProvider.isSameAsPermanent = false;
                    setState(() {});
                    widget.subCreateProvider.selectedLocationBodyIDInstall =
                        value.id;
                    widget.subCreateProvider.selectedLocationBodyInstall =
                        value.value;
                    widget.subCreateProvider.getVBM(widget.isPermanent);
                    setState(() {});

                    clearVillage();
                    clearBlock();
                    clearCorporation();
                  },
                ),
              );
            },
            selectedValue:
                widget.subCreateProvider.selectedLocationBodyInstall ??
                    'Local body Type',
            canClick:
                widget.subCreateProvider.locationBodyDropDownInstall.isNotEmpty,
            hint: 'Local body Type',
            isRequired: true,
          ),
          if (widget.subCreateProvider.selectedLocationTypeInstall == "2")
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
                        listData:
                            widget.subCreateProvider.villageDropDownInstall,
                        dropDownValue: widget.subCreateProvider
                                .selectedVillageNameIDInstall ??
                            "",
                        onClick: (DropDownDataModel value) {
                          widget.subCreateProvider.isSameAsPermanent = false;
                          setState(() {});
                          widget.subCreateProvider
                              .selectedVillageNameIDInstall = value.id;
                          widget.subCreateProvider.selectedVillageNameInstall =
                              value.value;
                          setState(() {});
                        },
                      ),
                    );
                  },
                  selectedValue:
                      widget.subCreateProvider.selectedVillageNameInstall ??
                          'Village Name',
                  canClick: widget
                      .subCreateProvider.villageDropDownInstall.isNotEmpty,
                  hint: 'Village Name',
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
                        listData: widget.subCreateProvider.blockDropDownInstall,
                        dropDownValue: widget
                                .subCreateProvider.selectedBlockNameIDInstall ??
                            "",
                        onClick: (DropDownDataModel value) {
                          widget.subCreateProvider.isSameAsPermanent = false;
                          setState(() {});
                          widget.subCreateProvider.selectedBlockNameIDInstall =
                              value.id;
                          widget.subCreateProvider.selectedBlockNameInstall =
                              value.value;
                          setState(() {});
                        },
                      ),
                    );
                  },
                  selectedValue:
                      widget.subCreateProvider.selectedBlockNameInstall ??
                          'Block Name',
                  canClick:
                      widget.subCreateProvider.blockDropDownInstall.isNotEmpty,
                  hint: 'Block Name',
                  isRequired: true,
                ),
              ],
            ),
          if (widget.subCreateProvider.selectedLocationTypeInstall == "1")
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
                        listData:
                            widget.subCreateProvider.corporationDropDownInstall,
                        dropDownValue: widget.subCreateProvider
                                .selectedCorporationIDInstall ??
                            "",
                        onClick: (DropDownDataModel value) {
                          widget.subCreateProvider.isSameAsPermanent = false;
                          setState(() {});
                          widget.subCreateProvider
                              .selectedCorporationIDInstall = value.id;
                          widget.subCreateProvider.selectedCorporationInstall =
                              value.value;
                          setState(() {});
                        },
                      ),
                    );
                  },
                  selectedValue:
                      widget.subCreateProvider.selectedCorporationInstall ??
                          'Corporation/Municipality Name',
                  canClick: widget
                      .subCreateProvider.corporationDropDownInstall.isNotEmpty,
                  hint: 'Corporation/Municipality Name',
                  isRequired: true,
                ),
              ],
            ),
          InkWell(
            onTap: () {
              widget.subCreateProvider.isSameAsPermanent =
                  !widget.subCreateProvider.isSameAsPermanent;
              if (widget.subCreateProvider.isSameAsPermanent) {
                copyPermanentAddressToInstallAddress();
              } else {
                clearInstallAddress();
              }
              widget.subCreateProvider.notifyListeners();
            },
            child: Row(
              children: [
                Checkbox(
                  value: widget.subCreateProvider.isSameAsPermanent,
                  onChanged: (e) {
                    widget.subCreateProvider.isSameAsPermanent = e!;
                    if (e) {
                      copyPermanentAddressToInstallAddress();
                    } else {
                      clearInstallAddress();
                    }

                    widget.subCreateProvider.notifyListeners();
                  },
                ),
                const Text("Same as permanent address"),
              ],
            ),
          )
        ],
      ),
    );
  }

  void copyPermanentAddressToInstallAddress() {
    var provider = widget.subCreateProvider;
    // Copy text editing controller values
    provider.doorNoControllerInstall.text = provider.doorNoController.text;
    provider.streetNameControllerInstall.text =
        provider.streetNameController.text;
    provider.cityControllerInstall.text = provider.cityController.text;

    // Copy dropdown values
    provider.selectedPinCodeInstall = provider.selectedPinCode;
    provider.selectedPinCodeIDInstall = provider.selectedPinCodeID;
    provider.pinCodeDropDownInstall = List.from(provider.pinCodeDropDown);

    provider.selectedPostOfficeInstall = provider.selectedPostOffice;
    provider.selectedPostOfficeIDInstall = provider.selectedPostOfficeID;
    provider.postOfficeDropDownInstall = List.from(provider.postOfficeDropDown);

    provider.selectedDistrictInstall = provider.selectedDistrict;
    provider.selectedDistrictIDInstall = provider.selectedDistrictID;
    provider.districtDropDownInstall = List.from(provider.districtDropDown);

    provider.selectedLocationTypeInstall = provider.selectedLocationType;

    provider.selectedLocationBodyInstall = provider.selectedLocationBody;
    provider.selectedLocationBodyIDInstall = provider.selectedLocationBodyID;
    provider.locationBodyDropDownInstall =
        List.from(provider.locationBodyDropDown);

    provider.selectedVillageNameInstall = provider.selectedVillageName;
    provider.selectedVillageNameIDInstall = provider.selectedVillageNameID;
    provider.villageDropDownInstall = List.from(provider.villageDropDown);

    provider.selectedBlockNameInstall = provider.selectedBlockName;
    provider.selectedBlockNameIDInstall = provider.selectedBlockNameID;
    provider.blockDropDownInstall = List.from(provider.blockDropDown);

    provider.selectedCorporationInstall = provider.selectedCorporation;
    provider.selectedCorporationIDInstall = provider.selectedCorporationID;
    provider.corporationDropDownInstall =
        List.from(provider.corporationDropDown);
  }

  void clearInstallAddress() {
    var provider = widget.subCreateProvider;

    // Clear text editing controller values
    provider.doorNoControllerInstall.text = '';
    provider.streetNameControllerInstall.text = '';
    provider.cityControllerInstall.text = '';

    // Clear dropdown values
    provider.selectedPinCodeInstall = null;
    provider.selectedPinCodeIDInstall = null;
    //   provider.pinCodeDropDownInstall = [];

    provider.selectedPostOfficeInstall = null;
    provider.selectedPostOfficeIDInstall = null;
    provider.postOfficeDropDownInstall = [];

    provider.selectedDistrictInstall = null;
    provider.selectedDistrictIDInstall = null;
    provider.districtDropDownInstall = [];

    provider.selectedLocationTypeInstall = null;

    provider.selectedLocationBodyInstall = null;
    provider.selectedLocationBodyIDInstall = null;
    provider.locationBodyDropDownInstall = [];

    provider.selectedVillageNameInstall = null;
    provider.selectedVillageNameIDInstall = null;
    provider.villageDropDownInstall = [];

    provider.selectedBlockNameInstall = null;
    provider.selectedBlockNameIDInstall = null;
    provider.blockDropDownInstall = [];

    provider.selectedCorporationInstall = null;
    provider.selectedCorporationIDInstall = null;
    provider.corporationDropDownInstall = [];
  }

  void clearPostOffice() {
    var provider = widget.subCreateProvider;
    //if (widget.isPermanent) {
    provider.postOfficeDropDownInstall = [];
    provider.selectedPostOfficeIDInstall = null;
    provider.selectedPostOfficeInstall = null;
    //   }
    setState(() {});
  }

  void clearDistrict() {
    var provider = widget.subCreateProvider;
    //if (widget.isPermanent) {
    provider.districtDropDownInstall = [];
    provider.selectedDistrictIDInstall = null;
    provider.selectedDistrictInstall = null;
    //  }
    setState(() {});
  }

  void clearLocationType() {
    var provider = widget.subCreateProvider;
    //if (widget.isPermanent) {
    provider.selectedLocationTypeInstall = null;
    // }
    setState(() {});
  }

  void clearLocalBody() {
    var provider = widget.subCreateProvider;
    //if (widget.isPermanent) {
    provider.locationBodyDropDownInstall = [];
    provider.selectedLocationBodyInstall = null;
    provider.selectedLocationBodyIDInstall = null;
    //  }
    setState(() {});
  }

  void clearVillage() {
    var provider = widget.subCreateProvider;

    //if (widget.isPermanent) {
    provider.villageDropDownInstall = [];
    provider.selectedVillageNameIDInstall = null;
    provider.selectedVillageNameInstall = null;
    //  }
    setState(() {});
  }

  void clearBlock() {
    var provider = widget.subCreateProvider;
    // if (widget.isPermanent) {
    provider.blockDropDownInstall = [];
    provider.selectedBlockNameIDInstall = null;
    provider.selectedBlockNameInstall = null;
    //}
    setState(() {});
  }

  void clearCorporation() {
    var provider = widget.subCreateProvider;
    //  if (widget.isPermanent) {
    provider.blockDropDownInstall = [];
    provider.selectedBlockNameIDInstall = null;
    provider.selectedBlockNameInstall = null;
    //  }
    setState(() {});
  }
}
