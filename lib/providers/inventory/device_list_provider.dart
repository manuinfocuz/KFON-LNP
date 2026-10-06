import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:kfon_lnp/models/form_type_model.dart';

import '../../data_model/inventory/device_list_data_model.dart';
import '../../repository/device_repository.dart';
import '../utlis/my_notifier.dart';

class DeviceListProvider extends ChangeNotifier with MyNotifier {
  DeviceRepository deviceRepository = DeviceRepository();
  int page = 1;
  Rxn<DeviceListDataModel> deviceListData = Rxn<DeviceListDataModel>();

  final TextEditingController textEditingController = TextEditingController();
  DropDownDataModel? selectedFilter;

  DeviceListProvider() {
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        getDeviceList();
      },
    );
  }

  getDeviceList({bool isPagination = false, bool fromSearch = false}) async {
    if (!isPagination) {
      if (!fromSearch) {
        openLoader();
      }

      page = 1;
    } else {
      page += 1;
    }
    var response = await deviceRepository.getDeviceList(
      pageNo: '$page',
      filter: selectedFilter?.id,
      searchValue: textEditingController.text,
    );
    if (!isPagination) {
      if (!fromSearch) {
        closeLoader();
      }
    }
    if (response != null) {
      if (isPagination) {
        deviceListData.value?.list.addAll(response.list ?? []);
      } else {
        deviceListData.value = response;
      }
      deviceListData.refresh();
    }
  }
}
