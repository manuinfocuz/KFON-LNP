import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/models/form_type_model.dart';

import '../../data_model/sub_finance/sub_fin_data_mode.dart';
import '../../data_model/sub_finance/subscriber_list_data_model.dart';
import '../../repository/subscriber_finance_repository.dart';
import '../utlis/my_notifier.dart';

class SubscriberFinanceProvider extends ChangeNotifier with MyNotifier {
  SubscriberFinanceRepository subscriberFinanceRepository =
      SubscriberFinanceRepository();

  SubscriberFinanceProvider() {
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        getSubscriberList();
      },
    );
  }

  RxList<DropDownDataModel> subList = RxList();
  Rxn<DropDownDataModel> selectedSub = Rxn();
  int page = 1;
  Rxn<SubsFinDataModel> subFinData = Rxn();

  getSubscriberList() async {
    var data = await subscriberFinanceRepository.getSubscriberList();

    if (data != null) {
      subList.clear();
      for (var e in data) {
        subList.add(
          DropDownDataModel(
            value: e.username ?? "",
            key: e.subscriberid ?? "",
            id: e.subscriberid ?? "",
          ),
        );
      }
    }
  }

  void getSubscriberFin({bool isPaginate = false}) async {
    if (isPaginate) {
      page += 1;
    } else {
      openLoader();
      subFinData.value = null;
      page = 1;
    }

    var data = await subscriberFinanceRepository.getSubscriberFin(
      "${selectedSub.value?.id}",
      "$page",
    );
    if (!isPaginate) {
      closeLoader();
    }

    if (data != null) {
      if (isPaginate) {
        subFinData.value?.flist.addAll(data.flist);
      } else {
        subFinData.value = data;
      }
      subFinData.refresh();
    }
  }
}
