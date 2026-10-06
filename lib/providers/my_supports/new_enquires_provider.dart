import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:kfon_lnp/models/form_type_model.dart';

import '../../data_model/my_sup/sub_enq_details_data_model.dart';
import '../../data_model/my_sup/sub_enq_list_data_model.dart';
import '../../repository/new_enquires_repository.dart';
import '../../utils/global_functions.dart';
import '../../utils/routes.dart';
import '../utlis/my_notifier.dart';

class NewEnquiresProvider extends ChangeNotifier with MyNotifier {
  NewEnquiresRepository newEnquiresRepository = NewEnquiresRepository();
  int pageEnqList = 1;
  Rxn<SubEnqListDataModel> subEnqListDataModel = Rxn<SubEnqListDataModel>();
  Rxn<SubEnqDetailsDataModel> subEnqDetailsDataModel = Rxn();
  TextEditingController remarkController = TextEditingController();
  RxList<DropDownDataModel> statusList = RxList();
  Rxn<DropDownDataModel> selectedStatus = Rxn<DropDownDataModel>();

  final TextEditingController textEditingController = TextEditingController();
  String? selectedFilter;

  NewEnquiresProvider() {
    Future.delayed(
      const Duration(milliseconds: 10),
      () async {
        await getEnqList();
        await getStatusList();
      },
    );
  }

  getEnqList({bool isPaginate = false, bool needLoad = true}) async {
    if (isPaginate) {
      pageEnqList += 1;
    } else {
      if (needLoad) {
        openLoader();
      }

      pageEnqList = 1;
    }

    var response = await newEnquiresRepository.getEnqList(
      "$pageEnqList",
      selectedFilter,
      textEditingController.text,
    );
    if (!isPaginate && needLoad) {
      closeLoader();
    }

    if (response != null) {
      if (isPaginate) {
        subEnqListDataModel.value?.enqlist.addAll(response.enqlist);
      } else {
        if (subEnqListDataModel.value != null) {
          response.searchParams = subEnqListDataModel.value!.searchParams;
        }
        subEnqListDataModel.value = response;
      }

      subEnqListDataModel.refresh();
    }
  }

  void getDetailsView(String id) async {
    openLoader();

    var response = await newEnquiresRepository.getSingleitemView(
      id,
    );

    closeLoader();
    if (response != null) {
      subEnqDetailsDataModel.value = response;
      remarkController.text = response.enquiry[0].remarks ?? "";

      selectedStatus.value = statusList
          .where((e) =>
              e.value.toLowerCase() ==
              response.enquiry[0].status?.toLowerCase())
          .firstOrNull;

   //   selectedStatus.value ??= statusList.first;

      navigate(
        AppRoutes.subEnquiryDetailsScreen,
        argument: this,
      );
    }
  }

  getStatusList() async {
    openLoader();
    var response = await newEnquiresRepository.getAllStatusList();
    closeLoader();

    if (response != null) {
      response['sList'].forEach(
        (element) {
          var data = "${element["status"]}";
          statusList.add(
            DropDownDataModel(
              value: data,
              key: data,
              id: data,
            ),
          );
        },
      );
    }
  }

  updateEnqStatus() async {
    if (remarkController.text.isEmpty) {
      GlobalFunctions.showToast(
        "Remark  cannot be empty",
        false,
      );
      return;
    }
    var id = subEnqDetailsDataModel.value?.enquiry[0].id;

    if (id == null) {
      GlobalFunctions.showToast(
        "Enquiry  Invalid",
        false,
      );
    }
    openLoader();
    var response = await newEnquiresRepository.updateEnqStatus(
      id ?? "",
      selectedStatus.value?.value ?? "",
      remarkController.text,
    );
    closeLoader();
    if (response != null) {
      GlobalFunctions.showToast(
        "${response['Message']}",
        true,
      );
      subEnqListDataModel.value?.enqlist.where((e) => e.id == id).first.status =
          selectedStatus.value?.value ?? "";
      subEnqListDataModel.refresh();
      backScreen();
    }
  }
}
