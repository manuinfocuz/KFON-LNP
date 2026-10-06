import 'dart:async';

import 'package:get/get.dart';
import 'package:kfon_lnp/data_model/message_model.dart';
import 'package:kfon_lnp/data_model/subscriber/device_provider_list_model.dart';
import 'package:kfon_lnp/data_model/subscriber/device_type_list_model.dart';
import 'package:kfon_lnp/data_model/subscriber/gstin_model.dart';
import 'package:kfon_lnp/data_model/subscriber/normal_application_post_model.dart';
import 'package:kfon_lnp/data_model/subscriber/olt_list_model.dart';
import 'package:kfon_lnp/data_model/subscriber/ont_device_details_model.dart';
import 'package:kfon_lnp/data_model/subscriber/plan_type_list_model.dart';
import 'package:kfon_lnp/models/form_type_model.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/widget/global_loader/global_loading_dialog_controller.dart';

import '../../data_model/subscriber/aadharDetailsModel.dart';
import '../../data_model/subscriber/districts_po_data_model.dart';
import '../../data_model/subscriber/local_body_list_data_model.dart';
import '../../data_model/subscriber/new_plan_list_model.dart';
import '../../data_model/subscriber/ont_device_list_data_model.dart';
import '../../data_model/subscriber/pincode_data_model.dart';
import '../../data_model/subscriber/supported_list_doc_model.dart';
import '../../data_model/subscriber/village_block_munsi_data_list.dart';
import '../../repository/subscriber_create_repository.dart';
import 'package:flutter/material.dart';

import '../../utils/make_form_data.dart';

class SubCreateProvider with ChangeNotifier {
  int selectedIndex = 0;

  ///personal details
  TextEditingController applicationNoController = TextEditingController();
  TextEditingController applicantNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController contactPersonNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? selectedGender;

  ///personal details

  ///address details
  TextEditingController doorNoController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  ///dropdown
  String? selectedPinCode;
  String? selectedPinCodeID;
  List<DropDownDataModel> pinCodeDropDown = [];
  String? selectedPostOffice;
  String? selectedPostOfficeID;
  List<DropDownDataModel> postOfficeDropDown = [];
  String? selectedDistrict;
  String? selectedDistrictID;
  List<DropDownDataModel> districtDropDown = [];

  ///dropdown
  String? selectedLocationType;

  ///dropdown
  String? selectedLocationBody;
  String? selectedLocationBodyID;
  List<DropDownDataModel> locationBodyDropDown = [];
  String? selectedVillageName;
  String? selectedVillageNameID;
  List<DropDownDataModel> villageDropDown = [];
  String? selectedBlockName;
  String? selectedBlockNameID;
  List<DropDownDataModel> blockDropDown = [];
  String? selectedCorporation;
  String? selectedCorporationID;
  List<DropDownDataModel> corporationDropDown = [];

  ///dropdown
  ///address details

  ///installaddress details
  TextEditingController doorNoControllerInstall = TextEditingController();
  TextEditingController streetNameControllerInstall = TextEditingController();
  TextEditingController cityControllerInstall = TextEditingController();

  ///dropdown
  String? selectedPinCodeInstall;
  String? selectedPinCodeIDInstall;
  List<DropDownDataModel> pinCodeDropDownInstall = [];
  String? selectedPostOfficeInstall;
  String? selectedPostOfficeIDInstall;
  List<DropDownDataModel> postOfficeDropDownInstall = [];
  String? selectedDistrictInstall;
  String? selectedDistrictIDInstall;
  List<DropDownDataModel> districtDropDownInstall = [];

  ///dropdown
  String? selectedLocationTypeInstall;

  ///dropdown
  String? selectedLocationBodyInstall;
  String? selectedLocationBodyIDInstall;
  List<DropDownDataModel> locationBodyDropDownInstall = [];
  String? selectedVillageNameInstall;
  String? selectedVillageNameIDInstall;
  List<DropDownDataModel> villageDropDownInstall = [];
  String? selectedBlockNameInstall;
  String? selectedBlockNameIDInstall;
  List<DropDownDataModel> blockDropDownInstall = [];
  String? selectedCorporationInstall;
  String? selectedCorporationIDInstall;
  List<DropDownDataModel> corporationDropDownInstall = [];

  bool isSameAsPermanent = false;

  ///dropdown
  ///address details

  /// subscription details
  TextEditingController userNameController = TextEditingController();
  bool userNameAvailable = false;
  String? userNameError;
  String? selectedPlanType;
  String? selectedPlanTypeID;
  List<DropDownDataModel> planTypeDropDown = [];
  TextEditingController selectedPackageController = TextEditingController();
  String? selectedPlanID;
  String? selectedPlan;

  /// subscription details

  ///device details
  String? selectedDeviceProvider;
  String? selectedDeviceProviderID;
  List<DropDownDataModel> deviceProviderDropDown = [];
  List<DropDownDataModel> ontDeviceDropDown = [];

  String? selectedDeviceType;
  String? selectedDeviceTypeID;
  List<DropDownDataModel> deviceTypeDropDown = [];
  TextEditingController vlanIDController = TextEditingController();
  TextEditingController deviceMakeController = TextEditingController();
  TextEditingController deviceModelController = TextEditingController();
  TextEditingController deviceMacAddress = TextEditingController();
  String? selectedONT;
  String? selectedONTID;
  List<DropDownDataModel> ontDropDown = [];
  String? selectedONTDeviceID;
  String? selectedONTDeviceSLNO;

  RxBool configureSSID = false.obs;

  TextEditingController ssid24Controller = TextEditingController();
  TextEditingController ssidPassword24Controller = TextEditingController();

  TextEditingController ssid5Controller = TextEditingController();
  TextEditingController ssidPassword5Controller = TextEditingController();

  List<DropDownDataModel> oltDropDown = [];
  String? selectedOLT;
  String? selectedOLTID;

  List<DropDownDataModel> ponPortDropDown = [];
  String? selectedPonPort;
  String? selectedPonPortID;

  TextEditingController oltPosition = TextEditingController();

  ///device details

  ///gstin
  RxBool isGSTINAdd = false.obs;
  TextEditingController panController = TextEditingController();
  TextEditingController gstinOneController = TextEditingController(text: "32");
  TextEditingController gstinThreeController = TextEditingController();
  TextEditingController gstinFourController = TextEditingController(text: "Z");
  TextEditingController gstinFiveController = TextEditingController();

  TextEditingController texPayerController = TextEditingController();
  TextEditingController legalBusNameController = TextEditingController();
  TextEditingController tradeNameController = TextEditingController();
  final SubscriberCreateRepository _subscriberCreateRepository =
      SubscriberCreateRepository();

  ///
  String? selectedApplicationCopy;
  String? selectedResidenceCopy;
  String? selectedSupportResID;
  String? selectedSupportRes;
  List<DropDownDataModel> supportResidenceCopyDropDown = [];
  TextEditingController residenceController = TextEditingController();
  String? selectedIDProofCopy;
  String? selectedSupportidID;
  String? selectedSupportid;
  List<DropDownDataModel> supportIDCopyDropDown = [];
  TextEditingController idProofController = TextEditingController();
  String? GSTINProofCopy;
  String? panProofCopy;
  String? lutLetter;
  GstinModel? gstinModel;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isError = false;

  bool get isError => _isError;

  set setIsError(bool value) {
    _isError = value;
    notifyListeners();
  }

  List<Item> dataExpend = [];

  bool isPinLoaded = false;
  bool isPlanLoaded = false;
  bool isDeviceProviderLoaded = false;
  bool isDeviceTypeLoaded = false;
  bool isOLTLoaded = false;
  bool isSupDocLoaded = false;
  bool isPlanTypeLoaded = false;

  LocalBodyListDataModel? localBodyListDataModel;
  NewPlanListModel? newPlanListModel;
  PlanTypeListModel? planTypeListModel;

  RxBool formInSubmitStatus = false.obs;

  ///RxBool isOnlyView = false.obs;

  SubCreateProvider(String cafID, String profileID,
      {AadharDetailsModel? aadharDetailsModel}) {
    // MakeFormData.createForm(dataExpend);
    getAppID(cafID, profileID);

    if (aadharDetailsModel != null && cafID == "2") {
      dobController.text = aadharDetailsModel.dob ?? "";
      //
      // if (aadharDetailsModel.genderid?.toLowerCase() == "1") {
      //   selectedGender = "1";
      // } else if (aadharDetailsModel.gender?.toLowerCase() == "2") {
      //   selectedGender = "2";
      // } else {
      //   selectedGender = "3";
      // }
      selectedGender = "${aadharDetailsModel.genderid?.toLowerCase()}";
      applicantNameController.text = aadharDetailsModel.name ?? "";

      emailController.text = aadharDetailsModel.email ?? "";
      mobileController.text = aadharDetailsModel.mobileno ?? "";

      doorNoController.text = aadharDetailsModel.doorno ?? "";
      streetNameController.text = aadharDetailsModel.streetlo ?? "";
      cityController.text = aadharDetailsModel.cityname ?? "";
      Future.delayed(Duration(milliseconds: 100), () {
        lodaIntialData(aadharDetailsModel);
      });
    }
  }

  void lodaIntialData(AadharDetailsModel aadharDetailsModel) async {
    await getPinCodes(true);
    var data = pinCodeDropDown
        .where((element) => element.id == aadharDetailsModel.pincode);
    if (data.isNotEmpty) {
      selectedPinCodeID = aadharDetailsModel.pincode;
      selectedPinCode = aadharDetailsModel.pincode;
      getDistrictAndPostOffice("$selectedPinCodeID", true);
    }
  }

  Timer? timer;

  ///API START
  Future<dynamic> getAppID(String cafID, String profileID) async {
    setIsLoading = true;
    setIsError = false;
    var data =
        await _subscriberCreateRepository.getApplicationID(cafID, profileID);

    if (data != null) {
      data as MessageModel;
      applicationNoController.text = "${data.appno}";
      // findByKey(0, "AID")?.textEditingController?.text = "${data.appno}";
    } else {
      setIsError = true;
    }
    setIsLoading = false;
    notifyListeners();
  }

  Future<dynamic> getPinCodes(bool isPermanent) async {
    GlobalLoadingDialogController.openDialog();
    //setIsLoading = true;
    setIsError = false;
    var data = await _subscriberCreateRepository.getPinCodes();

    if (data != null) {
      data as PincodeDataModel;
      List<DropDownDataModel> pinCodeList = [];
      for (var element in data.pinlist) {
        pinCodeList.add(
          DropDownDataModel(
            value: "${element.pincode}",
            key: "${element.pincode}",
            id: "${element.pincode}",
          ),
        );
      }
      if (isPermanent) {
        pinCodeDropDown = pinCodeList;
      } else {
        pinCodeDropDownInstall = pinCodeList;
      }

      //   findByKey(1, "PIE")?.dropDownDataModel = pinCodeList;
      //   findByKey(2, "PIE")?.dropDownDataModel = pinCodeList;

      isPinLoaded = true;
    } else {
      //setIsError = true;
    }
    setIsLoading = false;
    GlobalLoadingDialogController.closeDialog();
    notifyListeners();
  }

  Future<dynamic> getDistrictAndPostOffice(
      String pinCode, bool isPermanent) async {
    var data = await _subscriberCreateRepository.getDistrictsAndPo(pinCode);
    // findByKey(mainIndex, "PON")?.dropDownDataModel = [];
    // findByKey(mainIndex, "DIT")?.dropDownDataModel = [];
    if (data != null) {
      data as DistrictsAndPoDataModel;
      List<DropDownDataModel> districtList = [];
      List<DropDownDataModel> pfList = [];
      for (var element in data.dtlist) {
        districtList.add(DropDownDataModel(
          value: "${element.district}",
          key: "${element.districtcode}",
          id: "${element.districtcode}",
        ));
      }
      for (var element in data.pflist) {
        pfList.add(DropDownDataModel(
          value: "${element.postOfficeName}",
          key: "${element.postOfficeName}",
          id: "${element.postOfficeName}",
        ));
      }
      print(isPermanent);

      if (isPermanent) {
        postOfficeDropDown = pfList;
        districtDropDown = districtList;
      } else {
        postOfficeDropDownInstall = pfList;
        districtDropDownInstall = districtList;
      }

      // findByKey(mainIndex, "PON")?.dropDownDataModel = pfList;
      // findByKey(mainIndex, "DIT")?.dropDownDataModel = districtList;
    } else {}
    setIsLoading = false;
  }

  Future<dynamic> getLocalBodyList(bool isPermanent) async {
    var pincode;
    var postOffice;
    var district;
    var locationType;

    if (isPermanent) {
      pincode = selectedPinCode;
      postOffice = selectedPostOfficeID;
      district = selectedDistrictID;
      locationType = selectedLocationType;
    } else {
      pincode = selectedPinCodeInstall;
      postOffice = selectedPostOfficeIDInstall;
      district = selectedDistrictIDInstall;
      locationType = selectedLocationTypeInstall;
    }
    // findByKey(mainIndex, "LBY")?.dropDownDataModel = [];
    // var pinCode = findByKey(mainIndex, "PIE")?.selectedValue;
    // var dis = findByKey(mainIndex, "DIT")?.selectedValue;
    // var po = findByKey(mainIndex, "PON")?.selectedValue;
    // var lt = findByKey(mainIndex, "LTY")?.selectedValue;

    var data = await _subscriberCreateRepository.getLocalBodyList(
      pincode,
      postOffice,
      district,
      locationType,
    );
    if (data != null) {
      localBodyListDataModel = data;
      List<DropDownDataModel> listLocalBody = [];
      localBodyListDataModel?.localBodyList.forEach(
        (element) {
          listLocalBody.add(
            DropDownDataModel(
              value: "${element.villageType}",
              key: "${element.villageTypeId}",
              id: "${element.villageTypeId}",
            ),
          );
        },
      );
      if (isPermanent) {
        locationBodyDropDown = listLocalBody;
      } else {
        locationBodyDropDownInstall = listLocalBody;
      }

      // findByKey(mainIndex, "LBY")?.dropDownDataModel = listLocalBody;
    } else {}

    setIsLoading = false;
  }

  Future<dynamic> getVBM(bool isPermanent) async {
    var pincode;
    var postOffice;
    var district;
    var locationType;
    var localBody;

    if (isPermanent) {
      pincode = selectedPinCode;
      postOffice = selectedPostOfficeID;
      district = selectedDistrictID;
      locationType = selectedLocationType;
      localBody = selectedLocationBodyID;
    } else {
      pincode = selectedPinCodeInstall;
      postOffice = selectedPostOfficeIDInstall;
      district = selectedDistrictIDInstall;
      locationType = selectedLocationTypeInstall;
      localBody = selectedLocationBodyIDInstall;
    }
    // var pinCode = findByKey(mainIndex, "PIE")?.selectedValue;
    // var dis = findByKey(mainIndex, "DIT")?.selectedValue;
    // var po = findByKey(mainIndex, "PON")?.selectedValue;
    // var lt = findByKey(mainIndex, "LTY")?.selectedValue;
    // var vt = findByKey(mainIndex, "LBY")?.selectedValue;
    var data = await _subscriberCreateRepository.getVMBList(
      pincode,
      postOffice,
      district,
      locationType,
      localBody,
    );
    if (data != null) {
      data as VillageBlkMunsiDatalist;
      List<DropDownDataModel> vilList = [];
      data.villageList.forEach(
        (element) {
          vilList.add(
            DropDownDataModel(
                value: "${element.villageName}",
                key: "${element.villageName}",
                id: "${element.villageName}"),
          );
        },
      );
      List<DropDownDataModel> blkList = [];
      data.blockList.forEach((element) {
        blkList.add(
          DropDownDataModel(
              value: "${element.blockName}",
              key: "${element.blockId}",
              id: "${element.blockId}"),
        );
      });

      List<DropDownDataModel> muList = [];
      data.municiplaityList.forEach((element) {
        muList.add(
          DropDownDataModel(
              value: "${element.municipalityName}",
              key: "${element.municipalityName}",
              id: "${element.municipalityName}"),
        );
      });
      if (isPermanent) {
        villageDropDown = vilList;
        blockDropDown = blkList;
        corporationDropDown = muList;
      } else {
        villageDropDownInstall = vilList;
        blockDropDownInstall = blkList;
        corporationDropDownInstall = muList;
      }

      // findByKey(mainIndex, "VIN")?.dropDownDataModel = vilList;
      // findByKey(mainIndex, "BLN")?.dropDownDataModel = blkList;
      // findByKey(mainIndex, "CMN")?.dropDownDataModel = muList;
    } else {}
    setIsLoading = false;
  }

  Future<dynamic> getPlans(String caf, String profileID) async {
    //setIsLoading = true;
    //setIsError = false;
    var data = await _subscriberCreateRepository.getPlans(caf, profileID);

    if (data != null) {
      newPlanListModel = data;

      isPlanLoaded = true;
    } else {
      //setIsError = true;
    }
    setIsLoading = false;
    notifyListeners();
  }

  Future<dynamic> getPlanType(String caf, String profileID) async {
    GlobalLoadingDialogController.openDialog();
    //setIsLoading = true;
    //setIsError = false;
    var data = await _subscriberCreateRepository.getPlanType(caf, profileID);

    if (data != null) {
      planTypeListModel = data;
      var i = 1;
      List<DropDownDataModel> inData = [];
      planTypeListModel?.plantypes?.toList().forEach(
        (element) {
          inData.add(
            DropDownDataModel(
              value: element,
              key: "$i",
              id: "$i",
            ),
          );
          i++;
        },
      );
      planTypeDropDown = inData;
      isPlanTypeLoaded = true;
    } else {
      //setIsError = true;
    }
    setIsLoading = false;
    GlobalLoadingDialogController.closeDialog();
    notifyListeners();
  }

  Future<dynamic> getDeviceProviderList() async {
    GlobalLoadingDialogController.openDialog();
    //setIsLoading = true;
    //setIsError = false;
    var data = await _subscriberCreateRepository.getDeviceProviderList();

    if (data != null) {
      data as DeviceProviderListModel;
      List<DropDownDataModel> muList = [];

      data.devicePlist.forEach((element) {
        muList.add(
          DropDownDataModel(
              value: "${element.providerName}",
              key: "${element.id}",
              id: "${element.id}"),
        );
      });

      deviceProviderDropDown = muList;
      isDeviceProviderLoaded = true;
    } else {
      //setIsError = true;
    }
    GlobalLoadingDialogController.closeDialog();
    setIsLoading = false;
    notifyListeners();
  }

  Future<dynamic> getDeviceTypeList() async {
    GlobalLoadingDialogController.openDialog();
    //setIsLoading = true;
    //setIsError = false;
    var data = await _subscriberCreateRepository.getDeviceTypeList();

    if (data != null) {
      data as DeviceTypeListModel;
      List<DropDownDataModel> muList = [];
      data.deviceTlist.forEach((element) {
        muList.add(
          DropDownDataModel(
              value: "${element.deviceTypeName}",
              key: "${element.id}",
              id: "${element.id}"),
        );
      });

      deviceTypeDropDown = muList;
      isDeviceTypeLoaded = true;
    } else {
      //setIsError = true;
    }
    GlobalLoadingDialogController.closeDialog();
    setIsLoading = false;
    notifyListeners();
  }

  Future<dynamic> getONTList() async {
    GlobalLoadingDialogController.openDialog();
    var data = await _subscriberCreateRepository.getONTList();
    if (data != null) {
      data as OltListModel;
      List<DropDownDataModel> muList = [];
      for (var element in data.oltlist) {
        muList.add(
          DropDownDataModel(
              value: "${element.oltTypeName}",
              key: "${element.oltType}",
              id: "${element.oltType}"),
        );
      }

      ontDropDown = muList;
      isOLTLoaded = true;
    } else {
      //setIsError = true;
    }
    setIsLoading = false;
    GlobalLoadingDialogController.closeDialog();
    notifyListeners();
  }

  ///new
  Future<dynamic> getOLTList() async {
    GlobalLoadingDialogController.openDialog();
    //setIsLoading = true;
    //setIsError = false;
    var data = await _subscriberCreateRepository.getOLTList();

    if (data != null) {
      List<DropDownDataModel> muList = [];
      for (var element in data.oltList) {
        muList.add(
          DropDownDataModel(
              value: "${element.deviceSerial}",
              key: "${element.oltid}",
              id: "${element.oltid}"),
        );
      }

      oltDropDown = muList;
    } else {
      //setIsError = true;
    }
    setIsLoading = false;
    GlobalLoadingDialogController.closeDialog();
    notifyListeners();
  }

  Future<dynamic> getPonList() async {
    GlobalLoadingDialogController.openDialog();
    //setIsLoading = true;
    //setIsError = false;
    var data = await _subscriberCreateRepository.getPONPortList(
      selectedOLTID,
    );
    GlobalLoadingDialogController.closeDialog();
    ponPortDropDown.clear();
    if (data != null) {
      List<DropDownDataModel> muList = [];
      for (var element in data.ponList) {
        muList.add(
          DropDownDataModel(
              value: "${element.ponportNumber}",
              key: "${element.ponportId}",
              id: "${element.ponportId}"),
        );
      }

      ponPortDropDown = muList;
      //  isOLTLoaded = true;
    } else {
      //setIsError = true;
    }
    setIsLoading = false;

    notifyListeners();
  }

  Future<dynamic> getSupDocList() async {
    GlobalLoadingDialogController.openDialog();
    //setIsLoading = true;
    //setIsError = false;
    var data = await _subscriberCreateRepository.getSupoDocList();

    if (data != null) {
      data as SupportedDocListModel;
      List<DropDownDataModel> muList = [];
      List<DropDownDataModel> muList2 = [];

      data.documnetList?.identityProofCopy.forEach((element) {
        muList.add(
          DropDownDataModel(
            value: element,
            key: element,
            id: element,
          ),
        );
      });

      data.documnetList?.residenceProofCopy.forEach((element) {
        muList2.add(
          DropDownDataModel(
            value: element,
            key: element,
            id: element,
          ),
        );
      });

      supportResidenceCopyDropDown = muList2;
      supportIDCopyDropDown = muList;
      isSupDocLoaded = true;
    } else {
      //setIsError = true;
    }
    GlobalLoadingDialogController.closeDialog();
    setIsLoading = false;
    notifyListeners();
  }

  Future<dynamic> checkUserName(String userName) async {
    timer?.cancel();
    if (userName.length < 3) {
      userNameAvailable = false;
      userNameError = "Must be 3 characters or more";
      setIsLoading = false;
      return;
    }
    // if (userName.isEmpty) {
    //   var avData = findByKey(3, "USAV");
    //   avData?.selectedValue = "Username must be not empty";
    //   avData?.isTrue = false;
    //   notifyListeners();
    //   return;
    // }
    timer = Timer(const Duration(milliseconds: 600), () async {
      //setIsLoading = true;
      //setIsError = false;
      var data = await _subscriberCreateRepository.checkUserName(userName);
      //    var avData = findByKey(3, "USAV");
      if (data != null) {
        data as MessageModel;
        userNameAvailable = data.status;
        userNameError = data.message;
        // avData?.isTrue = data.status;
        // avData?.selectedValue = data.message;
      } else {}
      setIsLoading = false;
      notifyListeners();
    });
  }

  Future<void> checkGSTIN() async {
    texPayerController.text = "";
    legalBusNameController.text = "";
    tradeNameController.text = "";

    var gstin =
        "${gstinOneController.text}${panController.text}${gstinThreeController.text}${gstinFourController.text}${gstinFiveController.text}";

    print(gstin);
    if (gstin.trim().length == 15) {
      var data = await _subscriberCreateRepository.checkGSTIN(gstin);

      if (data != null) {
        data as GstinModel;
        gstinModel = data;
        texPayerController.text = data.taxpayertypeName ?? "";
        legalBusNameController.text = data.legalname ?? "";
        tradeNameController.text = data.tradename ?? "";
      }
    }
  }

  Future<void> createSubscriber(
      NormalApplicationPostModel normalApplicationPostModel) async {
    GlobalLoadingDialogController.openDialog();

    var data = await _subscriberCreateRepository
        .createSubscriber(normalApplicationPostModel);
    if (data != null) {
      data as MessageModel;
      GlobalFunctions.showToast(data.message, true);
      LocaleProvider localeProvider = Get.find();
      localeProvider.navigateDeleteUntil(
        AppRoutes.HOMESCREEN,
      );
      GlobalLoadingDialogController.closeDialog();
    } else {
      GlobalLoadingDialogController.closeDialog();
    }
  }

  Future<void> getDeviceONTList() async {
    selectedONTDeviceID = null;
    selectedONTDeviceSLNO = null;
    GlobalLoadingDialogController.openDialog();
    var data = await _subscriberCreateRepository.getONTDeviceList();
    if (data != null) {
      data as OntDeviceListDataModel;
      ontDeviceDropDown = [];
      for (var element in data.devlist) {
        ontDeviceDropDown.add(
          DropDownDataModel(
              value: "${element.deviceSlno}",
              key: "${element.deviceid}",
              id: "${element.deviceid}"),
        );
      }
      GlobalLoadingDialogController.closeDialog();
    } else {
      GlobalLoadingDialogController.closeDialog();
    }
    setIsLoading = false;
  }

  Future<void> getONTDeviceDetails() async {
    GlobalLoadingDialogController.openDialog();
    var data = await _subscriberCreateRepository
        .getONTDeviceDetails(selectedONTDeviceID);
    if (data != null) {
      data as OntDeviceDetailsDataModel;
      deviceMakeController.text = data.deviceMake ?? "";
      deviceModelController.text = data.deviceModel ?? "";
      deviceMacAddress.text = data.deviceMakeAddr ?? "";
      GlobalLoadingDialogController.closeDialog();
    } else {
      GlobalLoadingDialogController.closeDialog();
    }
    setIsLoading = false;
  }

  ///API END

  FromTypeModel? findByKey(int mainID, String key) {
    FromTypeModel? fromTypeModel;

    dataExpend[mainID].expandedValue.forEach(
      (element) {
        if (key == element.key) {
          fromTypeModel = element;
        }
      },
    );
    return fromTypeModel;
  }

  void removeValueByKey(int mainID, String key) {
    findByKey(mainID, key)?.selectedDisplayValue = "";
    findByKey(mainID, key)?.selectedValue = "";
    setIsLoading = false;
  }

  refreshState() {
    notifyListeners();
  }

  int getGenderCode(String gender) {
    String lowerGender = gender.toLowerCase();
    if (lowerGender == 'male') {
      return 1;
    } else if (lowerGender == 'female') {
      return 2;
    } else {
      return 3; // Assuming 'other' for any other input
    }
  }
}
