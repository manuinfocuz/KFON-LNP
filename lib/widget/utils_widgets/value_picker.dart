import 'package:flutter/material.dart';

import '../../utils/global_functions.dart';
import '../../utils/style.dart';
import 'custom_textfiled.dart';

class ValuePicker extends StatelessWidget {
  final String selectedValue;
  final Function callback;
  final bool canClick;
  final String hint;
  final bool isRequired;

  const ValuePicker({
    super.key,
    required this.callback,
    required this.selectedValue,
    required this.canClick,
    required this.hint,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      isRequired: isRequired,
      onTab: canClick
          ? () {
              closeKeyBoard();
              callback();
            }
          : null,
      lableText: hint,
      controller: TextEditingController(
        text: selectedValue,
      ),
      isEditable: false,
      suffixIcon: const Icon(
        Icons.arrow_drop_down_circle_outlined,
      ),
      canClick: canClick,
    );
  }
}

// Container(
// width: double.infinity,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8),
// border: Border.all(
// color: canClick ? primaryColor : Colors.grey,
// ),
// ),
// padding: const EdgeInsets.symmetric(horizontal: 10),
// child: ConstrainedBox(
// constraints: const BoxConstraints(
// minHeight: 40,
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// selectedValue,
// style: appTextStyle(
// fontWeight: FontWeight.w500,
// fontSize: 17,
// ),
// ),
// const Icon(Icons.arrow_drop_down_circle_outlined),
// ],
// ),
// ],
// ),
// ),
// ),
