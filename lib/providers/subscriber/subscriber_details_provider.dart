import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/message_model.dart';
import 'package:kfon_lnp/data_model/subscriber/active_subscriber_list.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/providers/subscriber/sub_list_provider.dart';
import 'package:kfon_lnp/repository/subscriber_repository.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/view/subscriber/subscriber_details/subscriber_details_screen.dart';

import '../../data_model/subscriber/data_usage_model.dart';
import '../../data_model/subscriber/package_list_model.dart';
import '../../data_model/subscriber/subscriber_details_model.dart';
import '../../models/form_type_model.dart';
import '../../repository/subscriber_create_repository.dart';
import '../../utils/api_end_points.dart';
import '../../widget/global_loader/global_loading_dialog_controller.dart';

class SubscriberDetailsProvider with ChangeNotifier {
  final SubscriberRepository _subscriberRepository = SubscriberRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  RxList<DropDownDataModel> oltAvailDropDown = <DropDownDataModel>[].obs;
  Rxn<DropDownDataModel> selectedOltDropDown = Rxn<DropDownDataModel>();

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

  set notify(val) {
    notifyListeners();
  }

  final SubListProvider _subListProvider = Get.find();
  DataUsageModel? dataUsageModel;
  String? subId;

  SubscriberDetailsProvider(String subID, String username) {
    subIDG = subID;
    usernameG=username;
    Future.delayed(
      const Duration(milliseconds: 10),
      () async {
        subId = subID;
        await getSubscriberDetails(subID);
        await getDataUsage( );
      },
    );
  }

  String? subIDG;
  String? usernameG;
  SubscriberDetailsModel? subscriberDetailsModel;
  PackageListModel? packageListModel;

  Future<dynamic> getSubscriberDetails(String? subID,
      {bool hideData = true}) async {
    setIsError = false;
    if (hideData) {
      setIsLoading = true;
    }
    await GlobalLoadingDialogController.openDialog();
    var subscriberDetails =
        await _subscriberRepository.getSubscriberDetails(subID ?? subId ?? '');

    if (subscriberDetails != null) {
      subscriberDetailsModel = subscriberDetails;
      setIsError = false;
      setIsLoading = false;
    } else {
      setIsError = true;
      setIsLoading = false;
    }

    if (!hideData) {
      _subListProvider.getSubList();
    }

    await GlobalLoadingDialogController.closeDialog();
  }

  Future<dynamic> getDataUsage({String? username, String? subID}) async {
    GlobalLoadingDialogController.openDialog();

    var data = await _subscriberRepository.getDataUsage(username ?? usernameG ??'', subID ?? subIDG??'');

    if (data != null) {
      dataUsageModel = data;

      // var temp = {
      //   "status": true,
      //   "total_upload": "28345.68 MB",
      //   "total_download": "331322.59 MB",
      //   "total_usage": "359668.27MB",
      //   "radsessions": [
      //     {
      //       "callingstationid": " 7c-a9-6b-a5-26-59",
      //       "framedipaddress": "100.122.104.153",
      //       "acctstarttime": "2023-08-15 11:34:28",
      //       "acctstoptime": "2023-04-0910:26:21",
      //       "upload": "0.0002",
      //       "download": "0.0003",
      //       "nasipaddress": "172.31.34.36"
      //     },
      //     {
      //       "callingstationid": " 7c-a9-6b-a5-26-59",
      //       "framedipaddress": "100.122.104.167",
      //       "acctstarttime": "2023-08-15 11:34:28",
      //       "acctstoptime": "2023-04-2412:16:52",
      //       "upload": "18882.5961",
      //       "download": "185915.6179",
      //       "nasipaddress": "172.31.34.36"
      //     },
      //     {
      //       "callingstationid": "7c-a9-6b-a5-26-59 ",
      //       "framedipaddress": "100.122.29.213",
      //       "acctstarttime": "2023-08-15 11:34:28",
      //       "acctstoptime": "2023-04-2609:46:04",
      //       "upload": "2261.0949",
      //       "download": "27517.9062",
      //       "nasipaddress": "172.31.34.36"
      //     },
      //     {
      //       "callingstationid": "7c-a9-6b-a5-26-59 ",
      //       "framedipaddress": "100.114.66.35",
      //       "acctstarttime": "2023-08-15 11:34:28",
      //       "acctstoptime": "2023-04-2610:50:39",
      //       "upload": "59.3503",
      //       "download": "943.5921",
      //       "nasipaddress": "172.31.32.112"
      //     },
      //     {
      //       "callingstationid": "7c-a9-6b-a5-26-59 ",
      //       "framedipaddress": "100.114.88.76",
      //       "acctstarttime": "2023-08-15 11:34:28",
      //       "acctstoptime": "2023-04-2613:28:06",
      //       "upload": "174.7863",
      //       "download": "3483.2855",
      //       "nasipaddress": "172.31.32.112"
      //     },
      //     {
      //       "callingstationid": "7c-a9-6b-a5-26-59 ",
      //       "framedipaddress": "100.122.9.65",
      //       "acctstarttime": "2023-08-15 11:34:28",
      //       "acctstoptime": "2023-04-2615:48:57",
      //       "upload": "244.1549",
      //       "download": "4271.1178",
      //       "nasipaddress": "172.31.34.36"
      //     },
      //     {
      //       "callingstationid": "7c-a9-6b-a5-26-59 ",
      //       "framedipaddress": "100.122.14.130",
      //       "acctstarttime": "2023-08-15 11:34:28",
      //       "acctstoptime": "2023-05-0319:59:46",
      //       "upload": "6581.5894",
      //       "download": "108003.7464",
      //       "nasipaddress": "172.31.34.36"
      //     },
      //     {
      //       "callingstationid": "7c-a9-6b-a5-26-59 ",
      //       "framedipaddress": "100.122.106.52",
      //       "acctstarttime": "2023-08-15 11:34:28",
      //       "acctstoptime": "2023-05-0322:03:58",
      //       "upload": "142.1081",
      //       "download": "1187.3213",
      //       "nasipaddress": "172.31.34.36"
      //     }
      //   ],
      //   "Message": ""
      // };
      //
      // dataUsageModel = DataUsageModel.fromJson(temp);
    } else {}
    GlobalLoadingDialogController.closeDialog();
  }

  Future<dynamic> topUpUser(String subID) async {
    setIsError = false;
    //   setIsLoading = true;
    GlobalLoadingDialogController.openDialog();
    var rechargeMsg = await _subscriberRepository.topUpUser(subID);
    if (rechargeMsg != null) {
      setIsError = false;
      setIsLoading = false;
      rechargeMsg as MessageModel;
      getSubscriberDetails(subID, hideData: false);
      GlobalFunctions.showToast(rechargeMsg.message, true);
      LocaleProvider localeProvider = Get.find();
      localeProvider.getSetProfile(
        isFirst: false,
      );
    } else {}
    GlobalLoadingDialogController.closeDialog();
  }

  Future<bool> getPackages(String subID) async {
    setIsError = false;
    //   setIsLoading = true;
    GlobalLoadingDialogController.openDialog();
    var packageList = await _subscriberRepository.getPackages(subID);
    if (packageList != null) {
      setIsError = false;
      setIsLoading = false;
      packageListModel = packageList;
      GlobalLoadingDialogController.closeDialog();
      return true;
    } else {}
    GlobalLoadingDialogController.closeDialog();
    return false;
  }

  Future<bool> getUserConfirm(String subID, String packageID) async {
    // setIsError = false;
    // setIsLoading = true;
    GlobalLoadingDialogController.openDialog();
    var packageConfirm = await _subscriberRepository.getConfirmPlanChange(
        subID, packageID, AppEndPoints.GETCONFIRMPLANCHANGE);
    if (packageConfirm != null) {
      packageConfirm as MessageModel;
      GlobalLoadingDialogController.closeDialog();
      GlobalFunctions.showDynamicDialog(
        title: "Confirm This",
        content: packageConfirm.message,
        confirmButtonTitle: "Confirm",
        cancelButtonTitle: "Cancel",
        onConfirmClick: () {
          Get.back();
          changePlan(subID, packageID);
        },
        onCancelClick: () {
          Get.back();
        },
      );

      return true;
    } else {}
    GlobalLoadingDialogController.closeDialog();
    return false;
  }

  Future<bool> changePlan(String subID, String packageID) async {
    // setIsError = false;
    // setIsLoading = true;
    GlobalLoadingDialogController.openDialog();
    var packageConfirm = await _subscriberRepository.getConfirmPlanChange(
        subID, packageID, AppEndPoints.CHANGEPLAN);
    if (packageConfirm != null) {
      packageConfirm as MessageModel;
      GlobalLoadingDialogController.closeDialog();
      GlobalFunctions.showToast(packageConfirm.message, true);
      getSubscriberDetails(subID, hideData: false);
      return true;
    } else {}
    GlobalLoadingDialogController.closeDialog();
    return false;
  }

  final SubscriberCreateRepository _subscriberCreateRepository =
      SubscriberCreateRepository();
  List<DropDownDataModel> oltDropDown = [];
  String? selectedOLT;
  String? selectedOLTID;

  List<DropDownDataModel> ponPortDropDown = [];
  String? selectedPonPort;
  String? selectedPonPortID;

  TextEditingController oltPosition = TextEditingController();

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

  void addPonPort() async {
    GlobalLoadingDialogController.openDialog();
    var res = await _subscriberRepository.addPonPort(
      subId: subscriberDetailsModel?.subId,
      oltId: selectedOLTID,
      ponPort: selectedPonPortID,
      position: oltPosition.text,
      packageId: subscriberDetailsModel?.packageId,
    );
    GlobalLoadingDialogController.closeDialog();
    if (res != null) {
      Get.back();
      clearPonPort();
      await getSubscriberDetails(
        subscriberDetailsModel?.subId ?? "",
      );
      GlobalFunctions.showToast(
        "${res['Message']}",
        true,
      );
    }
  }

  void removePonPort() async {
    GlobalLoadingDialogController.openDialog();
    clearPonPort();
    var res = await _subscriberRepository.removePonPort(
      subId: subscriberDetailsModel?.subId,
      subponportId: subscriberDetailsModel?.subPonPortId,
      onlAppId: subscriberDetailsModel?.onlAppId,
    );

    GlobalLoadingDialogController.closeDialog();
    if (res != null) {
      await getSubscriberDetails(
        subscriberDetailsModel?.subId ?? "",
      );
      GlobalFunctions.showToast(
        "${res['Message']}",
        true,
      );
    }
  }

  void clearPonPort() {
    selectedOLT = null;
    selectedOLTID = null;
    selectedPonPortID = null;
    selectedPonPort = null;
    oltPosition.text = "";
  }

  void ontMapUnmap() async {
    await GlobalLoadingDialogController.openDialog();
    var response = await _subscriberRepository.unMapDevice(
      subscriberDetailsModel?.deviceid,
      subscriberDetailsModel?.subId,
    );
    await GlobalLoadingDialogController.closeDialog();
    if (response != null) {
      GlobalFunctions.showToast(
        "${response["Message"]}",
        true,
      );
      selectedOltDropDown.value = null;
      getSubscriberDetails(subscriberDetailsModel?.subId ?? "");
    }
  }

  saveOnt() async {
    GlobalLoadingDialogController.openDialog();
    var response = await _subscriberRepository.mapDevice(
      selectedOltDropDown.value?.id ?? "",
      subscriberDetailsModel?.subId,
    );
    GlobalLoadingDialogController.closeDialog();
    if (response != null) {
      GlobalFunctions.showToast(
        "${response["Message"]}",
        true,
      );
      getSubscriberDetails(subscriberDetailsModel?.subId ?? "");
    }
  }

  getAvilaDevice() async {
    GlobalLoadingDialogController.openDialog();
    var response = await _subscriberRepository.getAvilDevice();
    GlobalLoadingDialogController.closeDialog();
    if (response != null) {
      oltAvailDropDown.value = [];
      response["list"].forEach(
        (e) {
          oltAvailDropDown.add(
            DropDownDataModel(
              value: e[1],
              id: e[0],
              key: e[0],
            ),
          );
        },
      );
      oltAvailDropDown.refresh();

      //oltAvailDropDown = response;
    }
  }

  void findRechargeDetails(
      SubscriberDetailsScreen widget, LocaleProvider localeProvider) async {
    await GlobalLoadingDialogController.openDialog();
    var res = await _subscriberRepository.getRechargeDetails(
      "${widget.applicant.subscriberid}",
    );
    await GlobalLoadingDialogController.closeDialog();
    GlobalFunctions.showDynamicDialog(
      title: 'Recharge',
      content:
          'Topup To: ${widget.applicant.username}\nTopup Amount : ${res?.rechAmount ?? ""}\nAccount Balance’ : ${res?.pbalance ?? ''} \nTopup Message : ${res?.topupmessage ?? ''}',
      confirmButtonTitle: 'Yes',
      cancelButtonTitle: 'No',
      onConfirmClick: () {
        Get.back();
        topUpUser(
          "${widget.applicant.subscriberid}",
        );
      },
      onCancelClick: () {
        Get.back();
      },
    );
  }
}
