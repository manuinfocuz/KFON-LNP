import 'package:flutter/material.dart';

import '../../../models/form_type_model.dart';
import '../../../providers/subscriber/sub_create_provider.dart';
import '../../../utils/style.dart';
import '../../../widget/form_widgets/from_upload.dart';

class DocUpload extends StatefulWidget {
  final SubCreateProvider subCreateProvider;
  final String caf;
  final String profileID;
  final bool isOnlyView;

  const DocUpload({
    super.key,
    required this.subCreateProvider,
    required this.caf,
    required this.profileID,
    this.isOnlyView = false,
  });

  @override
  State<DocUpload> createState() => _DocUploadState();
}

class _DocUploadState extends State<DocUpload> {
  var isAnyTrue = false;
  @override
  void initState() {
    isAnyTrue = widget.caf == "1" ||
        !(widget.caf == "2" && widget.subCreateProvider.isSameAsPermanent) ||
        widget.caf == "1" ||
        widget.subCreateProvider.gstinModel?.taxpayertype == "2";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget.subCreateProvider.supportResidenceCopyDropDown.clear();
    // widget.subCreateProvider.supportIDCopyDropDown.clear();
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            isAnyTrue ? "Supporting Documents" : "",
            style: appTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (widget.caf == "1")
            Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                FormUpload(
                  maxSize: 4,
                  subCreateProvider: widget.subCreateProvider,
                  title: 'Application Form Copy',
                  showTypePicker: false,
                  showIdNumber: false,
                  selectedPath:
                      widget.subCreateProvider.selectedApplicationCopy,
                  dropDownSelected: "",
                  dropDownSelectedID: '',
                  callBackValuedDropDown: () {},
                  onDocPicked: (String? value) {
                    widget.subCreateProvider.selectedApplicationCopy = value;
                    setState(() {});
                  },
                  isRequired: true,
                  isOnlyView: widget.isOnlyView,
                ),
              ],
            ),
          widget.caf == "2" && widget.subCreateProvider.isSameAsPermanent
              ? const SizedBox()
              : Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    FormUpload(
                      maxSize: 4,
                      textEditingController:
                          widget.subCreateProvider.residenceController,
                      dropDownData:
                          widget.subCreateProvider.supportResidenceCopyDropDown,
                      subCreateProvider: widget.subCreateProvider,
                      title: 'Residence Proof Copy ',
                      showTypePicker: true,
                      showIdNumber: true,
                      selectedPath:
                          widget.subCreateProvider.selectedResidenceCopy,
                      dropDownSelected:
                          widget.subCreateProvider.selectedSupportRes,
                      dropDownSelectedID:
                          widget.subCreateProvider.selectedSupportResID,
                      callBackValuedDropDown: () async {
                        if (widget.subCreateProvider
                                .supportResidenceCopyDropDown.isEmpty ||
                            widget.subCreateProvider.supportIDCopyDropDown
                                .isEmpty) {
                          await widget.subCreateProvider.getSupDocList();
                          return widget
                              .subCreateProvider.supportResidenceCopyDropDown;
                        }
                      },
                      callBackDropDownClick: (DropDownDataModel value) {
                        widget.subCreateProvider.selectedSupportRes =
                            value.value;
                        widget.subCreateProvider.selectedSupportResID =
                            value.id;
                        setState(() {});
                      },
                      onDocPicked: (String? value) {
                        widget.subCreateProvider.selectedResidenceCopy = value;
                        setState(() {});
                      },
                      isRequired: true,
                      isOnlyView: widget.isOnlyView,
                    ),
                  ],
                ),
          if (widget.caf == "1")
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                FormUpload(
                  maxSize: 4,
                  textEditingController:
                      widget.subCreateProvider.idProofController,
                  dropDownData: widget.subCreateProvider.supportIDCopyDropDown,
                  subCreateProvider: widget.subCreateProvider,
                  title: 'Identity Proof Copy',
                  showTypePicker: true,
                  showIdNumber: true,
                  selectedPath: widget.subCreateProvider.selectedIDProofCopy,
                  dropDownSelected:
                      widget.subCreateProvider.selectedSupportidID,
                  dropDownSelectedID:
                      widget.subCreateProvider.selectedSupportid,
                  callBackValuedDropDown: () async {
                    if (widget.subCreateProvider.supportResidenceCopyDropDown
                            .isEmpty ||
                        widget
                            .subCreateProvider.supportIDCopyDropDown.isEmpty) {
                      await widget.subCreateProvider.getSupDocList();
                      return widget.subCreateProvider.supportIDCopyDropDown;
                    }
                  },
                  callBackDropDownClick: (DropDownDataModel value) {
                    widget.subCreateProvider.selectedSupportid = value.value;
                    widget.subCreateProvider.selectedSupportidID = value.id;
                    setState(() {});
                  },
                  onDocPicked: (String? value) {
                    widget.subCreateProvider.selectedIDProofCopy = value;
                    setState(() {});
                  },
                  isRequired: true,
                  isOnlyView: widget.isOnlyView,
                ),
              ],
            ),
        //  if (widget.subCreateProvider.isGSTINAdd.value)
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                FormUpload(
                  maxSize: 4,
                  subCreateProvider: widget.subCreateProvider,
                  title: 'GSTIN Proof Copy',
                  showTypePicker: false,
                  showIdNumber: false,
                  selectedPath: widget.subCreateProvider.GSTINProofCopy,
                  dropDownSelected: "",
                  dropDownSelectedID: '',
                  callBackValuedDropDown: () {},
                  onDocPicked: (String? value) {
                    widget.subCreateProvider.GSTINProofCopy = value;
                    setState(() {});
                  },
                  isRequired: widget.subCreateProvider.isGSTINAdd.value,
                  isOnlyView: widget.isOnlyView,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormUpload(
                  maxSize: 4,
                  subCreateProvider: widget.subCreateProvider,
                  title: 'Pan Proof Copy',
                  showTypePicker: false,
                  showIdNumber: false,
                  selectedPath: widget.subCreateProvider.panProofCopy,
                  dropDownSelected: "",
                  dropDownSelectedID: '',
                  callBackValuedDropDown: () {},
                  onDocPicked: (String? value) {
                    widget.subCreateProvider.panProofCopy = value;
                    setState(() {});
                  },
                  isRequired: widget.subCreateProvider.isGSTINAdd.value,
                  isOnlyView: widget.isOnlyView,
                ),
              ],
            ),
          if (widget.caf == "2" &&
              widget.subCreateProvider.isSameAsPermanent &&
              !widget.subCreateProvider.isGSTINAdd.value)
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Documents no need"),
              ],
            ),
        //  if (widget.subCreateProvider.gstinModel?.taxpayertype == "2")
            FormUpload(
              maxSize: 4,
              subCreateProvider: widget.subCreateProvider,
              title: 'LUT (Letter of Undertaking) Mandatory for SEZ',
              showTypePicker: false,
              showIdNumber: false,
              selectedPath: widget.subCreateProvider.lutLetter,
              dropDownSelected: "",
              dropDownSelectedID: '',
              callBackValuedDropDown: () {},
              onDocPicked: (String? value) {
                widget.subCreateProvider.lutLetter = value;
                setState(() {});
              },
              isRequired:
                  widget.subCreateProvider.gstinModel?.taxpayertype == "2",
            ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
