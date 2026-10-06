import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kfon_lnp/models/form_type_model.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/view/my_suports/new_sub_enquires_details_screen.dart';
import 'package:most_advance_scroll/most_advance_scroll.dart';
import 'package:provider/provider.dart';

import '../../providers/my_supports/new_enquires_provider.dart';
import '../../widget/global_bottomsheet_widget.dart';
import '../../widget/utils_widgets/custom_textfiled.dart';
import '../../widget/utils_widgets/globalAppBar.dart';
import '../../widget/utils_widgets/value_picker.dart';

class NewSupEnquiresScreen extends StatefulWidget {
  const NewSupEnquiresScreen({super.key});

  @override
  State<NewSupEnquiresScreen> createState() => _NewSupEnquiresScreenState();
}

class _NewSupEnquiresScreenState extends State<NewSupEnquiresScreen> {
  Future showFilterBottomSheet(BuildContext context,
      {required NewEnquiresProvider provider}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => FilterBottomSheet(
        provider,
      ),
    );
  }

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewEnquiresProvider(),
      builder: (context, provider) => Consumer<NewEnquiresProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            appBar: globalAppBar(
              "Applied Online - Customers",
            ),
            body: Column(
              children: [
                // Container(
                //   margin: const EdgeInsets.symmetric(
                //     horizontal: 10,
                //   ),
                //   child: Obx(
                //     () => Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             showFilterBottomSheet(
                //               context,
                //               provider: provider,
                //             ).then(
                //               (e) {
                //                 provider.subEnqListDataModel.refresh();
                //                 if (e == true) {
                //                   provider.getEnqList();
                //                 }
                //               },
                //             );
                //           },
                //           child: const Card(
                //             child: Padding(
                //               padding: EdgeInsets.all(8.0),
                //               child: Row(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Icon(
                //                     Icons.filter_alt_rounded,
                //                   ),
                //                   Text(
                //                     "Filter",
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //         if (provider.subEnqListDataModel.value?.searchParams
                //                 .where((e) => e.controller.text.isNotEmpty)
                //                 .firstOrNull !=
                //             null)
                //           InkWell(
                //             onTap: () async {
                //               provider.subEnqListDataModel.value?.searchParams
                //                   .forEach(
                //                 (e) {
                //                   e.controller.text = "";
                //                 },
                //               );
                //               await provider.getEnqList();
                //               provider.subEnqListDataModel.refresh();
                //             },
                //             child: const Card(
                //               color: Colors.red,
                //               child: Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Row(
                //                   mainAxisSize: MainAxisSize.min,
                //                   children: [
                //                     Icon(
                //                       Icons.filter_alt_off_outlined,
                //                     ),
                //                     Text(
                //                       "Clear",
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //       ],
                //     ),
                //   ),
                // ),

                Obx(() {
                  provider.subEnqListDataModel.value;
                  return Column(
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
                                  provider.getEnqList(
                                    needLoad: false,
                                  );
                                  setState(() {});
                                },
                                title: 'Search By Filter',
                                listData: (provider
                                        .subEnqListDataModel.value?.searchParams
                                        .toList()
                                        .map(
                                          (e) => DropDownDataModel(
                                            value: '${e.headings}',
                                            key: '${e.headings}',
                                            id: '${e.headings}',
                                          ),
                                        )
                                        .toList() ??
                                    [])
                                  ..insert(
                                    0,
                                    DropDownDataModel(
                                      value: 'Clear Filter',
                                      key: "{keeeee}",
                                      id: "{keeeee}",
                                    ),
                                  ),
                                enableSearch: false,
                                dropDownValue: '${provider.selectedFilter}',
                              ),
                              backgroundColor: Colors.transparent,
                            );
                          },
                          selectedValue:
                              provider.selectedFilter?.capitalizeFirst ??
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
                              timer =
                                  Timer(const Duration(milliseconds: 1000), () {
                                provider.getEnqList(
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
                    ],
                  );
                }),

                Expanded(
                  child: Obx(
                    () => (provider
                                .subEnqListDataModel.value?.enqlist.isEmpty ??
                            true)
                        ? const Center(
                            child: Text(
                              "No data found",
                            ),
                          )
                        : Column(
                          children: [
                            Center(
                              child: Text(
                                "Total Records: ${provider.subEnqListDataModel.value?.totalRecords ?? '-'}",
                              ),
                            ),
                            Expanded(
                              child: AdvanceListViewBuilder(
                                                               needRefreshIndicator: true,
                                onRefresh: () async{
                                  await provider.getEnqList();
                                },
                                onPageEnd: (isAvd, [bool? s]) {
                                  if (!isAvd) {
                                    provider.getEnqList(
                                      isPaginate: true,
                                    );
                                  }
                                },
                                itemCount: provider.subEnqListDataModel.value
                                        ?.enqlist.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var singleItem = provider
                                      .subEnqListDataModel.value?.enqlist[index];
                                  return InkWell(
                                    onTap: () {
                                      provider.getDetailsView(
                                        singleItem?.id ?? "",
                                      );
                                    },
                                    child: EnquiryItemWidget(
                                      enquiryId: singleItem?.id ?? "",
                                      trackingId:singleItem?.trackingid?? "",
                                      status: singleItem?.status ?? "",
                                      name: singleItem?.name ?? "",
                                      district: singleItem?.district ?? "",
                                      connectionType: singleItem?.connType ?? "",
                                      phone: singleItem?.mobile ?? "",
                                      submitted: singleItem?.createddate?.toString() ?? "",
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
          );
        },
      ),
    );
  }
}

class EnquiryItemWidget extends StatelessWidget {
  final String enquiryId;
  final String trackingId;
  final String status;
  final String name;
  final String district;
  final String connectionType;
  final String phone;
  final String submitted;


  const EnquiryItemWidget({
    super.key,
    required this.enquiryId,
    required this.status,
    required this.name,
    required this.district,
    required this.connectionType,
    required this.phone,
    required this.trackingId,
    required this.submitted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text(
                      'Enquiry ID: $enquiryId',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4,),
                Text(
                  'Tracking ID: $trackingId',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4,),
                Text(
                  'Status: $status',
                  style:  TextStyle(color:getStatusColor(status), fontSize: 14),
                ),
                const SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Conn.Type:',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(connectionType),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Name: $name',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mobile: $phone',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'District: $district',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4,),
                Text(
                  'Submitted Date and Time: $submitted',
                  style: const TextStyle(fontSize: 14),
                ),
                if (status.toLowerCase().replaceAll(" ", '') ==
                    'readytoconnect')
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      final LocaleProvider _localeProvider = Get.find();

                      _localeProvider.navigate(
                        AppRoutes.newSubFormSelectScreen,
                      );
                    },
                    child: Text("Create KYC"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Color getStatusColor(String status) {
  // Normalize: remove spaces + lowercase
  final key = status.replaceAll(' ', '').toLowerCase();

  switch (key) {
    case 'connected':
      return Colors.green; // success
    case 'notfeasible':
      return Colors.red; // error
    case 'readytoconnect':
      return Colors.orange; // warning
    case 'forwardtolnp':
      return Colors.blue; // info
    default:
      return Colors.grey; // fallback
  }
}
class FilterBottomSheet extends StatelessWidget {
  final NewEnquiresProvider provider;

  const FilterBottomSheet(this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [];

    provider.subEnqListDataModel.value?.searchParams.forEach(
      (e) {
        controllers.add(
          TextEditingController(
            text: e.controller.text,
          ),
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            controllers.length,
            (index) {
              var sData =
                  provider.subEnqListDataModel.value?.searchParams[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllers[index],
                  decoration: InputDecoration(
                    labelText: '${sData?.headings}'.capitalizeFirst,
                    border: const OutlineInputBorder(),
                  ),
                ),
              );
            },
          ),

          // Column(
          //   children: [
          //
          //     const SizedBox(height: 10),
          //     TextFormField(
          //       decoration: const InputDecoration(
          //         labelText: 'Name',
          //         border: OutlineInputBorder(),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 10),
          // Column(
          //   children: [
          //     TextFormField(
          //       decoration: const InputDecoration(
          //         labelText: 'Email',
          //         border: OutlineInputBorder(),
          //       ),
          //     ),
          //     const SizedBox(height: 10),
          //     TextFormField(
          //       decoration: const InputDecoration(
          //         labelText: 'Mobile',
          //         border: OutlineInputBorder(),
          //       ),
          //     ),
          //   ],
          // ),
          // //  const SizedBox(height: 10),
          // // Row(
          // //   children: [
          // //     Expanded(
          // //       child: DropdownButtonFormField<String>(
          // //         decoration: const InputDecoration(
          // //           labelText: 'Status',
          // //           border: OutlineInputBorder(),
          // //         ),
          // //         items: [
          // //           DropdownMenuItem(
          // //             value: 'Pending',
          // //             child: Text('Pending'),
          // //           ),
          // //           DropdownMenuItem(
          // //             value: 'Approved',
          // //             child: Text('Approved'),
          // //           ),
          // //         ],
          // //         onChanged: (value) {},
          // //       ),
          // //     ),
          // //     SizedBox(width: 10),
          // //     Expanded(
          // //       child: DropdownButtonFormField<String>(
          // //         decoration: InputDecoration(
          // //           labelText: 'Connection Type',
          // //           border: OutlineInputBorder(),
          // //         ),
          // //         items: [
          // //           DropdownMenuItem(
          // //             value: 'Fiber',
          // //             child: Text('Fiber'),
          // //           ),
          // //           DropdownMenuItem(
          // //             value: 'DSL',
          // //             child: Text('DSL'),
          // //           ),
          // //         ],
          // //         onChanged: (value) {},
          // //       ),
          // //     ),
          // //   ],
          // // ),
          // const SizedBox(height: 10),
          // Column(
          //   children: [
          //     TextFormField(
          //       decoration: const InputDecoration(
          //         labelText: 'Tracking ID',
          //         border: OutlineInputBorder(),
          //       ),
          //     ),
          //     const SizedBox(height: 10),
          //     GestureDetector(
          //       onTap: () async {
          //         DateTime? pickedDate = await showDatePicker(
          //           context: context,
          //           initialDate: DateTime.now(),
          //           firstDate: DateTime(2000),
          //           lastDate: DateTime(2101),
          //         );
          //       },
          //       child: AbsorbPointer(
          //         child: TextFormField(
          //           decoration: const InputDecoration(
          //             labelText: 'Created Date',
          //             border: OutlineInputBorder(),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  var i = 0;
                  for (var e in controllers) {
                    provider.subEnqListDataModel.value?.searchParams[i]
                        .controller.text = e.text;
                    i++;
                  }
                  Get.back(
                    result: true,
                  );
                },
                label: const Text('Filter'),
                icon: const Icon(
                  Icons.filter_alt_outlined,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back(
                    result: false,
                  );
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
