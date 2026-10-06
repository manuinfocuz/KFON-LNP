import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/utils/global_functions.dart';

import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';

import '../models/form_type_model.dart';

class GlobalBottomSheetWidget extends StatefulWidget {
  final String title;
  final List<DropDownDataModel> listData;
  final String dropDownValue;
  final Function(DropDownDataModel value) onClick;
  final bool enableSearch;
  final bool canClear;
  final Function? clearClick;
  final String? searchPlaceHolder;
  const GlobalBottomSheetWidget({
    super.key,
    required this.title,
    required this.listData,
    required this.dropDownValue,
    required this.onClick,
    this.enableSearch = true,
    this.canClear = false,
    this.clearClick,  this. searchPlaceHolder,
  });

// if connected i have to show subscriuber to select..
// two show  2button

  @override
  State<GlobalBottomSheetWidget> createState() =>
      _GlobalBottomSheetWidgetState();
}

class _GlobalBottomSheetWidgetState extends State<GlobalBottomSheetWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  List<DropDownDataModel> tempList = [];

  @override
  void initState() {
    super.initState();
    tempList.addAll(widget.listData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final DropDownDataModel? selected = widget.listData.firstWhereOrNull(
      (element) =>
          element.value == widget.dropDownValue ||
          element.key == widget.dropDownValue,
    );
    myPrint(widget.dropDownValue, '');
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: appTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (widget.enableSearch)
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: CustomTextField(
                //inputType: TextInputType.number,
                lableText:widget.searchPlaceHolder ?? 'Search here..',
                isPassword: false,
                onChangeText: (String value) {
                  tempList = [];
                  for (var element in widget.listData) {
                    if (element.value
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      tempList.add(element);
                    }
                  }
                  if (value.isEmpty) {
                    tempList = [];
                    tempList.addAll(widget.listData);
                  }
                  setState(() {});
                },
                controller: _textEditingController,
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          if (widget.canClear && widget.listData.isNotEmpty)
            ListTile(
              onTap: () {
                Get.back();
                widget.clearClick?.call();
                setState(() {});
              },
              leading: const Text(
                "",
              ),
              title: const Text(
                "Clear",
              ),
            ),
          if (selected != null)
            ListTile(
              onTap: () {
                Get.back();
                // widget.onClick(selected);
                //  dropdownvalue = "${value}";
                setState(() {});
              },
              leading: Radio(
                value: selected.id,
                groupValue: widget.dropDownValue,
                onChanged: (value) {
                  Get.back();
                  //widget.onClick(selected);
                  //  dropdownvalue = "${value}";
                  setState(() {});
                },
              ),
              title: Text(selected.value),
              // onTap: () {
              //   dropdownvalue = itemData;
              //   setState(() {});
              //   Get.back();
              // },
            ),
          Expanded(
            child: ListView.builder(
              itemCount: tempList.length,
              itemBuilder: (context, index) {
                var itemData = tempList[index];
                if (itemData.value == selected?.value) {
                  return SizedBox();
                }
                return ListTile(
                  onTap: () {
                    Get.back();
                    widget.onClick(itemData);
                    //  dropdownvalue = "${value}";
                    setState(() {});
                  },
                  leading: Radio(
                    value: itemData.id,
                    groupValue: widget.dropDownValue,
                    onChanged: (value) {
                      Get.back();
                      widget.onClick(itemData);
                      //  dropdownvalue = "${value}";
                      setState(() {});
                    },
                  ),
                  title: Text(itemData.value),
                  // onTap: () {
                  //   dropdownvalue = itemData;
                  //   setState(() {});
                  //   Get.back();
                  // },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
