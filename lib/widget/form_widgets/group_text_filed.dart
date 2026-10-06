import 'package:flutter/material.dart';
import 'package:kfon_lnp/models/form_type_model.dart';
import 'package:kfon_lnp/providers/subscriber/sub_create_provider.dart';

import '../../utils/style.dart';
import '../utils_widgets/custom_textfiled.dart';

class GroupTextFieldBuilder extends StatelessWidget {
  final FromTypeModel singleItem;
  final SubCreateProvider provider;

  const GroupTextFieldBuilder({
    super.key,
    required this.singleItem,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Text(
              singleItem.name,
              style: appTextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          child: Row(
            children: List.generate(singleItem.filed.length, (index) {
              if (singleItem.filed[index].isNotEmpty) {
                singleItem.filedController[index].text =
                    singleItem.filed[index];
              }

              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 1,
                ),
                width: (singleItem.fileSize[index] / 100) * size.width,
                child: CustomTextField(
                  maxLength: singleItem.filedLength[index],
                  isEditable: singleItem.filed[index].isEmpty && index != 1,
                  lableText: '',
                  isPassword: false,
                  onChangeText: (String value) {
                    print(value);
                    if (singleItem.key == "GSTIN") {
                      provider.checkGSTIN();
                    }
                  },
                  controller: singleItem.filedController[index],
                ),
              );
            }),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
