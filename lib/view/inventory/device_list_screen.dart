import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kfon_lnp/providers/inventory/device_list_provider.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:most_advance_scroll/most_advance_scroll.dart';
import 'package:provider/provider.dart';

import '../../models/form_type_model.dart';
import '../../widget/global_bottomsheet_widget.dart';
import '../../widget/utils_widgets/custom_textfiled.dart';
import '../../widget/utils_widgets/globalAppBar.dart';
import '../../widget/utils_widgets/value_picker.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  // List<String> data = [
  //   "OLT",
  //   "United Telecoms Limited",
  //   "GPON-4-PON Port-OLT",
  //   "GPON-4 PON PORT",
  //   "STARLINK",
  //   "890abc-125er-c++",
  //   "",
  //   "kfon13092029",
  //   "Assigned to LNP",
  //   ""
  // ];
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeviceListProvider(),
      builder: (context, provider) => Consumer<DeviceListProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            appBar: globalAppBar(
              "Device List",
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          lableText: 'Search here..',
                          isPassword: false,
                          onChangeText: (String value) {
                            timer?.cancel();
                            timer = Timer(
                              const Duration(milliseconds: 1000),
                              () {
                                provider.getDeviceList(
                                  fromSearch: true,
                                );
                              },
                            );
                          },
                          controller: provider.textEditingController,
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            GlobalBottomSheetWidget(
                              onClick: (value) async {
                                if (value.key == "{keeeee}") {
                                  provider.selectedFilter = null;
                                } else {
                                  provider.selectedFilter = value;
                                }

                                provider.getDeviceList();
                                setState(() {});
                              },
                              title: 'Search by status',
                              listData: getList(
                                provider.deviceListData.value?.deviceStatusList,
                              ),
                              enableSearch: false,
                              dropDownValue: provider.selectedFilter?.id ?? "",
                            ),
                            backgroundColor: Colors.transparent,
                          );
                        },
                        icon: const Icon(
                          Icons.filter_alt_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => AdvancePagination(
                      onPageEnd: (isAdv) {
                        if (!isAdv) {
                          provider.getDeviceList(
                            isPagination: true,
                          );
                        }
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (provider.deviceListData.value?.devStats != null)
                              Obx(() {
                                var avDev =
                                    provider.deviceListData.value?.devStats;
                                return Card(
                                  margin: const EdgeInsets.all(10),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center ,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('Inventory Overview',style: appTextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                          ],
                                        ),
                                        const SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Devices:",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "${avDev?.totalDevices}",
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Available at Partner:",
                                                style: TextStyle(fontSize: 13)),
                                            Text(
                                                "${(int.tryParse(avDev?.availableAtLnp?.working ?? "0") ?? 0) + (int.tryParse(avDev?.availableAtLnp?.faulty ?? "0") ?? 0)}",
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Working:",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.green,
                                                )),
                                            Text(
                                                "(${avDev?.availableAtLnp?.working})",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.green,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Return Faulty Request:",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red,
                                                )),
                                            Text(
                                                "(${avDev?.availableAtLnp?.faulty})",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Return Device Request:",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red,
                                                )),
                                            Text(
                                                "(${avDev?.availableAtLnp?.returnRequest})",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ),
                                        const Divider(),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                                "Available at Subscriber:",
                                                style: TextStyle(fontSize: 13)),
                                            Text(
                                                "${avDev?.availableAtSubscribers}",
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                                "ONTs Available at Churned Subscribers:",
                                                style: TextStyle(fontSize: 13)),
                                            Text(
                                                "${avDev?.ontAvalibleAtChurnedSubscribers}",
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  provider.deviceListData.value?.list.length ??
                                      0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var sItem =
                                    provider.deviceListData.value?.list[index];
                                var headings =
                                    provider.deviceListData.value?.headings;
                                var i = 0;
                                return Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.all(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(),
                                        ...?sItem?.map(
                                          (item) {
                                            i++;
                                            return item != "" && item != null
                                                ? InkWell(
                                                    onTap: () {},
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${headings?[i - 1]} :",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  item,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox();
                                          },
                                        ).toList(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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

  List<DropDownDataModel> getList(Map<String?, String?>? deviceStatusList) {
    print(deviceStatusList);
    List<DropDownDataModel> finaList = [];
    deviceStatusList?.forEach(
      (key, value) {
        finaList.add(
          DropDownDataModel(
            value: '$value',
            key: '$key',
            id: '$key',
          ),
        );
      },
    );
    finaList.insert(
      0,
      DropDownDataModel(
        value: 'Clear Filter',
        key: "{keeeee}",
        id: "{keeeee}",
      ),
    );
    print(finaList);
    return finaList;
  }
}
