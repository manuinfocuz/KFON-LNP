// import 'package:flutter/material.dart';
// import 'package:kfon_lnp/data_model/subscriber/aadharDetailsModel.dart';
// import 'package:kfon_lnp/widget/form_widgets/radio_button_form.dart';
// import 'package:kfon_lnp/widget/form_widgets/selected_plan_form.dart';
// import 'package:kfon_lnp/widget/form_widgets/text_filed_form.dart';
//
// import '../../models/form_type_model.dart';
// import '../../providers/subscriber/sub_create_provider.dart';
// import '../../utils/style.dart';
// import 'check_box_form.dart';
// import 'drop_down_form.dart';
// import 'from_upload.dart';
// import 'group_text_filed.dart';
// import 'image_with_details.dart';
//
// class MainFormBuilder extends StatelessWidget {
//   final FromTypeModel singleItem;
//   final SubCreateProvider provider;
//   final int mainIndex;
//   final String caf;
//   final String profileID;
//   final AadharDetailsModel? aadharDetailsModel;
//
//   const MainFormBuilder({
//     super.key,
//     required this.provider,
//     required this.singleItem,
//     required this.mainIndex,
//     required this.profileID,
//     required this.caf,
//     required this.aadharDetailsModel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return getFiledByType(
//       singleItem,
//       mainIndex,
//       provider,
//     );
//   }
//
//   Widget getFiledByType(
//       FromTypeModel singleItem, int mainIndex, SubCreateProvider provider) {
//     switch (singleItem.fromType) {
//       case FromType.textField:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return const SizedBox();
//         }
//         return TextFiledForm(
//           singleItem: singleItem,
//           mainIndex: mainIndex,
//           subCreateProvider: provider,
//         );
//       case FromType.dropDown:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return const SizedBox();
//         }
//         if (provider.findByKey(mainIndex, "LTY")?.selectedValue == "1") {
//           if (singleItem.key == "VIN" || singleItem.key == "BLN") {
//             return const SizedBox();
//           }
//         } else if (provider.findByKey(mainIndex, "LTY")?.selectedValue == "2") {
//           if (singleItem.key == "CMN" || !checkDataHave(singleItem)) {
//             return const SizedBox();
//           }
//         }
//         return DropDownForm(
//           singleItem: singleItem,
//           mainIndex: mainIndex,
//           subCreateProvider: provider,
//         );
//
//       case FromType.radioButton:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return SizedBox();
//         }
//         return RadioButtonForm(
//           singleItem: singleItem,
//           mainIndex: mainIndex,
//           subCreateProvider: provider,
//         );
//       case FromType.selectPlan:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return SizedBox();
//         }
//         return SelectedFormPlan(
//           singleItem: singleItem,
//           mainIndex: mainIndex,
//           subCreateProvider: provider,
//         );
//       case FromType.fileUpload:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return SizedBox();
//         }
//         return FormUpload(
//           singleItem: singleItem,
//           mainIndex: mainIndex,
//           subCreateProvider: provider,
//         );
//       case FromType.checkBox:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return SizedBox();
//         }
//         return CheckBoxForm(
//           singleItem: singleItem,
//           mainIndex: mainIndex,
//           subCreateProvider: provider,
//         );
//       case FromType.userAvailable:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return SizedBox();
//         }
//         return Text(
//           "${singleItem.selectedValue}",
//           style: appTextStyle(
//             color: singleItem.isTrue ? Colors.green : Colors.red,
//             fontSize: 20,
//           ),
//         );
//       case FromType.groupTextFiled:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return SizedBox();
//         }
//         return GroupTextFieldBuilder(
//             singleItem: singleItem, provider: provider);
//       case FromType.image:
//         if (!singleItem.isVisible || !checkDataHave(singleItem)) {
//           return SizedBox();
//         }
//         return ImageWithTitleBuilder(
//           aadharDetailsModel: aadharDetailsModel,
//           provider: provider,
//           singleItem: singleItem,
//         );
//       default:
//         return Container();
//     }
//   }
//
//   bool checkDataHave(FromTypeModel singleItem) {
//     return singleItem.showCase[0].contains(int.tryParse(caf)) &&
//         singleItem.showCase[1].contains(int.tryParse(profileID));
//   }
// }
