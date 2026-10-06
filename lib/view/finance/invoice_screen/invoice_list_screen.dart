import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kfon_lnp/providers/finance/invoice_provider.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_button.dart';
import 'package:most_advance_scroll/most_advance_scroll.dart';
import 'package:provider/provider.dart';

import '../../../widget/utils_widgets/globalAppBar.dart';

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InvoiceProvider(),
      builder: (context, provider) => Consumer<InvoiceProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            appBar: globalAppBar(
              "Invoice List",
            ),
            body: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => (provider
                                .invoiceListDataModel.value?.invlist.isEmpty ??
                            true)
                        ? const Center(
                            child: Text("No any data found"),
                          )
                        : AdvanceListViewBuilder(
                            onRefresh: () {
                              provider.getInvoiceList();
                            },
                            scrollListener:
                                (ScrollNotification notification) {},
                            onPageEnd: (bool isAdvance, [bool? s]) async {
                              if (!isAdvance) {
                                await provider.getInvoiceList(
                                  isPaginate: true,
                                );
                              }
                            },
                            itemCount: provider.invoiceListDataModel.value
                                    ?.invlist.length ??
                                0,
                            itemBuilder: (c, index) {
                              var singleInvoiceData = provider
                                  .invoiceListDataModel.value?.invlist[index];
                              var i = 0;
                              return Card(
                                elevation: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ExpansionTile(
                                      visualDensity: const VisualDensity(
                                        horizontal: -4,
                                      ),
                                      dense: false,
                                      title: ListTile(
                                        visualDensity: const VisualDensity(
                                          horizontal: -4,
                                        ),
                                        dense: false,
                                        leading: Text(
                                          singleInvoiceData?[0] ?? "",
                                        ),
                                        title: Column(
                                          children: [
                                            Text(
                                              singleInvoiceData?[9] ?? "",
                                              style: appTextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              singleInvoiceData?[1] ?? "",
                                              style: TextStyle(
                                                color: singleInvoiceData?[1] ==
                                                        "Pending"
                                                    ? Colors.red
                                                    : (singleInvoiceData?[1] ==
                                                            "Requested Clarification"
                                                        ? Colors.orange
                                                        : Colors.blue),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // trailing: Text(
                                        //   singleInvoiceData?[1] ?? "",
                                        // ),
                                      ),
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Column(
                                            children: [
                                              ...?provider.invoiceListDataModel
                                                  .value?.headings
                                                  .map((e) {
                                                i++;
                                                return buildCompactRow(
                                                  e ?? "",
                                                  singleInvoiceData?[i - 1] ??
                                                      "",
                                                );
                                              }),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                ),
                                                child: CustomButton(
                                                  title: "View",
                                                  onClickFunction: () {
                                                    provider.getInvoiceUrl(
                                                      singleInvoiceData?.last,
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget buildCompactRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
