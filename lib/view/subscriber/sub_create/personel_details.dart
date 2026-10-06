import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';

import '../../../data_model/subscriber/aadharDetailsModel.dart';
import '../../../providers/subscriber/sub_create_provider.dart';
import '../../../utils/style.dart';
import '../../../widget/new_from_widget/date_picker_widget.dart';
import '../../../widget/new_from_widget/radio_from.dart';

class PersonalDetails extends StatefulWidget {
  final SubCreateProvider subCreateProvider;
  final String caf;
  final String profileID;
  final AadharDetailsModel? aadharDetailsModel;

  const PersonalDetails(
      {super.key,
      required this.subCreateProvider,
      required this.caf,
      required this.profileID,
      this.aadharDetailsModel});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Personal Details",
            style: appTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (widget.aadharDetailsModel == null)
            Column(
              children: [
                CustomTextField(
                  isEditable: false,
                  lableText: "Application Form No",
                  controller: widget.subCreateProvider.applicationNoController,
                  isRequired: true,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          if (widget.caf == "2" && widget.aadharDetailsModel != null)
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          child: CachedNetworkImage(
                              imageUrl:
                                  "${widget.aadharDetailsModel?.userImage}"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            "Aadhaar Address:",
                            style: appTextStyle(
                              color: primaryColor,
                              fontSize: 17,
                            ),
                          ),
                          Container(
                            width: size.width - 200,
                            child: Text(
                              "${widget.aadharDetailsModel?.doorno},${widget.aadharDetailsModel?.streetlo},${widget.aadharDetailsModel?.cityname},${widget.aadharDetailsModel?.pincode}",
                              style: appTextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          CustomTextField(
            isEditable: widget.caf == "1",
            inputType: TextInputType.name,
            lableText: widget.profileID == "1"
                ? "Applicant Name"
                : "Company Name will be reflected in Invoice",
            controller: widget.subCreateProvider.applicantNameController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            onTab: () {
              if (widget.caf == "2") {
                return;
              }
              datePickerWidget(
                (date) {
                  widget.subCreateProvider.dobController.text =
                      date?.formatDate(dateFormat: DateFormat('yyyy-MM-dd')) ??
                          "";
                },
              );
            },
            isEditable: false,
            lableText: "Date of Birth",
            controller: widget.subCreateProvider.dobController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          radioForm(
            "Gender",
            [
              ["Male", "1"],
              ["Female", "2"],
              ["Other", "3"],
            ],
            widget.subCreateProvider.selectedGender,
            widget.subCreateProvider,
            (value) {
              if (widget.caf == "2") {
                return;
              }
              widget.subCreateProvider.selectedGender = value;
              widget.subCreateProvider.notifyListeners();
            },
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            isEditable: widget.caf == "1",
            isPhone: true,
            inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            inputType: TextInputType.phone,
            lableText: "Mobile No",
            controller: widget.subCreateProvider.mobileController,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          if (widget.profileID == "2")
            Column(
              children: [
                CustomTextField(
                  isPhone: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  inputType: TextInputType.phone,
                  lableText: "Alternate Contact Number",
                  controller:
                      widget.subCreateProvider.alternativeMobileController,
                  isRequired: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  inputType: TextInputType.name,
                  lableText: "Contact Person",
                  controller:
                      widget.subCreateProvider.contactPersonNameController,
                  isRequired: true,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          CustomTextField(
            inputType: TextInputType.emailAddress,
            lableText: "Email Address",
            controller: widget.subCreateProvider.emailController,
            isRequired: true,
          ),
        ],
      ),
    );
  }
}
