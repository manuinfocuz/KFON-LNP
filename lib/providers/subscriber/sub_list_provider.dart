import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/models/form_type_model.dart';
import 'package:kfon_lnp/repository/subscriber_repository.dart';
import 'package:kfon_lnp/utils/global_functions.dart';

import '../../data_model/subscriber/active_subscriber_list.dart';
import '../../data_model/subscriber/kyc_application_list_model.dart';
import '../../widget/global_loader/global_loading_dialog_controller.dart';

class SubListProvider with ChangeNotifier {
  final SubscriberRepository _subscriberRepository = SubscriberRepository();
  int subPage = 1;

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

  bool isPageLoad = false;

  ActiveSubscriberList? activeSubscriberList;
  KycApplicationListModel? kycApplicationListModel;

  ScrollController scrollController = ScrollController();

  List<DropDownDataModel> searchParams = [];
  int type = 0;

  final TextEditingController textEditingController = TextEditingController();
  String? selectedFilter;

  SubListProvider({int type = 1}) {
    scrollController.addListener(_scrollListener);

    Future.delayed(const Duration(milliseconds: 10), () {
      this.type = type;
      if (type == 1 || type == 2) {
        getSubList();
      } else if (type == 11) {
        getKYCList(1, 1);
      }
      // scrollController.addListener(
      //   GlobalFunctions.scrollListener(scrollController, scrollEnd: () {}),
      // );
    });
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      subPage += 1;
      getSubList(isPagination: true);
    }
  }

  Future<dynamic> getSubList(
      {bool isPagination = false,
      String? searchValue,
      String? params,
      bool needLoad = true}) async {
    setIsError = false;
    if (!isPagination) {
      subPage = 1;
      setIsLoading = true;
      if (needLoad) {
        GlobalLoadingDialogController.openDialog();
      }
    }

    var listData = await _subscriberRepository.getActiveSubscriber(
      subPage,
      textEditingController.text,
      textEditingController.text.isNotEmpty ? selectedFilter : null,
      type,
    );
    if (listData != null) {
      if (isPagination) {
        listData as ActiveSubscriberList;
        activeSubscriberList?.subList.addAll(listData.subList ?? []);
      } else {
        activeSubscriberList = listData;
      }
      searchParams = [];
      for (var i = 0;
          i < (activeSubscriberList?.searchParams.length ?? 0);
          i++) {
        String datas = "${activeSubscriberList?.searchParams[i]}";

        searchParams.add(DropDownDataModel(
          value: "${datas.capitalizeFirst}",
          key: datas,
          id: datas,
        ));
      }

      searchParams.insert(
        0,
        DropDownDataModel(
          value: "No Filter",
          key: "{keeeee}",
          id: "datas",
        ),
      );
      setIsError = false;
      setIsLoading = false;
    } else {
      if (!isPagination) {
        setIsError = true;
      }

      setIsLoading = false;
    }
    if (!isPagination && needLoad) {
      GlobalLoadingDialogController.closeDialog();
    }
  }

  Future<dynamic> getKYCList(int page, int selectedFilter,
      {bool isPagination = false}) async {
    if (isPagination) {
      isPageLoad = true;
      setIsLoading = false;
    } else {
      setIsError = false;
      setIsLoading = true;

      // GlobalLoadingDialogController.openDialog();
    }

    var listData =
        await _subscriberRepository.getKYCList(page, "${selectedFilter}");
    if (listData != null) {
      listData as KycApplicationListModel;
      if (isPagination) {
        kycApplicationListModel?.klist?.addAll(listData.klist ?? []);
      } else {
        kycApplicationListModel = listData;
      }

      isPageLoad = false;
      setIsError = false;
      setIsLoading = false;
      if (listData.klist?.length != 0) {
        return listData;
      }
      return;
    } else {
      if (!isPagination) {}
      setIsError = true;
      setIsLoading = false;
    }
    // if(!isPagination){
    //   GlobalLoadingDialogController.closeDialog();
    // }
  }

  List<ActiveSubscriberSub> doSearch(String text) {
    if (activeSubscriberList == null) {
      return [];
    } else {
      List<ActiveSubscriberSub> finalData = [];
      for (var element in activeSubscriberList!.subList) {
        if ("${element.firstname}".toLowerCase().contains(text) ||
                "${element.username}".toLowerCase().contains(text)
            /*||
            "${element.packagename}".toLowerCase().contains(text) ||
            "${element.email}".toLowerCase().contains(text) ||
            "${element.mobileno}".toLowerCase().contains(text)*/
            ) {
          print("${element.firstname} $text");
          finalData.add(element);
        }
      }
      activeSubscriberList?.tempList = finalData;
      notifyListeners();
      return finalData;
    }
  }
}
