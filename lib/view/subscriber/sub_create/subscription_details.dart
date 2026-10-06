import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';

import '../../../models/form_type_model.dart';
import '../../../providers/subscriber/sub_create_provider.dart';
import '../../../utils/style.dart';
import '../../../widget/form_widgets/selected_plan_form.dart';
import '../../../widget/global_bottomsheet_widget.dart';
import '../../../widget/utils_widgets/value_picker.dart';

class SubscriptionDetails extends StatefulWidget {
  final SubCreateProvider subCreateProvider;
  final String caf;
  final String profileID;

  const SubscriptionDetails({
    super.key,
    required this.subCreateProvider,
    required this.caf,
    required this.profileID,
  });

  @override
  State<SubscriptionDetails> createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Subscriber Details",
            style: appTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            errorColor: widget.subCreateProvider.userNameAvailable
                ? Colors.green
                : Colors.red,
            errorText: widget.subCreateProvider.userNameError,
            prefixWidget: const Text("kfon."),
            lableText: "Desired Username",
            controller: widget.subCreateProvider.userNameController,
            onChangeText: (e) {
              widget.subCreateProvider.checkUserName(e);
            },
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ValuePicker(
            callback: () async {
              if (widget.subCreateProvider.planTypeDropDown.isEmpty) {
                await widget.subCreateProvider.getPlanType(
                  widget.caf,
                  widget.profileID,
                );
              }

              Get.bottomSheet(
                GlobalBottomSheetWidget(
                  title: 'Select Plan Type',
                  listData: widget.subCreateProvider.planTypeDropDown,
                  dropDownValue:
                      widget.subCreateProvider.selectedPlanTypeID ?? "",
                  onClick: (DropDownDataModel value) async {
                    widget.subCreateProvider.selectedPackageController.clear();
                    widget.subCreateProvider.selectedPlanID = null;
                    widget.subCreateProvider.selectedPlanTypeID = value.id;
                    widget.subCreateProvider.selectedPlanType = value.value;
                    setState(() {});
                    await widget.subCreateProvider.getPlans(
                      widget.caf,
                      widget.profileID,
                    );
                  },
                ),
              );
            },
            selectedValue:
                widget.subCreateProvider.selectedPlanType ?? "Select Plan Type",
            canClick: true,
            hint: "Select Plan Type",
            isRequired: true,
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            isEditable: false,
            lableText: "Selected Package",
            controller: widget.subCreateProvider.selectedPackageController,
            onChangeText: (e) {},
            isRequired: true,
          ),
          const SizedBox(
            height: 5,
          ),
          SelectedFormPlan(
            subCreateProvider: widget.subCreateProvider,
          ),
        ],
      ),
    );
  }
}
