import 'package:flutter/material.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:kfon_lnp/utils/make_form_data.dart';

import '../../models/form_type_model.dart';
import '../../providers/subscriber/sub_create_provider.dart';

class CheckBoxForm extends StatelessWidget {
  final FromTypeModel singleItem;
  final int mainIndex;
  final SubCreateProvider subCreateProvider;

  const CheckBoxForm({
    super.key,
    required this.singleItem,
    required this.mainIndex,
    required this.subCreateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(singleItem.name), //    <-- label
      value: singleItem.selectedValue,
      onChanged: (newValue) {
        if (!singleItem.isEditable) {
          return;
        }
        singleItem.selectedValue = newValue;

        if (singleItem.key == "ISSAME") {
          if (newValue ?? false) {
            var i = 0;
            subCreateProvider.dataExpend[1].expandedValue.forEach((element) {
              subCreateProvider.dataExpend[2].expandedValue[i] = element;

              i++;
            });
          } else {
            subCreateProvider.dataExpend[2].expandedValue =
                MakeFormData.createFormPermanentAddress(isInstallation: true);
            subCreateProvider.findByKey(2, "PIE")?.dropDownDataModel =
                subCreateProvider.findByKey(1, "PIE")?.dropDownDataModel;
          }
          //var i = 0;
          // subCreateProvider.dataExpend[1].expandedValue.forEach((element) {
          //   subCreateProvider.dataExpend[2].expandedValue[i] =
          //       FromTypeModel.copy(element);
          //
          //   i++;
          // });
        }
        subCreateProvider.refreshState();
      },
    );
  }
}
