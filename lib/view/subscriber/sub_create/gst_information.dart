import 'package:flutter/material.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';

import '../../../providers/subscriber/sub_create_provider.dart';
import '../../../utils/style.dart';

class GSTInformation extends StatefulWidget {
  final SubCreateProvider subCreateProvider;
  final String caf;
  final String profileID;

  const GSTInformation({
    super.key,
    required this.subCreateProvider,
    required this.caf,
    required this.profileID,
  });

  @override
  State<GSTInformation> createState() => _GSTInformationState();
}

class _GSTInformationState extends State<GSTInformation> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "GST Information",
            style: appTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            autoCap: true,
            maxLength: 10,
            lableText: "Pan",
            controller: widget.subCreateProvider.panController,
            onChangeText: (e) {
              widget.subCreateProvider.checkGSTIN();
            },
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "GSTIN",
                style: appTextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 40,
                child: CustomTextField(
                  autoCap: true,
                  isEditable: false,
                  lableText: "",
                  controller: widget.subCreateProvider.gstinOneController,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: CustomTextField(
                  autoCap: true,
                  maxLength: 10,
                  lableText: "",
                  controller: widget.subCreateProvider.panController,
                  onChangeText: (e) {
                    widget.subCreateProvider.checkGSTIN();
                  },
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              SizedBox(
                width: 40,
                child: CustomTextField(
                  maxLength: 1,
                  autoCap: true,
                  lableText: "",
                  controller: widget.subCreateProvider.gstinThreeController,
                  onChangeText: (e) {
                    widget.subCreateProvider.checkGSTIN();
                  },
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              SizedBox(
                width: 40,
                child: CustomTextField(
                  autoCap: true,
                  isEditable: false,
                  lableText: "",
                  controller: widget.subCreateProvider.gstinFourController,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              SizedBox(
                width: 40,
                child: CustomTextField(
                  autoCap: true,
                  maxLength: 1,
                  lableText: "",
                  controller: widget.subCreateProvider.gstinFiveController,
                  onChangeText: (e) {
                    widget.subCreateProvider.checkGSTIN();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                isEditable: false,
                lableText: "Tax-Payer Type",
                controller: widget.subCreateProvider.texPayerController,
                isRequired: true,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                isEditable: false,
                lableText: "Legal Name Of Business",
                controller: widget.subCreateProvider.legalBusNameController,
                isRequired: true,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                isEditable: false,
                lableText: "Trade Name",
                controller: widget.subCreateProvider.tradeNameController,
                isRequired: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
