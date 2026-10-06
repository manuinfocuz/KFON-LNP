import 'dart:convert';
import 'dart:io';

import '../../data_model/subscriber/normal_application_post_model.dart';
import '../../models/form_type_model.dart';

void fileUploadValidator(FromTypeModel elements, List emptyFiled,
    NormalApplicationPostModel normalApplicationPostModel, int i) {
  switch (elements.key) {
    case "AFC":
      // normalApplicationPostModel.appliformcopy =
      //     convertFileToBase64(elements.selectedFilePath);

      return;
    case "RPC":
      normalApplicationPostModel.residenceType = elements.selectedValue;
      normalApplicationPostModel.addressproofNo =
          elements.textEditingController?.text;
      // normalApplicationPostModel.addressproofCopy =
      //     convertFileToBase64(elements.selectedFilePath);
      return;
    case "IPC":
      normalApplicationPostModel.idproofType = elements.selectedValue;
      normalApplicationPostModel.idproofNo =
          elements.textEditingController?.text;
      // normalApplicationPostModel.idproofCopy =
      //     convertFileToBase64(elements.selectedFilePath);
      return;
    case "GSPC":
      // normalApplicationPostModel.gstinproof =
      //     convertFileToBase64(elements.selectedFilePath);

      return;
    case "PPC":
      // normalApplicationPostModel.panProof =
      //     convertFileToBase64(elements.selectedFilePath);

      return;
  }
}

String? convertFileToBase64(String? path) {
  return path == null
      ? null
      : base64Encode(
          File("$path").readAsBytesSync(),
        );
}
