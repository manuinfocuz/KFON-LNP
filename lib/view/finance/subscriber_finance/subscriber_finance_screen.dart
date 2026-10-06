import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/value_picker.dart';
import 'package:most_advance_scroll/most_advance_scroll.dart';
import 'package:provider/provider.dart';

import '../../../providers/finance/subscriber_finance_provider.dart';

import '../../../widget/global_bottomsheet_widget.dart';
import '../../../widget/utils_widgets/globalAppBar.dart';
import '../invoice_screen/invoice_list_screen.dart';

class SubscriberFinanceScreen extends StatelessWidget {
  const SubscriberFinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriberFinanceProvider(),
      child: Consumer<SubscriberFinanceProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: globalAppBar(
              "Subscriber Finance",
            ),
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => ValuePicker(
                        callback: () {
                          Get.bottomSheet(
                            GlobalBottomSheetWidget(
                              onClick: (value) async {
                                provider.selectedSub.value = value;
                                provider.getSubscriberFin();
                              },
                              title: 'Select Subscriber',
                              listData: provider.subList.toList(),
                              enableSearch: true,
                              dropDownValue: '${provider.selectedSub.value?.id}',
                            ),
                            backgroundColor: Colors.transparent,
                          );
                        },
                        selectedValue: provider.selectedSub.value?.value ??
                            "Search Subscriber",
                        canClick: true,
                        hint: "",
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => provider.selectedSub.value == null
                            ? const Center(
                                child: Text("Please Select the Subscriber"),
                              )
                            : Column(
                                children: [
                                  if (provider
                                          .subFinData.value?.flist.isNotEmpty ??
                                      false)
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Total: ${provider.subFinData.value?.total ?? 0}",
                                            style: appTextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  (provider.subFinData.value?.flist.isEmpty ??
                                          true)
                                      ? const Center(
                                          child: Text("No any transactions"),
                                        )
                                      : Flexible(
                                          child: AdvanceListViewBuilder(
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            onPageEnd: (isAdvance, [bool? s]) {
                                              if (!isAdvance) {
                                                provider.getSubscriberFin(
                                                  isPaginate: true,
                                                );
                                              }
                                            },
                                            itemCount: provider.subFinData.value
                                                    ?.flist.length ??
                                                0,
                                            shrinkWrap: true,
                                            itemBuilder: (c, i) {
                                              var singleFinData = provider
                                                  .subFinData.value?.flist[i];
                                              var index = 0;
                                              return GestureDetector(
                                                onTap: () {},
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        ...?singleFinData?.map(
                                                          (e) {
                                                            index++;
                                                            return buildCompactRow(
                                                              "${provider.subFinData.value?.headings[index - 1]}",
                                                              "$e",
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
