import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/providers/my_supports/new_enquires_provider.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_button.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';

import '../../models/form_type_model.dart';
import '../../widget/global_bottomsheet_widget.dart';
import '../../widget/utils_widgets/value_picker.dart';

class NewSubEnquiresDetailsScreen extends StatelessWidget {
  final NewEnquiresProvider provider;

  const NewSubEnquiresDetailsScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    var mainData = provider.subEnqDetailsDataModel.value?.enquiry[0];
    bool canEdit = mainData?.status?.toLowerCase() != "connected";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Customer Detailed View",
        ),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      provider.subEnqDetailsDataModel.value?.headings.length ??
                          0,
                  itemBuilder: (context, index) {
                    var singleItem =
                        provider.subEnqDetailsDataModel.value?.headings[index];
                    var jsonData = mainData?.toJson();
                    return singleItem?.toLowerCase() == "remarks"
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildDetailRow(
                                singleItem ?? "",
                                "${jsonData?[jsonData.keys.toList()[index + 1]] ?? "-"}",
                              ),
                            ],
                          );
                  },
                ),
                if (canEdit) ...{
                  const Text(
                    "Change Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  ValuePicker(
                    callback: () {
                      Get.bottomSheet(
                        GlobalBottomSheetWidget(
                          enableSearch: false,
                          title: "Select Status",
                          listData: provider.statusList.toList(),
                          dropDownValue:
                              provider.selectedStatus.value?.id ?? "",
                          onClick: (DropDownDataModel value) {
                            provider.selectedStatus.value = value;
                          },
                        ),
                      );
                    },
                    selectedValue:
                        provider.selectedStatus.value?.value ?? "Select Status",
                    canClick: canEdit,
                    hint: "",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                },
                const Text(
                  "Remarks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                CustomTextField(
                  isEditable: canEdit,
                  isAddress: true,
                  lableText: "",
                  hintText: "Remarks",
                  controller: provider.remarkController,
                ),
                const SizedBox(
                  height: 8,
                ),
                if (canEdit)
                  CustomButton(
                    title: "Submit",
                    onClickFunction: () {
                      provider.updateEnqStatus();
                    },
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildDetailRow(String title, String value,
    {bool isHighlighted = false}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: isHighlighted ? Colors.green : Colors.black54,
          ),
        ),
      ],
    ),
  );
}
