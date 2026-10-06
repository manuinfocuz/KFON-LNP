import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/form_type_model.dart';
import '../providers/subscriber/sub_create_provider.dart';

class MakeFormData {
  ///FUN CREATE
  static List<FromTypeModel> createFormPersonnelDetails() {
    List<FromTypeModel> personnelDetailsFormList = [];

    personnelDetailsFormList.add(
      FromTypeModel(
        key: "AID",
        name: 'Application Form No.',
        fromType: FromType.textField,
        isEditable: false,
      ),
    );
    personnelDetailsFormList.add(
      FromTypeModel(
          key: "FN",
          name: 'First Name',
          fromType: FromType.textField,
          min: 1,
          max: 64,
          require: true,
          showCase: [
            [1, 2],
            [1, 3]
          ]),
    );

    personnelDetailsFormList.add(
      FromTypeModel(
        key: "COMNA",
        name: 'Company Name',
        fromType: FromType.textField,
        min: 1,
        max: 64,
        require: true,
        showCase: [
          [1, 2],
          [2]
        ],
      ),
    );

    personnelDetailsFormList.add(
      FromTypeModel(
        key: "DOB",
        name: 'DOB',
        fromType: FromType.textField,
        isEditable: false,
        isDatePicker: true,
        require: true,
      ),
    );
    List<DropDownDataModel> genderType = [];
    genderType.add(
      DropDownDataModel(value: 'Male', key: '1', id: '1'),
    );
    genderType.add(
      DropDownDataModel(value: 'Female', key: '2', id: '2'),
    );
    genderType.add(
      DropDownDataModel(value: 'Others', key: '3', id: '3'),
    );
    personnelDetailsFormList.add(
      FromTypeModel(
        key: "GE",
        name: 'Gender',
        fromType: FromType.radioButton,
        dropDownDataModel: genderType,
        require: true,
      ),
    );
    personnelDetailsFormList.add(
      FromTypeModel(
        key: "MN",
        name: 'Mobile Number',
        fromType: FromType.textField,
        min: 10,
        max: 10,
        isDigit: true,
        inputType: TextInputType.number,
        require: true,
      ),
    );

    personnelDetailsFormList.add(
      FromTypeModel(
        key: "ALCU",
        name: 'Alternate Contact Number',
        fromType: FromType.textField,
        min: 1,
        max: 64,
        require: true,
        showCase: [
          [1, 2],
          [2]
        ],
      ),
    );

    personnelDetailsFormList.add(
      FromTypeModel(
        key: "CONPE",
        name: 'Contact Person',
        fromType: FromType.textField,
        min: 1,
        max: 64,
        require: true,
        showCase: [
          [1, 2],
          [2]
        ],
      ),
    );

    personnelDetailsFormList.add(
      FromTypeModel(
        key: "EA",
        name: 'Email Address',
        fromType: FromType.textField,
        isEmail: true,
        inputType: TextInputType.emailAddress,
        require: true,
        // min: 3,
        // max: 64,
      ),
    );

    personnelDetailsFormList.add(
      FromTypeModel(
          key: "KYCIM",
          name: '',
          fromType: FromType.image,
          isEmail: true,
          showCase: [
            [2],
            [1, 2, 3],
          ],
          innerWidget: [
            FromTypeModel(
              key: "KYCAD",
              name: 'Aadhaar Address',
              fromType: FromType.valueWithTitle,
              selectedValue: "",
              showCase: [
                [2],
                [1, 2, 3],
              ],
            ),
          ]),
    );

    personnelDetailsFormList.forEach((element) {
      element.textEditingController = TextEditingController();
    });

    return personnelDetailsFormList;
  }

  static List<FromTypeModel> createFormPermanentAddress(
      {bool isInstallation = false}) {
    List<FromTypeModel> permanentAddressFormList = [];

    permanentAddressFormList.add(
      FromTypeModel(
        key: "DNA",
        name: 'Door No/Apartment.',
        fromType: FromType.textField,
        min: 3,
        max: 80,
        require: true,
      ),
    );
    permanentAddressFormList.add(
      FromTypeModel(
        key: "SLN",
        name: 'Street/Locality Name ',
        fromType: FromType.textField,
        min: 2,
        max: 200,
        require: true,
      ),
    );
    permanentAddressFormList.add(
      FromTypeModel(
        key: "CIY",
        name: 'City',
        fromType: FromType.textField,
        min: 2,
        max: 80,
        require: true,
      ),
    );

    permanentAddressFormList.add(
      FromTypeModel(
        key: "PIE",
        name: 'Pincode',
        fromType: FromType.dropDown,
        isEditable: true,
        min: 6,
        max: 6,
        dropDownDataModel: [],
        depend: ['Post Office Name.', 'District'],
        require: true,
      ),
    );

    permanentAddressFormList.add(
      FromTypeModel(
        key: "PON",
        name: 'Post Office Name.',
        fromType: FromType.dropDown,
        isEditable: true,
        min: 2,
        max: 100,
        require: true,
      ),
    );

    permanentAddressFormList.add(
      FromTypeModel(
        key: "DIT",
        name: 'District',
        fromType: FromType.dropDown,
        isEditable: true,
        min: 2,
        max: 100,
        require: true,
      ),
    );

    List<DropDownDataModel> locationType = [];
    locationType.add(
      DropDownDataModel(value: 'Urban', key: '1', id: '1'),
    );
    locationType.add(
      DropDownDataModel(value: 'Rural', key: '2', id: '2'),
    );
    permanentAddressFormList.add(
      FromTypeModel(
        key: "LTY",
        name: 'Location Type',
        fromType: FromType.radioButton,
        isEditable: true,
        min: 1,
        depend: ["Local body Type"],
        dropDownDataModel: locationType,
        require: true,
      ),
    );

    permanentAddressFormList.add(
      FromTypeModel(
        key: "LBY",
        name: 'Local body Type',
        fromType: FromType.dropDown,
        isEditable: true,
        min: 1,
        depend: ["Village Name", "Block Name"],
        require: true,
      ),
    );
    permanentAddressFormList.add(
      FromTypeModel(
        key: "VIN",
        name: 'Village Name',
        fromType: FromType.dropDown,
        isEditable: true,
        min: 2,
        max: 255,
      ),
    );

    permanentAddressFormList.add(
      FromTypeModel(
        key: "BLN",
        name: 'Block Name',
        fromType: FromType.dropDown,
        isEditable: true,
        min: 1,
        require: true,
      ),
    );

    permanentAddressFormList.add(
      FromTypeModel(
        key: "CMN",
        name: 'Corporation/Municipality Name',
        fromType: FromType.dropDown,
        isEditable: true,
        min: 2,
        max: 255,
      ),
    );

    if (isInstallation) {
      permanentAddressFormList.add(
        FromTypeModel(
          key: "ISSAME",
          name: 'Same as Permanent Address',
          fromType: FromType.checkBox,
          isEditable: true,
          min: 1,
          selectedValue: false,
        ),
      );
    }

    permanentAddressFormList.forEach((element) {
      element.textEditingController = TextEditingController();
    });
    return permanentAddressFormList;
  }

  static List<FromTypeModel> subscriptionDetails() {
    List<FromTypeModel> permanentAddressFormList = [];

    permanentAddressFormList.add(
      FromTypeModel(
        key: "DEU",
        name: 'Desired Username',
        fromType: FromType.textField,
        min: 5,
        max: 64,
        preFix: const Text(
          "kfon.",
          style: TextStyle(color: Colors.black),
        ),
        require: true,
      ),
    );

    permanentAddressFormList.add(
      FromTypeModel(
        key: "USAV",
        name: '',
        fromType: FromType.userAvailable,
      ),
    );
    permanentAddressFormList.add(
      FromTypeModel(
        key: "SPLTY",
        name: 'Plan Type',
        fromType: FromType.dropDown,
        isEditable: true,
        require: true,
      ),
    );
    permanentAddressFormList.add(
      FromTypeModel(
        key: "SEP",
        name: 'Selected Package',
        fromType: FromType.textField,
        isEditable: false,
        min: 1,
        require: true,
      ),
    );
    permanentAddressFormList.add(
      FromTypeModel(
        key: "AVPL",
        name: 'Available Plans',
        fromType: FromType.selectPlan,
        isEditable: false,
        min: 1,
      ),
    );
    permanentAddressFormList.forEach((element) {
      element.textEditingController = TextEditingController();
    });
    return permanentAddressFormList;
  }

  static List<FromTypeModel> deviceDetails() {
    List<FromTypeModel> deviceDetailsFormList = [];

    deviceDetailsFormList.add(
      FromTypeModel(
        key: "DEPR",
        name: 'Device Provider',
        fromType: FromType.dropDown,
        min: 1,
      ),
    );
    deviceDetailsFormList.add(
      FromTypeModel(
        key: "DETY",
        name: 'Device Type',
        fromType: FromType.dropDown,
        min: 1,
      ),
    );

    deviceDetailsFormList.add(
      FromTypeModel(
        key: "DEMK",
        name: 'Device Make',
        fromType: FromType.textField,
        isEditable: true,
        min: 1,
      ),
    );
    deviceDetailsFormList.add(
      FromTypeModel(
        key: "DEMO",
        name: 'Device Model',
        fromType: FromType.textField,
        isEditable: true,
        min: 1,
      ),
    );
    deviceDetailsFormList.add(
      FromTypeModel(
        key: "DEMAA",
        name: 'Device Mac Address',
        fromType: FromType.textField,
        isEditable: true,
        min: 1,
      ),
    );

    deviceDetailsFormList.add(
      FromTypeModel(
        key: "OLTTY",
        name: 'OLT Type',
        fromType: FromType.dropDown,
        min: 1,
      ),
    );

    deviceDetailsFormList.forEach((element) {
      element.textEditingController = TextEditingController();
    });
    return deviceDetailsFormList;
  }

  static List<FromTypeModel> supportDoc() {
    List<FromTypeModel> deviceDetailsFormList = [];

    deviceDetailsFormList.add(
      FromTypeModel(
        key: "AFC",
        name: 'Application Form Copy',
        fromType: FromType.fileUpload,
        min: 1,
        filed: ["Type", "ID"],
        filedStatus: [false, false],
        showCase: [
          [1],
          [1, 2, 3]
        ],
      ),
    );
    deviceDetailsFormList.add(
      FromTypeModel(
        key: "RPC",
        name: 'Residence Proof Copy',
        fromType: FromType.fileUpload,
        min: 1,
        filed: ["Type", "ID"],
        filedStatus: [true, true],
      ),
    );

    deviceDetailsFormList.add(
      FromTypeModel(
        key: "IPC",
        name: 'Identity Proof Copy',
        fromType: FromType.fileUpload,
        min: 1,
        filed: ["Type", "ID"],
        filedStatus: [true, true],
        showCase: [
          [1],
          [1, 2, 3]
        ],
      ),
    );

    deviceDetailsFormList.add(
      FromTypeModel(
          key: "GSPC",
          name: 'GSTIN Proof Copy',
          fromType: FromType.fileUpload,
          min: 1,
          filed: ["Type", "ID"],
          filedStatus: [false, false],
          isRequired: false),
    );
    deviceDetailsFormList.add(
      FromTypeModel(
          key: "PPC",
          name: 'Pan Proof Copy',
          fromType: FromType.fileUpload,
          min: 1,
          filed: ["Type", "ID"],
          filedStatus: [false, false],
          isRequired: false),
    );
    deviceDetailsFormList.forEach((element) {
      element.textEditingController = TextEditingController();
    });
    return deviceDetailsFormList;
  }

  static List<FromTypeModel> gstInformation() {
    List<FromTypeModel> gstInformationFormList = [];

    List<DropDownDataModel> locationType = [];
    locationType.add(
      DropDownDataModel(value: 'Yes', key: '1', id: '1'),
    );
    locationType.add(
      DropDownDataModel(value: 'No', key: '2', id: '2'),
    );
    gstInformationFormList.add(
      FromTypeModel(
        key: "GSTIA",
        name: 'GST Information to be added',
        fromType: FromType.radioButton,
        isEditable: true,
        min: 1,
        dropDownDataModel: locationType,
      ),
    );

    gstInformationFormList.add(
      FromTypeModel(
        key: "GSPA",
        name: 'Pan',
        fromType: FromType.textField,
        min: 10,
        max: 10,
        showFiledCount: false,
        isVisible: false,
      ),
    );
    List<TextEditingController> listFiled = [];
    for (var i = 0; i < 5; i++) {
      listFiled.add(TextEditingController());
    }
    gstInformationFormList.add(
      FromTypeModel(
        key: "GSTIN",
        name: 'GSTIN',
        fromType: FromType.groupTextFiled,
        filed: ["32", "", "", "Z", ""],
        filedStatus: [false, false, true, false, true],
        fileSize: [10, 50, 10, 10, 10],
        filedLength: [2, 10, 1, 1, 1],
        filedController: listFiled,
        isVisible: false,
      ),
    );

    gstInformationFormList.add(
      FromTypeModel(
        key: "TAXPY",
        name: 'TAX-PAYER Type',
        fromType: FromType.textField,
        isEditable: false,
        isVisible: false,
      ),
    );

    gstInformationFormList.add(
      FromTypeModel(
        key: "LNOB",
        name: 'Legal Name of Business',
        fromType: FromType.textField,
        isEditable: false,
        isVisible: false,
      ),
    );

    gstInformationFormList.add(
      FromTypeModel(
        key: "TRAN",
        name: 'Trade Name',
        fromType: FromType.textField,
        isEditable: false,
        isVisible: false,
      ),
    );

    gstInformationFormList.forEach((element) {
      element.textEditingController = TextEditingController();
    });
    return gstInformationFormList;
  }

  static void createForm(List<Item> dataExpend) {
    dataExpend.add(
      Item(
        id: 0,
        expandedValue: createFormPersonnelDetails(),
        headerValue: "Personnel Details",
        isExpanded: true,
      ),
    );

    dataExpend.add(
      Item(
        id: 1,
        expandedValue: createFormPermanentAddress(),
        headerValue: "Permanent Address Details",
      ),
    );
    dataExpend.add(
      Item(
        id: 2,
        expandedValue: createFormPermanentAddress(isInstallation: true),
        headerValue: "Installation Address Details",
      ),
    );
    dataExpend.add(
      Item(
        id: 3,
        expandedValue: subscriptionDetails(),
        headerValue: "Subscription Details",
      ),
    );
    dataExpend.add(
      Item(
        id: 4,
        expandedValue: deviceDetails(),
        headerValue: "Device Details",
      ),
    );
    dataExpend.add(
      Item(
        id: 5,
        expandedValue: supportDoc(),
        headerValue: "Supporting Documents",
      ),
    );
    dataExpend.add(
      Item(
        id: 6,
        expandedValue: gstInformation(),
        headerValue: "GST Information",
      ),
    );
  }
}

class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  int id;
  List<FromTypeModel> expandedValue;
  String headerValue;
  bool isExpanded;
}

class EmptyFiledModel {
  EmptyFiledModel({
    required this.key,
    required this.error,
    required this.value,
    required this.mainIndex,
  });

  String key;
  String? error;
  dynamic value;
  int mainIndex;

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'error': error,
      'value': value,
      "mainIndex": mainIndex,
    };
  }
}
