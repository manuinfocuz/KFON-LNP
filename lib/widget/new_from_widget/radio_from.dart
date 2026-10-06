import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kfon_lnp/providers/subscriber/sub_create_provider.dart';

import '../../utils/global_functions.dart';
import '../../utils/style.dart';

Widget radioForm(
  String heading,
  List<List<String>> list,
  String? selectedValue,
  SubCreateProvider subCreateProvider,
  Function(dynamic value) onClick, {
  bool isRequired = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text.rich(
        TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              child: Text(
                heading,
                style: appTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isRequired)
              const WidgetSpan(
                child: Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
      // Text(
      //   heading,
      //   style: appTextStyle(
      //     fontSize: 15,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),

      Column(
        children: List.generate(
          list.length,
          (index) => radioButton(
              list[index], selectedValue, subCreateProvider, onClick),
        ),
      )
// ListView.builder(
//   physics: const NeverScrollableScrollPhysics(),
//   shrinkWrap: true,
//   scrollDirection: Axis.horizontal,
//   itemCount: 1,
//   itemBuilder: (context, index) => radioButton(
//     list[index],
//   ),
// ),
    ],
  );
}

Widget radioButton(
  List<String> title,
  String? selectedValue,
  SubCreateProvider subCreateProvider,
  Function(dynamic value) onClick,
) {
  return ListTile(
    onTap: () {
      closeKeyBoard();
      onClick(
        title[1],
      );
    },
    title: Text(title[0]),
    leading: Radio(
      value: title[1],
      groupValue: selectedValue,
      onChanged: (value) {
        closeKeyBoard();
        onClick(value);
      },
    ),
  );
}
