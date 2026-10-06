import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:kfon_lnp/models/form_type_model.dart';
import 'package:kfon_lnp/utils/routes.dart';

import '../../data_model/sub_finance/disbursement_data_model.dart';

import '../../data_model/sub_finance/disbursement_details_data_model.dart';
import '../../repository/disbursement_repository.dart';

import '../utlis/my_notifier.dart';

class DisbursementProvider extends ChangeNotifier with MyNotifier {
  DisbursementRepository disbursementRepository = DisbursementRepository();
  int pageNo = 1;
  Rxn<DisbursementDataModel> disbursementList = Rxn<DisbursementDataModel>();

  RxList<DropDownDataModel> listOfMonth = RxList();

  Rxn<DropDownDataModel> selectedMonth = Rxn();

  Rxn<DisbursementDetailsDataModel> disbursementDetailsData = Rxn();

  String? lastClickedDate;
  int detailsPageNo = 1;

  DisbursementProvider() {
    Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        await getDisbursementList();
        await getMonthList();
      },
    );
  }

  getDisbursementList({bool isPageination = false}) async {
    if (!isPageination) {
      openLoader();
      pageNo = 1;
    } else {
      pageNo += 1;
    }

    var response = await disbursementRepository.getDisbursementList(
      pageNo: '$pageNo',
      dMonth: selectedMonth.value?.value,
    );

    if (!isPageination) {
      closeLoader();
    }
    if (response != null) {
      if (isPageination) {
        disbursementList.value?.dlist.addAll(response.dlist);
      } else {
        disbursementList.value = response;
      }
      disbursementList.refresh();
    }
  }

  getMonthList() async {
    openLoader();
    var reponse = await disbursementRepository.getMonthList();
    closeLoader();
    if (reponse != null) {
      for (var e in reponse.mlist) {
        listOfMonth.add(
          DropDownDataModel(
            value: e.dmonth ?? "",
            key: e.dmonth ?? "",
            id: e.dmonth ?? "",
          ),
        );
      }
      listOfMonth.refresh();
    }
  }

  int cause=1;

  void getRevDetails({String? date, String? type, bool isPageination = false}) async {

    switch (type) {
      case 'Daily Disbursement-LNP':
        cause= 1;
        break;
      case 'Daily Disbursement-LNP-Online':
        cause=2;
        break;
      case 'Daily Disbursement-PB-LNP':
        cause= 3;
        break;
      case 'Daily Disbursement-PB-LNP-Online':
        cause= 4;
        break;
      default:
        break;
    }


    if (!isPageination) {
      openLoader();
      detailsPageNo = 1;
    } else {
      detailsPageNo += 1;
    }
    if (date != null) {
      lastClickedDate = date;
    }

    var response = await disbursementRepository.getRevShare(
      date: lastClickedDate ?? "",
      pageNo: "$detailsPageNo",
      cause: cause,
    );
    if (!isPageination) {
      closeLoader();
    }

    if (response != null) {
      if (isPageination) {
        disbursementDetailsData.value?.rlist.addAll(response.rlist);
      } else {
        detailsPageNo = 1;
        disbursementDetailsData.value = response;
        navigate(
          AppRoutes.disbursementDetailsScreen,
          argument: this,
        );
      }
      disbursementDetailsData.refresh();
    }
  }
}
