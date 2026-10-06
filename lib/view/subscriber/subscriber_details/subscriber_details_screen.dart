import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/view/subscriber/subscriber_details/sub_data_usage.dart';
import 'package:kfon_lnp/widget/utils_widgets/build_ui.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_button.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';
import 'package:provider/provider.dart';

import '../../../data_model/subscriber/active_subscriber_list.dart';
import '../../../providers/subscriber/sub_list_provider.dart';
import '../../../providers/subscriber/subscriber_details_provider.dart';
import '../../../utils/global_functions.dart';
import '../../../utils/routes.dart';
import '../../../widget/global_bottomsheet_widget.dart';
import '../../../widget/utils_widgets/globalAppBar.dart';
import '../../../widget/utils_widgets/value_picker.dart';

class SubscriberDetailsScreen extends StatefulWidget {
  final ActiveSubscriberSub applicant;

  const SubscriberDetailsScreen({super.key, required this.applicant});

  @override
  State<SubscriberDetailsScreen> createState() =>
      _SubscriberDetailsScreenState();
}

class _SubscriberDetailsScreenState extends State<SubscriberDetailsScreen>
    with SingleTickerProviderStateMixin {
  LocaleProvider localeProvider = Get.find();
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriberDetailsProvider(
          "${widget.applicant.subscriberid}", "${widget.applicant.username}"),
      builder: (context, provider) => Consumer<SubscriberDetailsProvider>(
        builder: (context, provider, snap) {
          Get.lazyReplace(
            () => provider,
          );
          return Scaffold(
            appBar: globalAppBar(
              "Subscriber Details",
            ),
            body: BuildUI(
              isLoad: provider.isLoading,
              isError: provider.isError,
              mainUi: localUI(provider),
            ),
          );
        },
      ),
    );
  }

  Widget localUI(SubscriberDetailsProvider provider) {
    if (provider.subscriberDetailsModel == null) {
      return Container();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await provider.getSubscriberDetails(null);
      },
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'Details'),
              Tab(text: 'Data Usage'),
              Tab(text: 'PON Port'),
              Tab(text: 'ONT'),
            ],
            controller: tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                subDetails(
                  provider,
                ),
                SubDataUsage(
                  userData: widget.applicant,
                ),
                ponPortDetails(
                  provider,
                ),
                ontDevice(provider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'N/A', // If value is empty, show 'N/A'
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  subDetails(SubscriberDetailsProvider provider) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Card(
              elevation: 8,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider
                                  .subscriberDetailsModel!.headings.length,
                              itemBuilder: (c, i) {
                                var heading = provider
                                    .subscriberDetailsModel!.headings[i];
                                var value =
                                    provider.subscriberDetailsModel!.subData[i];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('$heading:  '),
                                      Expanded(
                                        child: Text(
                                          value,
                                          style: appTextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: getTextColor(
                                                heading: heading,
                                                status: provider
                                                    .subscriberDetailsModel
                                                    ?.subStatus),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            if (provider.subscriberDetailsModel?.showTopUp ==
                                    false &&
                                provider.subscriberDetailsModel?.topUpMessage
                                        ?.isNotEmpty ==
                                    true)
                              Text(
                                "Note: ${provider.subscriberDetailsModel?.topUpMessage}",
                                style: appTextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900),
                              ),
                          ],
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     ElevatedButton.icon(
                    //       onPressed: () {
                    //         Get.lazyReplace(
                    //           () => provider,
                    //         );
                    //         localeProvider.navigate(
                    //           AppRoutes.subDataUsageScreen,
                    //           argument: widget.applicant,
                    //         );
                    //       },
                    //       icon: const Icon(Icons.data_usage),
                    //       label: const Text('Data Usage'),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    if (provider.subscriberDetailsModel?.showTopUp == true)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                            ),
                            onPressed: () {
                              provider.findRechargeDetails(
                                widget,
                                localeProvider,
                              );
                            },
                            icon: const Icon(
                              Icons.credit_card,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Top-up Subscriber Account',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if (provider.subscriberDetailsModel?.allowTopup ==
                              true)
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                              ),
                              onPressed: () async {
                                provider.packageListModel?.currentValue = "";
                                if (provider.packageListModel == null) {
                                  var data = await provider.getPackages(
                                    "${widget.applicant.subscriberid}",
                                  );
                                  if (data) {
                                    Get.bottomSheet(
                                      planBottomSheet(provider),
                                      backgroundColor: Colors.white,
                                      isScrollControlled: true,
                                      ignoreSafeArea: false,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(0),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  Get.bottomSheet(
                                    planBottomSheet(provider),
                                    backgroundColor: Colors.white,
                                    isScrollControlled: true,
                                    ignoreSafeArea: false,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(0),
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Change Plan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/dummy_user.png'),
                    // Replace with your actual image
                    fit: BoxFit.fitHeight,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> hilightData = ['username', 'subscriberid', 'subscriptionexpiry'];

  Color getTextColor({required String heading, String? status}) {
    final String trimmedHeading = heading.replaceAll(" ", '').toLowerCase();

    if (hilightData.contains(trimmedHeading)) {
      if (status?.toLowerCase() == 'active') {
        return Colors.green;
      } else {
        return Colors.redAccent;
      }
    }

    return Colors.black;
  }

  Widget planBottomSheet(SubscriberDetailsProvider provider) {
    final searchController = TextEditingController();
    return StatefulBuilder(
      builder: (context, set) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomSheet: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select new Package',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  isEditable: true,
                  lableText: "Search Package..",
                  controller: searchController,
                  onChangeText: (query) {
                    set(() {}); // Trigger UI rebuild
                  },
                  isRequired: true,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.packageListModel!.plans.length,
                    itemBuilder: (context, index) {
                      final plan = provider.packageListModel!.plans[index];
                      if (plan[1]
                              .toString()
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          plan[2].toString().toLowerCase().contains(
                                  searchController.text.toLowerCase()) &&
                              plan.length >= 3) {
                        return RadioListTile<String>(
                          title:
                              Text('${plan[1]} (\₹${plan[2]})-${plan[3]} Days'),
                          value: plan[0],
                          groupValue: provider.packageListModel!.currentValue,
                          onChanged: (value) {
                            provider.packageListModel!.currentValue = "$value";
                            provider.notify = "";
                            set(() {});
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
                CustomButton(
                  title: 'Change package',
                  onClickFunction: () {
                    if (provider.packageListModel!.currentValue.isEmpty) {
                      Fluttertoast.showToast(msg: "Please select a plan");
                      return;
                    }

                    ///api calls
                    Get.back();
                    provider.getUserConfirm("${widget.applicant.subscriberid}",
                        provider.packageListModel!.currentValue);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ponPortDetails(SubscriberDetailsProvider provider) {
    var isPonMapped = provider.subscriberDetailsModel?.pontPortMapped ?? false;

    return RefreshIndicator(
        backgroundColor: accentColor,
        color: Colors.white,
        elevation: 2,
        onRefresh: () async {
          await provider.getSubscriberDetails(null);
        },
        child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
                children: [
              Container(
                height: 120,
                child: Card(
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cable_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('PON Port',
                            style:
                                appTextStyle(color: Colors.white, fontSize: 15))
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 60, horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        if (isPonMapped)
                          Column(
                            children: [
                              Text(
                                "Pon Port Details",
                                style: appTextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.pink,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ...?provider.subscriberDetailsModel?.ponData
                                  ?.toJson()
                                  .entries
                                  .map((entry) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${entry.key}:  '),
                                      Expanded(
                                        child: Text(
                                          "${entry.value ?? "-"}",
                                          style: appTextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                              Column(
                                children: [
                                  Divider(
                                    color: Colors.grey,
                                    thickness: 2,
                                    indent: 20,
                                    endIndent: 20,
                                    height: 30, // Includes the line and padding
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: accentColor,
                                        ),
                                        onPressed: () {
                                          GlobalFunctions.showDynamicDialog(
                                            title: "Remove PON Port",
                                            content:
                                                "Are you sure, you want to remove the PON port.",
                                            confirmButtonTitle: "Yes",
                                            cancelButtonTitle: "No",
                                            onConfirmClick: () {
                                              Get.back();
                                              provider.removePonPort();
                                            },
                                            onCancelClick: () {
                                              Get.back();
                                            },
                                          );
                                        },
                                        label: const Text(
                                          'Remove PON Port',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("PON Port is not mapped"),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentColor,
                                ),
                                onPressed: () {
                                  localeProvider.navigate(
                                    AppRoutes.ponPortAddScreen,
                                    argument: provider,
                                  );
                                },
                                icon: const Icon(
                                  Icons.call_split_rounded,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Add PON Port',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }

  Widget ontDevice(SubscriberDetailsProvider provider) {
    bool isOntAvilable = provider.subscriberDetailsModel?.ontMapped == "true";
    var dataOlt = provider.subscriberDetailsModel?.ontData;

    return RefreshIndicator(
      backgroundColor: accentColor,
      color: Colors.white,
      onRefresh: () async {
        await provider.getSubscriberDetails(null);
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Card(
                color: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      Icon(
                        Icons.router,
                        color: Colors.white,
                      ),
                      Text('ONT Device',
                          style:
                              appTextStyle(color: Colors.white, fontSize: 15))
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     elevation: 4,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         children: [
            //           Text(
            //             'General Information',
            //             style: appTextStyle(
            //                 color: Colors.black,
            //                 fontSize: 19,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //           _buildDetailRow(
            //             'Device Provider',
            //             '${dataOlt?.deviceProvider}',
            //           ),
            //           _buildDetailRow(
            //             'Device Type',
            //             '${dataOlt?.deviceType}',
            //           ),
            //           _buildDetailRow(
            //             'Device Make',
            //             '${dataOlt?.deviceMake}',
            //           ),
            //           _buildDetailRow(
            //             'Device Category',
            //             '${dataOlt?.deviceCategory}',
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Card(
              elevation: 4,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsetsGeometry.all(12),
                      width: double.infinity,
                      // color: Colors.grey,
                      child: Text(
                        'General Information',
                        textAlign: TextAlign.center,
                        style: appTextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (isOntAvilable)
                      Column(
                        children: [
                          _buildDetailRow(
                            'Device Provider',
                            '${dataOlt?.deviceProvider}',
                          ),
                          _buildDetailRow(
                            'Device Type',
                            '${dataOlt?.deviceType}',
                          ),
                          _buildDetailRow(
                            'Device Make',
                            '${dataOlt?.deviceMake}',
                          ),
                          _buildDetailRow(
                            'Device Category',
                            '${dataOlt?.deviceCategory}',
                          ),
                          _buildDetailRow(
                            'Device Model',
                            '${dataOlt?.deviceModel}',
                          ),
                          _buildDetailRow(
                            'GPON Serial Number',
                            '${dataOlt?.gponSerialNumber}',
                          ),
                          _buildDetailRow(
                            'Device Serial Number',
                            '${dataOlt?.deviceSerialNumber}',
                          ), // Empty values can be replaced with 'N/A'
                          _buildDetailRow(
                            'Mac Address',
                            '${dataOlt?.macAddress}',
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!isOntAvilable)
                      Obx(
                        () => ValuePicker(
                          callback: () async {
                            await provider.getAvilaDevice();
                            Get.bottomSheet(
                              GlobalBottomSheetWidget(
                                onClick: (value) {
                                  provider.selectedOltDropDown.value = value;
                                },
                                listData: provider.oltAvailDropDown.toList(),
                                dropDownValue:
                                    provider.selectedOltDropDown.value?.id ??
                                        "",
                                title: 'Select Device',
                              ),
                              backgroundColor: Colors.transparent,
                            );
                          },
                          selectedValue:
                              provider.selectedOltDropDown.value?.value ??
                                  "Select Device",
                          hint: "",
                          canClick: true,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                      height: 30, // Includes the line and padding
                    ),
                    if (dataOlt?.deviceProvider?.toLowerCase() == "kfon" ||
                        !isOntAvilable)
                      CustomButton(
                        buttonColor: accentColor ??
                            (isOntAvilable ? Colors.red : Colors.green),
                        title: isOntAvilable ? "Remove ONT" : "Map ONT",
                        fontColor: Colors.white,
                        onClickFunction: () async {
                          if (isOntAvilable) {
                            GlobalFunctions.showDynamicDialog(
                              title: "Remove ONT",
                              content: "Are you sure want to remove ONT?",
                              confirmButtonTitle: "Yes",
                              cancelButtonTitle: "No",
                              onConfirmClick: () {
                                Get.back();
                                provider.ontMapUnmap();
                              },
                              onCancelClick: () {
                                Get.back();
                              },
                            );
                          } else {
                            if (provider.selectedOltDropDown.value != null) {
                              provider.saveOnt();
                            } else {
                              GlobalFunctions.showToast(
                                "Select device",
                                false,
                              );
                            }
                          }
                        },
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
