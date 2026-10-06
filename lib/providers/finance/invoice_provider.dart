import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:kfon_lnp/utils/routes.dart';

import '../../data_model/recharge/invoice_list_data_model.dart';
import '../../repository/invoice_repository.dart';
import '../../utils/global_functions.dart';
import '../utlis/my_notifier.dart';

class InvoiceProvider extends ChangeNotifier with MyNotifier {
  InvoiceRepository invoiceRepository = InvoiceRepository();
  int invoicePage = 1;
  Rxn<InvoiceListDataModel> invoiceListDataModel = Rxn<InvoiceListDataModel>();

  InvoiceProvider({
    int type = 2,
  }) {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        getInvoiceList();
      },
    );
  }

  Future getInvoiceList({bool isPaginate = false}) async {
    if (isPaginate) {
      invoicePage += 1;
    } else {
      openLoader();
      invoicePage = 1;
    }
    var data = await invoiceRepository.getInvoiceList(
      pageNum: "$invoicePage",
    );
    if (!isPaginate) {
      closeLoader();
    }

    if (data != null) {
      if (isPaginate) {
        invoiceListDataModel.value?.invlist.addAll(data.invlist);
      } else {
        invoiceListDataModel.value = data;
      }
      invoiceListDataModel.refresh();
    }
  }

  void getInvoiceUrl(String? slno) async {
    openLoader();
    var data = await invoiceRepository.getInvoiceUrl(
      slno: "$slno",
    );

    if (data != null) {
      var pdfFile = await downloadPDFByUrl(pdfUrl: data);

      closeLoader();

      if (pdfFile == null) {
        return;
      }
      navigate(
        AppRoutes.pdfViewScreen,
        argument: pdfFile,
      );
    } else {
      closeLoader();
    }
  }
}
