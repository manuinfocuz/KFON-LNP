import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/data_model/subscriber/normal_application_post_model.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/providers/subscriber/sub_create_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/address_details.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/device_details.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/doc_upload.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/gst_information.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/installation_address_details.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/personel_details.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/subscription_details.dart';
import 'package:kfon_lnp/widget/utils_widgets/build_ui.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../../../data_model/subscriber/aadharDetailsModel.dart';
import '../../../helper/validate_helper.dart';
import '../../../models/form_type_model.dart';
import '../../../utils/creation_data_loader/check_drop_down.dart';
import '../../../utils/creation_data_loader/check_file_uploader.dart';
import '../../../utils/creation_data_loader/check_radio.dart';
import '../../../utils/creation_data_loader/check_text_filed.dart';
import '../../../utils/make_form_data.dart';
import '../../../widget/form_widgets/main_from_builder.dart';
import '../../../widget/utils_widgets/globalAppBar.dart';
import 'form_view_screen.dart';

class SubscriberFormScreen extends StatefulWidget {
  final String cafID;
  final String profileID;
  final AadharDetailsModel? aadharDetailsModel;
  final String? title;

  const SubscriberFormScreen({
    super.key,
    required this.cafID,
    required this.profileID,
    this.aadharDetailsModel,
    this.title,
  });

  @override
  State<SubscriberFormScreen> createState() => _SubscriberFormScreenState();
}

class _SubscriberFormScreenState extends State<SubscriberFormScreen> {
  LocaleProvider localeProvider = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubCreateProvider(
        widget.cafID,
        widget.profileID,
        aadharDetailsModel: widget.aadharDetailsModel,
      ),
      builder: (context, provider) => Consumer<SubCreateProvider>(
        builder: (context, provider, snap) {
          return PopScope(
            canPop: false,
            // onPopInvokedWithResult: (s, k) {
            //   if (mounted) {
            //     formExitDialog();
            //   }
            // },
            child: Scaffold(
              appBar: globalAppBar(
                onBackPress: () {
                  formExitDialog();
                },
                "${widget.title ?? ''} - Customer Application Form",
              ),
              body: SafeArea(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: getFormWidget(provider),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          provider.selectedIndex != 0
                              ? CustomButton(
                                  icon: Icons.keyboard_arrow_left,
                                  title: "Previous",
                                  onClickFunction: () {
                                    if (provider.selectedIndex != 0) {
                                      if (provider.selectedIndex == 6 &&
                                          !provider.isGSTINAdd.value) {
                                        provider.selectedIndex -= 2;
                                        // if (provider.selectedPlanTypeID == "1") {
                                        //   provider.selectedIndex -= 1;
                                        // }
                                        // } else if (provider.selectedIndex == 5 &&
                                        //     provider.selectedPlanTypeID == "1") {
                                        //   provider.selectedIndex -= 2;
                                      } else {
                                        provider.selectedIndex -= 1;
                                      }

                                      setState(() {});
                                    }
                                  },
                                )
                              : const SizedBox(),
                          Obx(
                            () => CustomButton(
                              isIconLeft: false,
                              icon: Icons.keyboard_arrow_right,
                              title: getCanSubmit(
                                provider,
                              )
                                  ? "Submit"
                                  : "Next",
                              onClickFunction: () {
                                // if (provider.isOnlyView.value) {
                                //   var canGo = checkFormOne(provider) &&
                                //       checkFormTwo(provider) &&
                                //       checkFormThree(provider) &&
                                //       checkFormFour(provider) &&
                                //       checkFormFive(provider) &&
                                //       checkFormSix(provider) &&
                                //       checkFormSeavan(provider);
                                //
                                //   if (canGo) {
                                //     GlobalFunctions.showDynamicDialog(
                                //       title: 'Submit Form',
                                //       content: 'Are you want to submit the form?',
                                //       confirmButtonTitle: 'Yes',
                                //       cancelButtonTitle: 'Cancel',
                                //       onConfirmClick: () {
                                //         Get.back();
                                //         dataLoader(provider);
                                //       },
                                //       onCancelClick: () {
                                //         Get.back();
                                //       },
                                //     );
                                //   }
                                //   return;
                                // }
                                provider.notifyListeners();

                                switch (provider.selectedIndex) {
                                  case 0:

                                    /// personal details
                                    if (checkFormOne(provider)) {
                                      provider.selectedIndex = 1;
                                    }

                                    return;
                                  case 1:

                                    /// permanent address
                                    if (checkFormTwo(provider)) {
                                      provider.selectedIndex = 2;
                                    }
                                    return;
                                  case 2:

                                    /// instalation address
                                    if (checkFormThree(provider)) {
                                      provider.selectedIndex = 3;
                                    }
                                    return;
                                  case 3:

                                    /// subscriber details
                                    if (checkFormFour(provider)) {
                                      // if (provider.selectedPlanTypeID == "1") {
                                      //   gstDialog(provider);
                                      // } else {
                                      provider.selectedIndex = 4;

                                      if (!provider.isGSTINAdd.value) {
                                        provider.formInSubmitStatus.value =
                                            true;
                                      }
                                      //}
                                    }
                                    return;
                                  case 4:

                                    /// device details
                                    if (checkFormFive(provider)) {
                                      gstDialog(provider);
                                    }
                                    return;
                                  case 5:

                                    ///GSTIN DETAILS
                                    if (checkFormSix(provider)) {
                                      provider.selectedIndex = 6;
                                    }
                                    return;
                                  case 6:

                                    /// DOCUMENTS
                                    if (checkFormSeavan(provider)) {
                                      formSubmitDialog(provider);
                                    }
                                    return;
                                }
                                provider.notifyListeners();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  formSubmitDialog(SubCreateProvider provider) {
    GlobalFunctions.showDynamicDialog(
      title: "Submit",
      content: "Are you sure want to submit the form?",
      confirmButtonTitle: "Yes",
      cancelButtonTitle: "No",
      onConfirmClick: () {
        Get.back();
        dataLoader(provider);
      },
      onCancelClick: () {
        Get.back();
      },
    );
  }

  formExitDialog() {
    GlobalFunctions.showDynamicDialog(
      title: "Exit",
      content: "Are you sure want to exit from form?",
      confirmButtonTitle: "Yes",
      cancelButtonTitle: "No",
      onConfirmClick: () {
        Get.back();

        ///close dialog
        Get.back();

        ///back screen
      },
      onCancelClick: () {
        Get.back();

        ///close dialog
      },
    );
  }

  bool checkFormOne(SubCreateProvider provider) {
    List<String?> errorList = [];
    var showError;

    var nameError = globalValidate(
        provider.applicantNameController.text, 1, 64, false, "Applicant Name");
    errorList.add(nameError);
    var dobError =
        globalValidate(provider.dobController.text, 10, 10, false, "Dob");
    errorList.add(dobError);
    var mobileError =
        globalValidate(provider.mobileController.text, 10, 10, false, "Phone");
    errorList.add(mobileError);
    var emailError =
        globalValidate(provider.emailController.text, 3, 164, true, "Email");
    errorList.add(emailError);

    if (widget.profileID == "2") {
      var alNu = globalValidate(provider.alternativeMobileController.text, 10,
          10, false, "AlternativePhone");
      errorList.add(alNu);
      var conPError = globalValidate(provider.contactPersonNameController.text,
          3, 164, false, "Contact Person");
      errorList.add(conPError);
    }

    if (provider.selectedGender == null) {
      errorList.add("Select Gender");
    }

    for (var element in errorList) {
      if (element != null) {
        showError = element;
        break;
      }
    }

    if (showError == null) {
      return true;
    } else {
      GlobalFunctions.showToast(showError, false);
    }

    return false;
  }

  bool checkFormTwo(SubCreateProvider provider) {
    List<String?> errorList = [];
    var showError;

    var doorError = globalValidate(
        provider.doorNoController.text, 1, 80, false, "Door Number");
    errorList.add(doorError);
    var streetError = globalValidate(
        provider.streetNameController.text, 1, 200, false, "Street");
    errorList.add(streetError);
    var cityError =
        globalValidate(provider.cityController.text, 1, 80, false, "City");
    errorList.add(cityError);

    if (provider.selectedPinCodeID == null) {
      errorList.add("Select PinCode");
    }
    if (provider.selectedPostOfficeID == null) {
      errorList.add("Select Post Office");
    }

    if (provider.selectedDistrictID == null) {
      errorList.add("Select District");
    }
    if (provider.selectedLocationType == null) {
      errorList.add("Select Location Type");
    }

    if (provider.selectedLocationBodyID == null) {
      errorList.add("Select Local Body");
    }

    if (provider.selectedLocationType == "1") {
      if (provider.selectedCorporationID == null) {
        errorList.add("Select Corporation");
      }
    }

    if (provider.selectedLocationType == "2") {
      if (provider.selectedVillageNameID == null) {
        errorList.add("Select Village");
      }
      if (provider.selectedBlockNameID == null) {
        errorList.add("Select Block");
      }
    }

    // if (provider.selectedDistrictID == null) {
    //   errorList.add("Select District");
    // }

    for (var element in errorList) {
      if (element != null) {
        showError = element;
        break;
      }
    }

    if (showError == null) {
      return true;
    } else {
      GlobalFunctions.showToast(showError, false);
    }
    return false;
  }

  bool checkFormThree(SubCreateProvider provider) {
    List<String?> errorList = [];
    var showError;

    var doorError = globalValidate(
        provider.doorNoControllerInstall.text, 1, 80, false, "Door Number");
    errorList.add(doorError);
    var streetError = globalValidate(
        provider.streetNameControllerInstall.text, 1, 200, false, "Street");
    errorList.add(streetError);
    var cityError = globalValidate(
        provider.cityControllerInstall.text, 1, 80, false, "City");
    errorList.add(cityError);

    if (provider.selectedPinCodeIDInstall == null) {
      errorList.add("Select PinCode");
    }
    if (provider.selectedPostOfficeIDInstall == null) {
      errorList.add("Select Post Office");
    }

    if (provider.selectedDistrictIDInstall == null) {
      errorList.add("Select District");
    }
    if (provider.selectedLocationTypeInstall == null) {
      errorList.add("Select Location Type");
    }

    if (provider.selectedLocationBodyIDInstall == null) {
      errorList.add("Select Local Body");
    }

    if (provider.selectedLocationTypeInstall == "2") {
      if (provider.selectedVillageNameIDInstall == null) {
        errorList.add("Select Village");
      }
      if (provider.selectedBlockNameIDInstall == null) {
        errorList.add("Select Block");
      }
    }
    if (provider.selectedLocationTypeInstall == "1") {
      if (provider.selectedCorporationIDInstall == null) {
        errorList.add("Select Corporation");
      }
    }

    // if (provider.selectedDistrictID == null) {
    //   errorList.add("Select District");
    // }

    for (var element in errorList) {
      if (element != null) {
        showError = element;
        break;
      }
    }

    if (showError == null) {
      return true;
    } else {
      GlobalFunctions.showToast(showError, false);
    }
    return false;
  }

  bool checkFormFour(SubCreateProvider provider) {
    List<String?> errorList = [];
    var showError;
    if (provider.userNameController.text.isEmpty) {
      errorList.add("Username required");
    }
    if (!provider.userNameAvailable) {
      errorList.add(provider.userNameError);
    }

    if (provider.selectedPlanTypeID == null) {
      errorList.add("Select plan type");
    }

    if (provider.selectedPlanID == null) {
      errorList.add("Select plan");
    }

    for (var element in errorList) {
      if (element != null) {
        showError = element;
        break;
      }
    }

    if (showError == null) {
      return true;
    } else {
      GlobalFunctions.showToast(showError, false);
    }
    return false;
  }

  bool checkFormFive(SubCreateProvider provider) {
    List<String?> errorList = [];
    var showError;

    if (provider.selectedDeviceProviderID == null) {
      errorList.add("Select device provider");
    }

    // if ((provider.selectedONTDeviceID == null &&
    //         provider.selectedDeviceProviderID == "1") &&
    //     provider.ontDeviceDropDown.isNotEmpty) {
    //   errorList.add("Select ONT device");
    // }
    if (provider.selectedDeviceTypeID == null) {
      errorList.add("Select device type");
    }
    //   if (localeProvider.profileDataModel?.enableAcs == "1") {
    var vlanIDError = globalValidate(
      provider.vlanIDController.text,
      1,
      50,
      false,
      "VLAN ID",
    );
    errorList.add(vlanIDError);
    // }
    var deviceMakeError = globalValidate(
      provider.deviceMakeController.text,
      1,
      50,
      false,
      "Device make",
    );
    errorList.add(deviceMakeError);

    var deviceModel = globalValidate(
      provider.deviceModelController.text,
      1,
      50,
      false,
      "Device model",
    );
    errorList.add(deviceModel);

    var deviceMacError = globalValidate(
      provider.deviceMacAddress.text,
      1,
      50,
      false,
      "Device mac",
    );
    errorList.add(deviceMacError);

    if (provider.selectedONTID == null) {
      errorList.add("Select OLT");
    }

    if (provider.configureSSID.value &&
        provider.selectedDeviceProviderID == "1") {
      var ssid5Error = globalValidate(
        provider.ssid24Controller.text,
        1,
        50,
        false,
        "SSID (2.4GHz)",
      );
      var ssidPassword5Error = globalValidate(
        provider.ssidPassword24Controller.text,
        1,
        50,
        false,
        "SSID Password (2.4GHz)",
      );
      errorList.add(ssid5Error);
      errorList.add(ssidPassword5Error);

      if (provider.selectedDeviceTypeID == "4") {
        var ssid5Error = globalValidate(
          provider.ssid5Controller.text,
          1,
          50,
          false,
          "SSID (5GHz)",
        );
        var ssidPassword5Error = globalValidate(
          provider.ssidPassword5Controller.text,
          1,
          50,
          false,
          "SSID Password (5GHz)",
        );
        errorList.add(ssid5Error);
        errorList.add(ssidPassword5Error);
      }
    }

    for (var element in errorList) {
      if (element != null) {
        showError = element;
        break;
      }
    }

    if (showError == null) {
      return true;
    } else {
      GlobalFunctions.showToast(showError, false);
    }
    return false;
  }

  bool checkFormSix(SubCreateProvider provider) {
    List<String?> errorList = [];
    var showError;

    if (provider.tradeNameController.text.isEmpty) {
      errorList.add("Enter Valid GSTIN");
    }

    for (var element in errorList) {
      if (element != null) {
        showError = element;
        break;
      }
    }

    if (showError == null) {
      return true;
    } else {
      GlobalFunctions.showToast(showError, false);
    }
    return false;
  }

  bool checkFormSeavan(SubCreateProvider provider) {
    List<String?> errorList = [];
    var showError;
    if (widget.cafID == "1") {
      if (provider.selectedApplicationCopy == null) {
        errorList.add("Select application form copy");
      }
    }

    if (provider.selectedResidenceCopy == null) {
      if (widget.cafID != "2" &&
          !provider.isSameAsPermanent &&
          provider.isGSTINAdd.value) {
        errorList.add("Select residence copy");
      }
    }

    if (provider.selectedSupportResID == null) {
      if (widget.cafID != "2" &&
          !provider.isSameAsPermanent &&
          provider.isGSTINAdd.value) {
        errorList.add("Select residence copy type");
      }
    }
    if (widget.cafID != "2" &&
        !provider.isSameAsPermanent &&
        provider.isGSTINAdd.value) {
      var resIdNum = globalValidate(provider.residenceController.text, 1, 256,
          false, "Residence proof number");
      errorList.add(resIdNum);
    }
    if (widget.cafID == "1") {
      if (provider.selectedIDProofCopy == null) {
        errorList.add("Select id proof copy");
      }

      if (provider.selectedSupportidID == null) {
        errorList.add("Select id proof copy type");
      }
      var idProofNum = globalValidate(
          provider.idProofController.text, 1, 256, false, "ID proof number");
      errorList.add(idProofNum);
    }

    if (provider.isGSTINAdd.value) {
      if (provider.GSTINProofCopy == null) {
        errorList.add("Select GSTIN copy");
      }

      if (provider.panProofCopy == null) {
        errorList.add("Select pan proof copy");
      }

      if (provider.gstinModel?.taxpayertype == "2") {
        if (provider.lutLetter == null) {
          errorList.add("Select LUT copy");
        }
      }
    }

    for (var element in errorList) {
      if (element != null) {
        showError = element;
        break;
      }
    }

    if (showError == null) {
      return true;
    } else {
      GlobalFunctions.showToast(showError, false);
    }
    return false;
  }

  void dataLoader(SubCreateProvider provider) async {
    NormalApplicationPostModel normalApplicationPostModel =
        NormalApplicationPostModel();
    normalApplicationPostModel.partnerid = globalLoginModel?.partnerid;
    if (widget.cafID == "2") {
      normalApplicationPostModel.ekycRequestid =
          widget.aadharDetailsModel?.resid;
    }

    ///personal details
    normalApplicationPostModel.caftypeid = widget.cafID;
    normalApplicationPostModel.profileid = widget.profileID;
    normalApplicationPostModel.apno = provider.applicationNoController.text;
    normalApplicationPostModel.firstname =
        provider.applicantNameController.text;
    normalApplicationPostModel.dateofbirth = provider.dobController.text;
    normalApplicationPostModel.gender = provider.selectedGender;
    normalApplicationPostModel.mobileno = provider.mobileController.text;
    normalApplicationPostModel.email = provider.emailController.text;
    if (widget.profileID == "2") {
      normalApplicationPostModel.contactManagerNo =
          provider.alternativeMobileController.text;
      normalApplicationPostModel.contactManager =
          provider.contactPersonNameController.text;
    }

    ///permanent address
    normalApplicationPostModel.doorno = provider.doorNoController.text;
    normalApplicationPostModel.streetlo = provider.streetNameController.text;
    normalApplicationPostModel.cityname = provider.cityController.text;
    normalApplicationPostModel.pincode = provider.selectedPinCodeID;
    normalApplicationPostModel.postOfficeName = provider.selectedPostOfficeID;
    normalApplicationPostModel.district = provider.selectedDistrictID;
    normalApplicationPostModel.locType = provider.selectedLocationType;
    normalApplicationPostModel.localbodyType = provider.selectedLocationBodyID;

    if (provider.selectedLocationType == "1") {
      normalApplicationPostModel.municipalityName =
          provider.selectedCorporationID;
    } else {
      normalApplicationPostModel.villageName = provider.selectedVillageNameID;
      normalApplicationPostModel.block = provider.selectedBlockNameID;
    }

    ///installation address
    normalApplicationPostModel.doornoInsta =
        provider.doorNoControllerInstall.text;
    normalApplicationPostModel.streetloInsta =
        provider.streetNameControllerInstall.text;
    normalApplicationPostModel.citynameInsta =
        provider.cityControllerInstall.text;
    normalApplicationPostModel.pincodeInsta = provider.selectedPinCodeIDInstall;
    normalApplicationPostModel.postOfficeNameInsta =
        provider.selectedPostOfficeIDInstall;
    normalApplicationPostModel.districtInsta =
        provider.selectedDistrictIDInstall;
    normalApplicationPostModel.locTypeInsta =
        provider.selectedLocationTypeInstall;
    normalApplicationPostModel.localBodyInsta =
        provider.selectedLocationBodyIDInstall;

    if (provider.selectedLocationTypeInstall == "1") {
      normalApplicationPostModel.municipalityNameInsta =
          provider.selectedCorporationIDInstall;
    } else {
      normalApplicationPostModel.villageNameInsta =
          provider.selectedVillageNameIDInstall;
      normalApplicationPostModel.blockInsta =
          provider.selectedBlockNameIDInstall;
    }

    normalApplicationPostModel.iaddressSameasPadd =
        provider.isSameAsPermanent ? "1" : "0";
    if (widget.cafID == "2") {
      normalApplicationPostModel.iaddressSameasPadd =
          provider.isSameAsPermanent ? "1" : "0";
    }
    // normalApplicationPostModel.addressSameasPadd =
    //     provider.isSameAsPermanent ? "1" : "2";

    /// sub details
    normalApplicationPostModel.username =
        "kfon.${provider.userNameController.text}";
    normalApplicationPostModel.planType = provider.selectedPlanTypeID;
    normalApplicationPostModel.packageid = provider.selectedPlanID;

    ///device
    //  if (provider.selectedPlanTypeID == "2") {
    normalApplicationPostModel.deviceProvider =
        provider.selectedDeviceProviderID;
    normalApplicationPostModel.deviceType = provider.selectedDeviceTypeID;

    ///new
    //  if (localeProvider.profileDataModel?.enableAcs == "1") {
    normalApplicationPostModel.lnpVlanID = provider.vlanIDController.text;
    //}

    ///new
    normalApplicationPostModel.deviceMake = provider.deviceMakeController.text;

    normalApplicationPostModel.deviceModel =
        provider.deviceModelController.text;
    normalApplicationPostModel.deviceMacAddress =
        provider.deviceMacAddress.text;
    normalApplicationPostModel.oltType = provider.selectedONTID;
    normalApplicationPostModel.deviceID = provider.selectedONTDeviceID;

    normalApplicationPostModel.configSSID =
        provider.configureSSID.value ? '1' : '0';

    if (localeProvider.profileDataModel?.enableAcs == "1" &&
        provider.selectedDeviceProviderID == "1") {
      normalApplicationPostModel.ssid24ghz = provider.ssid24Controller.text;
      normalApplicationPostModel.preShared24ghz =
          provider.ssidPassword24Controller.text;

      if (provider.selectedDeviceTypeID == "4") {
        normalApplicationPostModel.ssid50ghz = provider.ssid5Controller.text;
        normalApplicationPostModel.preShared50ghz =
            provider.ssidPassword5Controller.text;
      }
    }

    if (localeProvider.profileDataModel?.oltProvider?.toUpperCase() == "KFON" &&
        provider.selectedOLTID != null) {
      normalApplicationPostModel.oltId = provider.selectedOLTID;
      normalApplicationPostModel.ponPortId = provider.selectedPonPortID;
      normalApplicationPostModel.ontPosition = provider.oltPosition.text;
    }

    ///new
    // }

    ///GSTIN
    normalApplicationPostModel.gstinAvailable =
        provider.isGSTINAdd.value ? "1" : "0";
    if (provider.isGSTINAdd.value) {
      normalApplicationPostModel.panNumber = provider.panController.text;
      normalApplicationPostModel.gstinSub1 = provider.gstinOneController.text;
      normalApplicationPostModel.gstinSub2 = provider.panController.text;
      normalApplicationPostModel.gstinSub3 = provider.gstinThreeController.text;
      normalApplicationPostModel.gstinSub4 = provider.gstinFourController.text;
      normalApplicationPostModel.gstinSub5 = provider.gstinFiveController.text;
      normalApplicationPostModel.gstStatus = provider.gstinModel?.gststatus;
      normalApplicationPostModel.taxpayertype =
          provider.gstinModel?.taxpayertype;
      normalApplicationPostModel.legalname =
          provider.legalBusNameController.text;
      normalApplicationPostModel.tradename = provider.tradeNameController.text;
    } else {
      normalApplicationPostModel.panNumber = "";
      normalApplicationPostModel.gstinSub1 = "";
      normalApplicationPostModel.gstinSub2 = "";
      normalApplicationPostModel.gstinSub3 = "";
      normalApplicationPostModel.gstinSub4 = "";
      normalApplicationPostModel.gstinSub5 = "";
    }

    ///docs

    if (widget.cafID == "1") {
      normalApplicationPostModel.appliformcopy =
          fileOrNull(provider.selectedApplicationCopy);
    }

    normalApplicationPostModel.residenceType = provider.selectedSupportResID;
    normalApplicationPostModel.addressproofNo =
        provider.residenceController.text;
    normalApplicationPostModel.addressproofCopy =
        fileOrNull(provider.selectedResidenceCopy);
    if (widget.cafID == "1") {
      normalApplicationPostModel.idproofType = provider.selectedSupportidID;
      normalApplicationPostModel.idproofNo = provider.idProofController.text;
      normalApplicationPostModel.idproofCopy =
          fileOrNull(provider.selectedIDProofCopy);
    }

    if (provider.isGSTINAdd.value) {
      normalApplicationPostModel.gstinproof =
          fileOrNull(provider.GSTINProofCopy);
      normalApplicationPostModel.panProof = fileOrNull(provider.panProofCopy);
    } else {
      // normalApplicationPostModel.gstinproof = "";
      // normalApplicationPostModel.panProof = "";
    }
    if (provider.gstinModel?.taxpayertype == "2") {
      normalApplicationPostModel.lutproof = fileOrNull(provider.lutLetter);
    }

    // normalApplicationPostModel.toJson().forEach((key, value) {
    //   print("$key $value");
    //   if (value == null || value.toString().isEmpty) {
    //     //print("$key $value");
    //   } else {
    //     print("$key $value");
    //   }
    // });
    // return;
    provider.createSubscriber(normalApplicationPostModel);
//     print(
//       normalApplicationPostModel.toJson(),
//     );
  }

  getFormWidget(SubCreateProvider provider) {
    switch (provider.selectedIndex) {
      case 0:
        return PersonalDetails(
          subCreateProvider: provider,
          caf: widget.cafID,
          profileID: widget.profileID,
          aadharDetailsModel: widget.aadharDetailsModel,
        );
      case 1:
        return AddressDetailsScreen(
          subCreateProvider: provider,
          caf: widget.cafID,
          profileID: widget.profileID,
          isPermanent: true,
        );
      case 2:
        return InstallationAddressDetailsScreen(
          subCreateProvider: provider,
          caf: widget.cafID,
          profileID: widget.profileID,
          isPermanent: false,
        );
      case 3:
        return SubscriptionDetails(
          subCreateProvider: provider,
          caf: widget.cafID,
          profileID: widget.profileID,
        );
      case 4:
        return DeviceDetails(
          subCreateProvider: provider,
          caf: widget.cafID,
          profileID: widget.profileID,
        );
      case 5:
        return GSTInformation(
          subCreateProvider: provider,
          caf: widget.cafID,
          profileID: widget.profileID,
        );
      case 6:
        return DocUpload(
          subCreateProvider: provider,
          caf: widget.cafID,
          profileID: widget.profileID,
        );
    }
  }

  void gstDialog(SubCreateProvider provider) {
    if (provider.isGSTINAdd.value) {
      provider.isGSTINAdd.value = true;
      provider.selectedIndex = 5;
      provider.notifyListeners();
      // Get.back();
    } else {
      provider.isGSTINAdd.value = false;
      if (widget.cafID == "2" &&
          provider.isSameAsPermanent &&
          !provider.isGSTINAdd.value &&
          provider.gstinModel?.taxpayertype != "2") {
        provider.notifyListeners();
        //  Get.back();
        formSubmitDialog(
          provider,
        );
      } else {
        provider.selectedIndex = 6;
        provider.notifyListeners();
        //Get.back();
      }
    }
    // GlobalFunctions.showDynamicDialog(
    //   title: 'GSTIN',
    //   content: 'GST Information to be add?',
    //   confirmButtonTitle: "Yes",
    //   cancelButtonTitle: 'No',
    //   onConfirmClick: () {
    //
    //   },
    //   onCancelClick: () {
    //
    //   },
    // );
  }

  getCanSubmit(SubCreateProvider provider) {
    return (provider.formInSubmitStatus.value &&
            (provider.selectedIndex == 6 || provider.selectedIndex == 4) &&
            (widget.cafID == "2" &&
                provider.isSameAsPermanent &&
                !provider.isGSTINAdd.value)) ||
        provider.selectedIndex == 6;
  }
}

//
//   void validateForm(SubCreateProvider provider) {
//     List<EmptyFiledModel> emptyFiled = [];
//     var i = 0;
//     NormalApplicationPostModel normalApplicationPostModel =
//     NormalApplicationPostModel();
//
//     normalApplicationPostModel.taxpayertype = provider.gstinModel?.taxpayertype;
//     normalApplicationPostModel.gstStatus = provider.gstinModel?.gststatus;
//     normalApplicationPostModel.legalname = provider.gstinModel?.legalname;
//     normalApplicationPostModel.tradename = provider.gstinModel?.tradename;
//
//     normalApplicationPostModel.caftypeid = widget.cafID;
//     normalApplicationPostModel.profileid = widget.profileID;
//
//     provider.dataExpend.forEach((element) {
//       var k = 0;
//       element.expandedValue.forEach((elements) {
//         switch (elements.fromType) {
//           case FromType.textField:
//             checkTextFiled(elements, emptyFiled, normalApplicationPostModel, i);
//
//             //  print("textfiled ${elements.textEditingController?.text}");
//             return;
//           case FromType.groupTextFiled:
//             switch (elements.key) {
//               case "GSTIN":
//                 normalApplicationPostModel.gstinSub1 =
//                     elements.filedController[0].text;
//                 normalApplicationPostModel.gstinSub2 =
//                     elements.filedController[1].text;
//                 normalApplicationPostModel.gstinSub3 =
//                     elements.filedController[2].text;
//                 normalApplicationPostModel.gstinSub4 =
//                     elements.filedController[3].text;
//                 normalApplicationPostModel.gstinSub5 =
//                     elements.filedController[4].text;
//
//                 return;
//             }
//             return;
//           case FromType.checkBox:
//             if (elements.key == "ISSAME") {
//               normalApplicationPostModel.iaddressSameasPadd =
//               elements.selectedValue ? "1" : "0";
//             }
//             print(elements.selectedValue);
//             return;
//           case FromType.radioButton:
//             checkRadio(elements, emptyFiled, normalApplicationPostModel, i);
//             return;
//           case FromType.dropDown:
//             checkDropDown(elements, emptyFiled, i, normalApplicationPostModel);
//             return;
//           case FromType.fileUpload:
//             fileUploadValidator(
//                 elements, emptyFiled, normalApplicationPostModel, i);
//             return;
//           case FromType.selectPlan:
//             normalApplicationPostModel.packageid = elements.selectedValue;
//             return;
//           case FromType.userAvailable:
//             return;
//           case FromType.image:
//             return;
//           case FromType.valueWithTitle:
//             return;
//         }
//
//         k++;
//       });
//
//       i++;
//     });
//     setState(() {});
//     // normalApplicationPostModel.toJson().forEach((key, value) {
//     //   print("$key:$value");
//     // });
//
//     var findedError =
//     mainValidator(normalApplicationPostModel, emptyFiled, provider);
//
//     if (normalApplicationPostModel.appliformcopy == null &&
//         widget.cafID == "1") {
//       findedError = true;
//     }
//     if (normalApplicationPostModel.residenceType == null ||
//         normalApplicationPostModel.addressproofNo == null ||
//         normalApplicationPostModel.addressproofCopy == null) {
//       findedError = true;
//     }
//     if (normalApplicationPostModel.idproofNo == null ||
//         normalApplicationPostModel.idproofType == null ||
//         normalApplicationPostModel.idproofCopy == null) {
//       findedError = true;
//     }
//
//     if (normalApplicationPostModel.gstinAvailable == "1" &&
//         (normalApplicationPostModel.legalname?.isEmpty ?? true)) {
//       findedError = true;
//     }
//     if (normalApplicationPostModel.gstinAvailable == "1" &&
//         (normalApplicationPostModel.panProof == null ||
//             normalApplicationPostModel.gstinproof == null)) {
//       findedError = true;
//     }
//
//     if (findedError) {
//       GlobalFunctions.showToast("Please fill all required field", false);
//     }
//
//     if (!findedError) {
//       provider.createSubscriber(normalApplicationPostModel);
//     }
//   }
//
//   Widget mainBuilder(SubCreateProvider provider) {
//     return Expanded(
//       child: ListView(
//         children: List.generate(
//           provider.dataExpend.length,
//               (index) {
//             var item = provider.dataExpend[index];
//             return ExpansionPanelList(
//               elevation: 1,
//               expandedHeaderPadding: const EdgeInsets.all(10),
//               expansionCallback: (int index, bool isExpanded) {
//                 if (!provider.isPinLoaded) {
//                   provider.getPinCodes();
//                 }
//
//                 if (!provider.isPlanLoaded) {
//                   provider.getPlans(
//                     widget.cafID,
//                     widget.profileID,
//                   );
//                 }
//                 if (!provider.isPlanTypeLoaded) {
//                   provider.getPlanType(
//                     widget.cafID,
//                     widget.profileID,
//                   );
//                 }
//                 if (!provider.isDeviceProviderLoaded) {
//                   provider.getDeviceProviderList();
//                 }
//
//                 if (!provider.isDeviceTypeLoaded) {
//                   provider.getDeviceTypeList();
//                 }
//                 if (!provider.isOLTLoaded) {
//                   provider.getOLTList();
//                 }
//
//                 if (!provider.isSupDocLoaded) {
//                   provider.getSupDocList();
//                 }
//
//                 setState(
//                       () {
//                     item.isExpanded = isExpanded;
//                     //  print(  provider.findByKey(1, "PIE")?.dropDownDataModel);
//                   },
//                 );
//               },
//               children: [
//                 ExpansionPanel(
//                   backgroundColor: bgprimaryColor,
//                   headerBuilder: (BuildContext context, bool isExpanded) {
//                     return ListTile(
//                       title: Text(item.headerValue),
//                     );
//                   },
//                   body: ListView.builder(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 15,
//                     ),
//                     shrinkWrap: true,
//                     itemCount: item.expandedValue.length,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (c, i) {
//                       var singleItem = item.expandedValue[i];
//                       return MainFormBuilder(
//                         singleItem: singleItem,
//                         mainIndex: index,
//                         provider: provider,
//                         caf: widget.cafID,
//                         profileID: widget.profileID,
//                         aadharDetailsModel: widget.aadharDetailsModel,
//                       );
//                     },
//                   ),
//                   isExpanded: item.isExpanded,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   bool mainValidator(NormalApplicationPostModel normalApplicationPostModel,
//       List<EmptyFiledModel> emptyFiled, SubCreateProvider provider) {
//     var findError = false;
//
//     /// if (widget.cafID == "1") {
//     ///normal application
//     //     if (widget.profileID == "1") {
//     emptyFiled.forEach(
//           (element) {
//         switch (element.key) {
//         ///personal details
//           case "FN":
//           case "DOB":
//           case "GE":
//           case "MN":
//           case "EA":
//
//           ///permanent address and installation address
//           case "DNA":
//           case "SLN":
//           case "CIY":
//           case "PIE":
//           case "PON":
//           case "DIT":
//           case "LTY":
//           case "LBY":
//           //no 1
//           case "VIN":
//           case "BLN":
//           //no 2
//           case "CMN":
//
//           ///  user details
//           case "DEU":
//           case "USAV":
//           case "SPLTY":
//           case "SEP":
//
//           ///device details
//           case "DEPR":
//           case "DETY":
//           case "DEMK":
//           case "DEMO":
//           case "DEMAA":
//           case "OLTTY":
//
//           ///suppor doc
//           // case "AFC":
//           // case "RPC":
//           // case "IPC":
//           // case "GSPC":
//           // case "PPC":
//
//           ///GST DETAILS
//           // case "GSTIA":
//           // case "GSPA":
//           // case "GSTIN":
//           // case "TAXPY":
//           // case "LNOB":
//           // case "TRAN":
//           // print(element.error);
//             if (element.error != null) {
//               ///validate address
//               if (element.mainIndex == 1) {
//                 print(element.key);
//                 if (normalApplicationPostModel.locType == "1" &&
//                     (element.key == "VIN" || element.key == "BLN")) {
//                   return;
//                 } else if (normalApplicationPostModel.locType == "2" &&
//                     element.key == "CMN") {
//                   return;
//                 }
//               } else if (element.mainIndex == 2) {
//                 if (normalApplicationPostModel.locTypeInsta == "1" &&
//                     (element.key == "VIN" || element.key == "BLN")) {
//                   return;
//                 } else if (normalApplicationPostModel.locTypeInsta == "2" &&
//                     element.key == "CMN") {
//                   return;
//                 }
//               }
//
//               ///user details validate
//               if (element.key == "USAV") {
//                 if (!(provider
//                     .findByKey(element.mainIndex, "USAV")
//                     ?.name
//                     .trim()
//                     .isEmpty ??
//                     true)) {
//                   return;
//                 }
//               }
//
//               ///doc validate
//
//               //   if (widget.cafID != "1") {
//
//               // }
//
//               // ///GSTIN VALIDATE
//               // if (!("${provider.findByKey(6, "GSTIA")?.selectedValue}"
//               //         .isEmpty ||
//               //     provider.findByKey(6, "GSTIA")?.selectedValue == null)) {
//               //   if (provider.findByKey(6, "LNOB")?.errorText != null) {
//               //     //return;
//               //   }
//               // }
//               findError = true;
//             }
//
//             return;
//         }
//       },
//     );
//     //  } else if (widget.profileID == "2") {
//     //  } else if (widget.profileID == "3") {}
//     //  } else if (widget.cafID == "2") {
//     ///kyc application
//     //   }
//
//     return findError;
//   }
// }
//
// class PlanTile extends StatelessWidget {
//   final List<String>? planlistHeadings;
//   final List<String>? singleItem;
//   final Function onTab;
//
//   const PlanTile(this.planlistHeadings,
//       this.singleItem, {
//         super.key,
//         required this.onTab,
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: () {
//           onTab(singleItem);
//         },
//         child: ListTile(
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(
//               planlistHeadings?.length ?? 0,
//                   (index) {
//                 var title = planlistHeadings?[index];
//                 var value = singleItem?[index];
//                 return Text('${title} : ${value}');
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// checkNullOrEmpty(String? value) {
//   return value != null ||
//       (value?.isNotEmpty ?? false) ||
//       value.toString() == "null";
// }
//
// checkErrorText
// (
// String? value)
//
//
// mainWidget(){
// return SafeArea(
// child: BuildUI(
// isLoad: provider.isLoading,
// isError: provider.isError,
// onRefreshClick: () {
// provider.getAppID(
// widget.cafID,
// widget.profileID,
// );
// },
// mainUi: Column(
// children: [
// mainBuilder(provider),
// Container(
// margin: const EdgeInsets.symmetric(
// horizontal: 25,
// ),
// child: CustomButton(
// title: "Submit",
// onClickFunction: () {
// validateForm(provider);
// },
// ),
// ),
// ],
// ),
// ),
// );
// }
