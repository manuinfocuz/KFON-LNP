import 'package:flutter/material.dart';
import 'package:kfon_lnp/data_model/message_model.dart';
import 'package:kfon_lnp/repository/recharge_repository.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/widget/global_loader/global_loading_dialog_controller.dart';

import '../../data_model/recharge/payment_gateway_details.dart';
import '../../data_model/recharge/recharge_history_model.dart';

class RechargeProvider with ChangeNotifier {
  final RechargeRepository _rechargeRepository = RechargeRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isPageLoad = false;

  bool _isError = false;

  bool get isError => _isError;

  set setIsError(bool value) {
    _isError = value;
    notifyListeners();
  }

  PaymentGatewayDetails? paymentGatewayDetails;
  RechargeHistoryModel? rechargeHistoryModel;

  RechargeProvider({int type = 0}) {
    if (type == 1) {
      Future.delayed(const Duration(milliseconds: 100), () {
        getRechargeHistory(1);
      });
    }
  }

  Future<RechargeHistoryModel?> getRechargeHistory(int page,
      {bool isPagination = false}) async {
    if (isPagination) {
      isPageLoad = true;
      setIsLoading = false;
    } else {
      setIsLoading = true;
      setIsError = false;
    }

    var data = await _rechargeRepository.getRechargeHistory(page);

    if (data != null) {
      if (isPagination) {
        isPageLoad = false;
        data as RechargeHistoryModel;
        rechargeHistoryModel?.tlist?.addAll(data.tlist ?? []);
        setIsLoading = false;
      } else {
        rechargeHistoryModel = data;
      }

      setIsLoading = false;
      return data;
    } else {
      setIsError = true;
    }
    setIsLoading = false;
    return null;
  }

  Future<dynamic> getPaymentGateway(int type, String amount) async {
    GlobalLoadingDialogController.openDialog();
    paymentGatewayDetails = null;
    var data = await _rechargeRepository.getPaymentGatewayDetails(type, amount);

    if (data != null) {
      paymentGatewayDetails = data;
      GlobalLoadingDialogController.closeDialog();
      notifyListeners();
      return data;
    } else {}
    GlobalLoadingDialogController.closeDialog();
    return null;
  }

  Future<dynamic> checkStatusById(String orderNumber) async {
    GlobalLoadingDialogController.openDialog();
    paymentGatewayDetails = null;
    var data = await _rechargeRepository.checkStatusById(orderNumber);

    if (data != null) {
      data as MessageModel;
      GlobalFunctions.showToast(data.message, true);
      getRechargeHistory(1);
    } else {}
    GlobalLoadingDialogController.closeDialog();
    return null;
  }
}
