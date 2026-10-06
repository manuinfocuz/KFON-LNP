import 'package:flutter/material.dart';
import 'package:kfon_lnp/widget/global_loader/global_loading_dialog_controller.dart';

import '../../data_model/subscriber/caf_type_data_model.dart';
import '../../repository/subscriber_repository.dart';

class SubFormSelectProvider with ChangeNotifier {
  final SubscriberRepository _subscriberRepository = SubscriberRepository();
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

  CafTypeDataModel? cafTypeDataModel;

  SubFormSelectProvider() {
    getCAFType();
  }

  Future<dynamic> getCAFType() async {
    setIsLoading = true;
    setIsError = false;
    var data = await _subscriberRepository.getCAFTypes();

    if (data != null) {
      cafTypeDataModel = data;
    } else {
      setIsError = true;
    }

    setIsLoading = false;
  }

  Future<dynamic> getSUBType(Caftype cafType) async {
    // bool isLoading = false;
    if (cafType.sType.isNotEmpty) {
      return;
    }
    // if (cafType.sType.isEmpty) {
    GlobalLoadingDialogController.openDialog();
    // isLoading = true;
    //}
    setIsError = false;
    var data = await _subscriberRepository.getSUBTypes("${cafType.caftypeid}");

    if (data != null) {
      cafType.sType = data.stypes;
    } else {}
    // if (isLoading) {
    GlobalLoadingDialogController.closeDialog();
    // }
    setIsLoading = false;
  }
}
