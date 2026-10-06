import 'package:kfon_lnp/view/subscriber/sub_create/subscriber_form_screen.dart';

import '../../data_model/subscriber/normal_application_post_model.dart';
import '../../helper/validate_helper.dart';
import '../../models/form_type_model.dart';
import '../make_form_data.dart';

void checkTextFiled(FromTypeModel elements, List emptyFiled,
    NormalApplicationPostModel normalApplicationPostModel, int index) {
  var value = elements.textEditingController?.text;
  var errorCheck = globalValidate(
    "${value}",
    elements.min,
    elements.max,
    elements.isEmail,
    elements.name,
  );
  elements.errorText = errorCheck;
  emptyFiled.add(
    EmptyFiledModel(
      mainIndex: index,
      key: elements.key,
      error: elements.errorText,
      value: value,
    ),
  );
  switch (elements.key) {
    case "AID":
      normalApplicationPostModel.apno = value;
      return;
    case "FN":
      normalApplicationPostModel.firstname = value;
      return;
    case "COMNA":
      //  normalApplicationPostModel.firstname = value;
      return;
    case "DOB":
      normalApplicationPostModel.dateofbirth = value;
      return;
    case "MN":
      normalApplicationPostModel.mobileno = value;
      return;
    case "ALCU":
      normalApplicationPostModel.contactManagerNo = value;
      return;
    case "CONPE":
      normalApplicationPostModel.contactManager = value;
      return;
    case "EA":
      normalApplicationPostModel.email = value;
      return;
    case "DNA":
      if (index == 1) {
        normalApplicationPostModel.doorno = value;
      } else if (index == 2) {
        normalApplicationPostModel.doornoInsta = value;
      }

      return;

    case "SLN":
      if (index == 1) {
        normalApplicationPostModel.streetlo = value;
      } else if (index == 2) {
        normalApplicationPostModel.streetloInsta = value;
      }

      return;
    case "CIY":
      if (index == 1) {
        normalApplicationPostModel.cityname = value;
      } else if (index == 2) {
        normalApplicationPostModel.citynameInsta = value;
      }

      return;
    case "DEU":
      // if (index == 1) {
      normalApplicationPostModel.username = value;
      //  }
      return;
    case "DEMK":

      ///   if (index == 1) {
      normalApplicationPostModel.deviceMake = value;
      // }
      return;

    case "DEMO":
      //if (index == 1) {
      normalApplicationPostModel.deviceModel = value;
      //}
      return;
    case "DEMAA":
      //  if (index == 1) {
      normalApplicationPostModel.deviceMacAddress = value;
      // }
      return;
    case "GSPA":
      //  if (index == 1) {
      normalApplicationPostModel.panNumber = value;
      // }
      return;
  }
}
