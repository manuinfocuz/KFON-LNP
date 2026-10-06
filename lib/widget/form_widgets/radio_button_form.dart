import 'package:flutter/material.dart';

import '../../models/form_type_model.dart';
import '../../providers/subscriber/sub_create_provider.dart';
import '../../utils/style.dart';
import '../error_text_build.dart';

class RadioButtonForm extends StatelessWidget {
  final FromTypeModel singleItem;
  final int mainIndex;
  final SubCreateProvider subCreateProvider;

  const RadioButtonForm({
    super.key,
    required this.singleItem,
    required this.mainIndex,
    required this.subCreateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select ${singleItem.name}",
            style: appTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: singleItem.dropDownDataModel?.length ?? 0,
            itemBuilder: (c, i) {
              var itemData = singleItem.dropDownDataModel?[i];
              return ListTile(
                title: Text('${itemData?.value}'),
                leading: Radio(
                  value: '${itemData?.key}',
                  groupValue: "${singleItem.selectedValue}",
                  onChanged: (value) {
                    singleItem.errorText = null;
                    if (!singleItem.isEditable) {
                      return;
                    }
                    if (singleItem.key == "LTY") {
                      singleItem.selectedValue = value;
                      // subCreateProvider.getLocalBodyList(mainIndex);
                      subCreateProvider.refreshState();
                    } else if (singleItem.key == "GE") {
                      singleItem.selectedValue = value;
                      subCreateProvider.refreshState();
                    } else if (singleItem.key == "GSTIA") {
                      subCreateProvider.findByKey(6, "GSPA")?.isVisible =
                          value == "1";
                      subCreateProvider.findByKey(6, "GSTIN")?.isVisible =
                          value == "1";
                      subCreateProvider.findByKey(6, "TAXPY")?.isVisible =
                          value == "1";
                      subCreateProvider.findByKey(6, "LNOB")?.isVisible =
                          value == "1";
                      subCreateProvider.findByKey(6, "TRAN")?.isVisible =
                          value == "1";

                      singleItem.selectedValue = value;
                      subCreateProvider.refreshState();
                    }
                  },
                ),
              );
            },
          ),
          if (singleItem.errorText != null)
            errorTextBuilder(singleItem.errorText)
        ],
      ),
    );
  }
}
