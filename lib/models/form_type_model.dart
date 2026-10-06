import 'package:flutter/material.dart';

class FromTypeModel {
  final String key;
  final String name;
  final FromType fromType;
  TextEditingController? textEditingController;
  List<DropDownDataModel>? dropDownDataModel;
  final bool isDatePicker;
  final bool isEditable;
  final bool isRequired;
  String? errorText;
  final bool isEmail;
  final int min;
  final int max;
  final bool isDigit;
  List<String> depend = [];
  Widget? preFix;
  TextInputType? inputType;
  dynamic selectedValue;
  dynamic selectedDisplayValue;
  String? selectedFilePath;
  List<String> filed;
  List<TextEditingController> filedController;
  List<bool> filedStatus;
  List<double> fileSize;
  List<int> filedLength;
  bool isTrue;
  bool showFiledCount;
  bool isVisible;
  bool require;
  List<List<int>> showCase;
  List<FromTypeModel> innerWidget;

  FromTypeModel(
      {required this.key,
      required this.name,
      required this.fromType,
      this.textEditingController,
      this.dropDownDataModel,
      this.isDatePicker = false,
      this.isEditable = true,
      this.isRequired = true,
      this.errorText,
      this.isEmail = false,
      this.max = 0,
      this.min = 0,
      this.isDigit = false,
      this.depend = const [],
      this.preFix,
      this.inputType,
      this.selectedValue = "",
      this.selectedDisplayValue = "",
      this.filed = const [],
      this.filedStatus = const [],
      this.selectedFilePath,
      this.isTrue = false,
      this.filedController = const [],
      this.fileSize = const [],
      this.filedLength = const [],
      this.showCase = const [
        [1, 2],
        [1, 2, 3]
      ],
      this.showFiledCount = false,
      this.isVisible = true,
      this.require = false,
      this.innerWidget = const []});

  // Copy constructor
  FromTypeModel.copy(FromTypeModel other)
      : key = other.key,
        name = other.name,
        fromType = other.fromType,
        textEditingController = other.textEditingController != null
            ? TextEditingController(text: other.textEditingController!.text)
            : null,
        dropDownDataModel = other.dropDownDataModel != null
            ? List.from(other.dropDownDataModel!)
            : null,
        isDatePicker = other.isDatePicker,
        isEditable = other.isEditable,
        isRequired = other.isRequired,
        errorText = other.errorText,
        isEmail = other.isEmail,
        min = other.min,
        max = other.max,
        isDigit = other.isDigit,
        depend = List.from(other.depend),
        preFix = other.preFix,
        inputType = other.inputType,
        selectedValue = other.selectedValue,
        selectedDisplayValue = other.selectedDisplayValue,
        selectedFilePath = other.selectedFilePath,
        filed = List.from(other.filed),
        filedController = List.from(other.filedController),
        filedStatus = List.from(other.filedStatus),
        fileSize = List.from(other.fileSize),
        filedLength = List.from(other.filedLength),
        isTrue = other.isTrue,
        showFiledCount = other.showFiledCount,
        isVisible = other.isVisible,
        require = other.require,
        showCase = List.from(other.showCase),
        innerWidget = List.from(
            other.innerWidget.map((widget) => FromTypeModel.copy(widget)));

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
      'fromType': fromType.toString().split('.').last,
      'textEditingController': textEditingController?.text,
      'dropDownDataModel':
          dropDownDataModel?.map((data) => data.toJson()).toList(),
      'isDatePicker': isDatePicker,
      'isEditable': isEditable,
      'isRequired': isRequired,
      'errorText': errorText,
      'isEmail': isEmail,
      'min': min,
      'max': max,
      'isDigit': isDigit,
      'depend': depend,
      'preFix': preFix?.toString(),
      'inputType': inputType?.toString(),
      'selectedValue': selectedValue,
      'selectedDisplayValue': selectedDisplayValue,
      'selectedFilePath': selectedFilePath,
      'filed': filed,
      'filedController':
          filedController.map((controller) => controller.text).toList(),
      'filedStatus': filedStatus,
      'fileSize': fileSize,
      'filedLength': filedLength,
      'isTrue': isTrue,
      'showFiledCount': showFiledCount,
      'isVisible': isVisible,
      'require': require,
      'showCase': showCase,
      'innerWidget': innerWidget.map((widget) => widget.toJson()).toList(),
    };
  }
}

enum FromType {
  textField,
  groupTextFiled,
  checkBox,
  radioButton,
  dropDown,
  fileUpload,
  selectPlan,
  userAvailable,
  image,
  valueWithTitle
}

class DropDownDataModel {
  final String value;
  final String key;
  final String id;

  DropDownDataModel({
    required this.value,
    required this.key,
    required this.id,
  });
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'key': key,
      'id': id,
    };
  }
}
