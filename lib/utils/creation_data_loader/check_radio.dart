import '../../data_model/subscriber/normal_application_post_model.dart';
import '../../models/form_type_model.dart';
import '../make_form_data.dart';

void checkRadio(FromTypeModel elements, List emptyFiled,
    NormalApplicationPostModel normalApplicationPostModel, int index) {
  var value = elements.selectedValue;
  var valueStatus = value == null || value.toString().isEmpty;
  if (valueStatus) {
    elements.errorText = "Please Select ${elements.name}";
  } else {
    elements.errorText = null;
  }

  emptyFiled.add(
    EmptyFiledModel(
      mainIndex: index,
      key: elements.key,
      error: elements.errorText,
      value: value,
    ),
  );
  switch (elements.key) {
    case "GE":
      normalApplicationPostModel.gender = value;
      return;
    case "LTY":
      if (index == 1) {
        normalApplicationPostModel.locType = value;
      } else if (index == 2) {
        normalApplicationPostModel.locTypeInsta = value;
      }

      return;
    case "GSTIA":
      print("$value gcgjdd");
      normalApplicationPostModel.gstinAvailable = value;
  }
}
