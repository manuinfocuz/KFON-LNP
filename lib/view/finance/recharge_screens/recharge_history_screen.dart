import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/providers/finance/recharge_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/build_ui.dart';
import 'package:provider/provider.dart';

import '../../../widget/utils_widgets/globalAppBar.dart';

class RechargeHistoryScreen extends StatefulWidget {
  const RechargeHistoryScreen({super.key});

  @override
  State<RechargeHistoryScreen> createState() => _RechargeHistoryScreenState();
}

class _RechargeHistoryScreenState extends State<RechargeHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  var page = 1;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          RechargeProvider provider = Get.find();

          var data =
              await provider.getRechargeHistory(page + 1, isPagination: true);

          if (data != null) {
            page += 1;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RechargeProvider(type: 1),
      builder: (context, provider) => Consumer<RechargeProvider>(
        builder: (context, provider, snap) {
          Get.lazyReplace(() => provider);
          return Scaffold(
            appBar: globalAppBar(
              "Previous Transactions",
            ),
            body: BuildUI(
              isLoad: provider.isLoading,
              isError: provider.isError,
              isEmpty: provider.rechargeHistoryModel?.tlist?.isEmpty ?? false,
              mainUi: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    page = 1;
                    provider.getRechargeHistory(page);
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                          provider.rechargeHistoryModel?.tlist?.length ?? 0,
                          itemBuilder: (context, index) {
                            var singleItem =
                            provider.rechargeHistoryModel?.tlist?[index];
                            bool isPending =
                                singleItem?.status?.toLowerCase() == "pending";

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int indexs = 0;
                                indexs <
                                    (provider.rechargeHistoryModel?.headings
                                        ?.length ??
                                        0);
                                indexs++)
                                 Builder(

                                    builder: (context) {
                                      final bool isErrorNo = provider
                                          .rechargeHistoryModel
                                          ?.headings?[indexs] ==
                                          'Response Message' &&
                                          isPending;
                                      return Row(
                                        children: [
                                          Text(
                                            "${provider.rechargeHistoryModel?.headings?[indexs]}: ",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    isErrorNo
                                                        ? 'Transaction Interrupted'
                                                        : "${getValueFromIndex(singleItem?.jsonData, indexs)}",
                                                    style:  TextStyle(
                                                        fontSize: 13,
                                                        color: isErrorNo
                                                            ? Colors.red
                                                            : null,
                                                        fontWeight: FontWeight.normal),

                                                  ),
                                                ),
                                                if ("${getValueFromIndex(singleItem?.jsonData, indexs)}"
                                                    .toLowerCase() ==
                                                    "pending")
                                                  InkWell(
                                                    onTap: () {
                                                      page = 1;
                                                      provider.checkStatusById(
                                                        "${singleItem?.ordernumber}",
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.refresh,
                                                      color: primaryColor,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  ),



                                const Divider(),
                                if ((index + 1) ==
                                    provider.rechargeHistoryModel?.tlist
                                        ?.length &&
                                    provider.isPageLoad)
                                  const Center(
                                      child: CircularProgressIndicator()),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

getValueFromIndex(Map<String, dynamic>? data, int index) {
  var dataLast = "";
  var i = 0;
  data?.forEach((key, value) {
    if (i == index) {
      dataLast = value ?? "";
    }
    i++;
  });
  return dataLast;
}
