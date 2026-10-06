import '../../data_model/subscriber/normal_application_post_model.dart';
import '../../models/form_type_model.dart';
import '../make_form_data.dart';

void checkDropDown(FromTypeModel elements, List emptyFiled, int index,
    NormalApplicationPostModel normalApplicationPostModel) {
  var value = elements.selectedValue;
  var valueStatus = value == null || value.toString().isEmpty;
  if (valueStatus) {
    elements.errorText = "Please Select ${elements.name}";
    emptyFiled.add(
      EmptyFiledModel(
        mainIndex: index,
        key: elements.key,
        error: elements.errorText,
        value: value,
      ),
    );
  } else {
    elements.errorText = null;
  }

  switch (elements.key) {
    case "PIE":
      if (index == 1) {
        normalApplicationPostModel.pincode = value;
      } else if (index == 2) {
        normalApplicationPostModel.pincodeInsta = value;
      }

      return;
    case "PON":
      if (index == 1) {
        normalApplicationPostModel.postOfficeName = value;
      } else if (index == 2) {
        normalApplicationPostModel.postOfficeNameInsta = value;
      }

      return;
    case "DIT":
      if (index == 1) {
        normalApplicationPostModel.district = value;
      } else if (index == 2) {
        normalApplicationPostModel.districtInsta = value;
      }

      return;
    case "LBY":
      if (index == 1) {
        normalApplicationPostModel.localbodyType = value;
      } else if (index == 2) {
        normalApplicationPostModel.localBodyInsta = value;
      }

      return;
    case "VIN":
      if (index == 1) {
        normalApplicationPostModel.villageName = value;
      } else if (index == 2) {
        normalApplicationPostModel.villageNameInsta = value;
      }

      return;
    case "BLN":
      if (index == 1) {
        normalApplicationPostModel.block = value;
      } else if (index == 2) {
        normalApplicationPostModel.blockInsta = value;
      }

      return;
    case "BLN":
      if (index == 1) {
        normalApplicationPostModel.block = value;
      } else if (index == 2) {
        normalApplicationPostModel.blockInsta = value;
      }

      return;
    case "CMN":
      if (index == 1) {
        normalApplicationPostModel.municipalityName = value;
      } else if (index == 2) {
        normalApplicationPostModel.municipalityNameInsta = value;
      }

      return;
    case "SPLTY":
      normalApplicationPostModel.planType = value;

      return;
    case "DEPR":
      normalApplicationPostModel.deviceProvider = value;

      return;
    case "DETY":
      normalApplicationPostModel.deviceType = value;

      return;
    case "OLTTY":
      normalApplicationPostModel.oltType = value;

      return;
  }
}
