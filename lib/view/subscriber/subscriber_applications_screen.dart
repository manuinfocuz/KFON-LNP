import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/providers/subscriber/sub_list_provider.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/widget/utils_widgets/globalAppBar.dart';
import 'package:provider/provider.dart';

import '../../utils/style.dart';
import '../../widget/utils_widgets/build_ui.dart';
import '../finance/recharge_screens/recharge_history_screen.dart';

class SubscriberApplicationScreen extends StatefulWidget {
  const SubscriberApplicationScreen({super.key});

  @override
  State<SubscriberApplicationScreen> createState() =>
      _SubscriberApplicationScreenState();
}

class _SubscriberApplicationScreenState
    extends State<SubscriberApplicationScreen> {
  final LocaleProvider _localeProvider = Get.find();
  final ScrollController _scrollController = ScrollController();
  var page = 1;
  int selectedFilter = 1;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          SubListProvider provider = Get.find();

          var data = await provider.getKYCList(
            page + 1,
            isPagination: true,
            selectedFilter,
          );

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
      create: (_) => SubListProvider(type: 11),
      builder: (context, provider) =>
          Consumer<SubListProvider>(builder: (context, provider, snap) {
        Get.lazyReplace(() => provider);
        return Scaffold(
          appBar: globalAppBar(
            "Subscriber Application Worklist",
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ActionFilter(
                  selectedFilter: selectedFilter,
                  callBack: (int value) async {
                    page = 1;
                    selectedFilter = value + 1;
                    await provider.getKYCList(page, selectedFilter);
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  'Total Records: ${provider.kycApplicationListModel?.totalRecords ?? '-'}',
                  style: appTextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: BuildUI(
                  isLoad: provider.isLoading,
                  isError: provider.isError,
                  isEmpty:
                      provider.kycApplicationListModel?.klist?.isEmpty ?? false,
                  mainUi: Scaffold(
                    body: SafeArea(
                      child: RefreshIndicator(
                        backgroundColor: accentColor,
                        color: Colors.white,
                        onRefresh: () async {
                          page = 1;
                          await provider.getKYCList(page, selectedFilter);
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: provider
                                    .kycApplicationListModel?.klist?.length ??
                                0,
                            itemBuilder: (context, index) {
                              var singleItem = provider
                                  .kycApplicationListModel?.klist?[index];
                              return InkWell(
                                onTap:
                                    selectedFilter == 3 || selectedFilter == 4
                                        ? () {
                                            _localeProvider.navigate(
                                              AppRoutes
                                                  .viewSubmittedApplicationScreen,
                                              argument: [
                                                singleItem?.id,
                                                selectedFilter
                                              ],
                                            );
                                          }
                                        : null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int indexs = 0;
                                        indexs <
                                            (provider.kycApplicationListModel
                                                    ?.headings?.length ??
                                                0);
                                        indexs++)
                                      Row(
                                        children: [
                                          Text(
                                            "${provider.kycApplicationListModel?.headings?[indexs]}: ",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${getValueFromIndex(singleItem?.rawData, indexs)}",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    Divider(),
                                    if ((index + 1) ==
                                            provider.kycApplicationListModel
                                                ?.klist?.length &&
                                        provider.isPageLoad)
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ActionFilter extends StatefulWidget {
  final Function(int value) callBack;
  final int selectedFilter;

  const ActionFilter(
      {super.key, required this.callBack, required this.selectedFilter});

  @override
  _ActionFilterState createState() => _ActionFilterState();
}

class _ActionFilterState extends State<ActionFilter> {
  List<List<dynamic>> filters = [
    ['Pending Action', "1"],
    ['Rejected KYC', "2"],
    ['Submitted KYC', "3"],
    ['Closed KYC', "4"],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PopupMenuButton<String>(
          icon: Row(
            children: [
              const Icon(Icons.filter_list),
              Text(
                filters[widget.selectedFilter - 1][0],
              ),
            ],
          ),
          onSelected: (filter) {
            setState(() {
              widget.callBack(int.parse(filter) - 1);
              setState(() {});
            });
          },
          itemBuilder: (BuildContext context) {
            return filters.map((List<dynamic> filter) {
              return PopupMenuItem<String>(
                value: filter[1],
                child: Text(
                  filter[0],
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
