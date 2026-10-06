import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/providers/subscriber/sub_list_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/build_ui.dart';
import 'package:kfon_lnp/widget/utils_widgets/value_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../data_model/subscriber/active_subscriber_list.dart';
import '../../../widget/global_bottomsheet_widget.dart';
import '../../../widget/utils_widgets/custom_textfiled.dart';
import '../../../widget/utils_widgets/globalAppBar.dart';

class ActiveSubscriberScreen extends StatefulWidget {
  final int type;

  const ActiveSubscriberScreen({super.key, required this.type});

  @override
  State<ActiveSubscriberScreen> createState() => _ActiveSubscriberScreenState();
}

class _ActiveSubscriberScreenState extends State<ActiveSubscriberScreen> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubListProvider(type: widget.type),
      builder: (context, provider) => Consumer<SubListProvider>(
        builder: (context, provider, snap) {
          Get.lazyReplace(() => provider);
          return Scaffold(
            appBar: globalAppBar(widget.type == 1
                ? "List of My subscribers"
                : widget.type == 2
                    ? "Validity end in 7 days"
                    : ""),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: ValuePicker(
                    callback: () {
                      Get.bottomSheet(
                        GlobalBottomSheetWidget(
                          onClick: (value) async {
                            if (value.key == "{keeeee}") {
                              provider.selectedFilter = null;
                            } else {
                              provider.selectedFilter = value.key;
                            }
                            provider.textEditingController.clear();

                            await provider.getSubList();
                            setState(() {});
                          },
                          title: 'Search By Filter',
                          listData: provider.searchParams,
                          enableSearch: false,
                          dropDownValue: '${provider.selectedFilter}',
                        ),
                        backgroundColor: Colors.transparent,
                      );
                    },
                    selectedValue: provider.selectedFilter?.capitalizeFirst ??
                        "Search Filter",
                    canClick: true,
                    hint: "",
                  ),
                ),
                if (provider.selectedFilter != null)
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: CustomTextField(
                      lableText: 'Search here..',
                      isPassword: false,
                      onChangeText: (String value) {
                        timer?.cancel();
                        timer = Timer(const Duration(milliseconds: 1000), () {
                          provider.getSubList(
                            needLoad: false,
                          );
                        });
                      },
                      controller: provider.textEditingController,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                BuildUI(
                  isLoad: provider.isLoading,
                  isError: provider.isError,
                  mainUi: localUI(provider),
                  isEmpty: provider.activeSubscriberList?.subList.isEmpty,
                  noDataFoundTitle: "No Subscriber Found",
                  onRefreshClick: () {
                    provider.textEditingController.clear();
                    provider.getSubList();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget localUI(SubListProvider provider) {
    if (provider.activeSubscriberList != null) {
      return Expanded(
        child: RefreshIndicator(
          backgroundColor: accentColor,
          color: Colors.white,
          onRefresh: () async {
            if (provider.textEditingController.text.isEmpty) {
              provider.getSubList();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  'Total Records: ${provider.activeSubscriberList?.totalRecords ?? '-'}',
                  style: appTextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    controller: provider.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.activeSubscriberList!.subList.length,
                    itemBuilder: (c, i) {
                      var applicant = provider.activeSubscriberList?.subList[i];
                      return ApplicantItem(
                        applicant: applicant!,
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

class ApplicantItem extends StatelessWidget {
  final ActiveSubscriberSub applicant;

  ApplicantItem({super.key, required this.applicant});

  final LocaleProvider _localeProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isActive = applicant.subStatus?.toLowerCase() == "active";
    return Card(
      elevation: 4,
      shadowColor: primaryColor,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: InkWell(
        onTap: () {
          _localeProvider.navigate(
            AppRoutes.SUBSCRIBERDETAILSSCREEN,
            argument: applicant,
          );
        },
        child: Column(
          children: [
            Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isActive? Colors.green: dangerColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 5,
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${applicant.firstname}',
                        style: appTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      '${applicant.username}',
                      style: appTextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.tag,color: accentColor,),
                            Expanded(
                              child: Text(
                                'Subscriber ID:',
                                style: appTextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            child: Text(
                              '${applicant.subscriberid}',
                              style: appTextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.phone,color: Colors.green,),
                            Expanded(
                              child: Text(
                                'Mobile Number:',
                                style: appTextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          ' ${applicant.mobileno}',
                          style: appTextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email_outlined,color: Colors.blue,),
                          Text(
                            'Email:',
                            style: appTextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            child: Text(
                              '${applicant.email}',
                              style: appTextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month,color:colorGreen ,),
                          FittedBox(
                            child: Text(
                              'Registration Date:',
                              style: appTextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            child: Text(
                              ' ${applicant.registrationdate?.formatDate(
                                dateFormat: DateFormat('dd-MMM-yyyy')
                              )}',
                              style: appTextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green[100] : Colors.red[100],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              isActive ? Icons.check_circle : Icons.warning_amber,
                              color: isActive ? Colors.green : Colors.red,
                            ),
                            Text(
                              'Expiry Date:',
                              style: appTextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 2,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: FittedBox(
                                child: Text(
                                  ' ${applicant.expiry?.formatDate(
                                    dateFormat: DateFormat('dd-MMM-yyyy'),
                                  )}',
                                  style: appTextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.flag,
                              color: isActive ? Colors.green : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
