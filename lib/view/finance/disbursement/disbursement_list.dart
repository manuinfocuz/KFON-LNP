import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/widget/global_bottomsheet_widget.dart';
import 'package:kfon_lnp/widget/utils_widgets/value_picker.dart';
import 'package:most_advance_scroll/most_advance_scroll.dart';
import 'package:provider/provider.dart';

import '../../../providers/finance/disbursement_provider.dart';
import '../../../widget/utils_widgets/globalAppBar.dart';

class DisbursementList extends StatefulWidget {
  const DisbursementList({super.key});

  @override
  State<DisbursementList> createState() => _DisbursementListState();
}

class _DisbursementListState extends State<DisbursementList> {
  @override
  Widget build(BuildContext context) {
    // Get.back();
    return ChangeNotifierProvider(
      create: (_) => DisbursementProvider(),
      builder: (context, provider) => Consumer<DisbursementProvider>(
        builder: (BuildContext context, DisbursementProvider provider,
            Widget? child) {
          return Scaffold(
            appBar: globalAppBar(
              "Disbursement",
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: Obx(
                    () => ValuePicker(
                      callback: () {
                        Get.bottomSheet(
                          GlobalBottomSheetWidget(
                              onClick: (value) async {
                                provider.selectedMonth.value = value;
                                provider.getDisbursementList(
                                  isPageination: false,
                                );
                              },
                              title: 'Select the Month',
                              listData: provider.listOfMonth.toList(),
                              enableSearch: true,
                              dropDownValue:
                                  provider.selectedMonth.value?.id ?? "",
                              searchPlaceHolder: 'Search Month'),
                          backgroundColor: Colors.transparent,
                        );
                      },
                      selectedValue:
                          provider.selectedMonth.value?.id ?? "Search Month",
                      canClick: true,
                      hint: "Search Month",
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => provider.disbursementList.value?.dlist.isEmpty ??
                            false
                        ? const Center(
                            child: Text("No data available in table"),
                          )
                        : AdvanceListViewBuilder(
                            onPageEnd: (ad, [bool? s]) {
                              if (!ad) {
                                provider.getDisbursementList(
                                  isPageination: true,
                                );
                              }
                            },
                            itemCount:
                                provider.disbursementList.value?.dlist.length ??
                                    0,
                            itemBuilder: (context, index) {
                              var itemSingle =
                                  provider.disbursementList.value?.dlist[index];

                              return TransactionCard(
                                date: itemSingle?[0] ?? '',
                                cause: itemSingle?[1] ?? "",
                                amount: double.tryParse(
                                        itemSingle?[2].toString() ?? "") ??
                                    0,
                                onTap: () {
                                  provider.getRevDetails(
                                    date: itemSingle?[0],
                                    type: itemSingle?[1],
                                  );
                                },
                              );
                            },
                          ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String date;
  final String cause;
  final double amount;
  final VoidCallback onTap;

  const TransactionCard({
    super.key,
    required this.date,
    required this.cause,
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine amount color based on its value
    Color amountColor = amount >= 0
        ? const Color(0xFF22543D)
        : Colors.red[600]!; // Green-800 or Red-600

    return Card(
      elevation: 4.0, // Shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: InkWell(
        // Provides the ripple effect and tap functionality
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Row
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFE2E8F0), // Gray-200
                        width: 1.0,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      bottom: 8.0), // Padding above the border
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF718096), // Gray-500
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3748), // Gray-800
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Cause Row
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cause',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF718096), // Gray-500
                      ),
                    ),
                    Expanded(
                      // Use Expanded to allow text to wrap if long
                      child: Text(
                        cause,
                        textAlign: TextAlign.right, // Align text to the right
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF4A5568), // Gray-700
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Amount Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF718096), // Gray-500
                    ),
                  ),
                  Text(
                    '₹${amount.toStringAsFixed(2)}', // Format as currency
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: amountColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
