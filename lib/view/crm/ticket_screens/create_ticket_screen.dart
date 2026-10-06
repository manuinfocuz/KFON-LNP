import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfon_lnp/providers/ticket/ticket_provider.dart';
import 'package:kfon_lnp/providers/utlis/dynamic_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/view/crm/ticket_screens/ticket_list_screen.dart';
import 'package:kfon_lnp/widget/global_bottomsheet_widget.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_button.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';
import 'package:kfon_lnp/widget/utils_widgets/value_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/form_type_model.dart';
import '../../../utils/style.dart';
import '../../../widget/utils_widgets/globalAppBar.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

// provider: TicketProvider(type: 2),
class _CreateTicketScreenState extends State<CreateTicketScreen> {
  String? selectedIssue;
  String? selectedIssueID;
  TextEditingController descriptionController = TextEditingController();
  String? pickerImagePath;
  String? pickerImageName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicketProvider(type: 2),
      builder: (context, snap) => Consumer<TicketProvider>(
        builder: (BuildContext context, TicketProvider provider, snap) {
          return Scaffold(
            appBar: globalAppBar(
              "New Ticket",
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Submit a new ticket regarding LCO issues',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ValuePicker(
                      callback: () {
                        Get.bottomSheet(
                          GlobalBottomSheetWidget(
                            enableSearch: false,
                            title: "Select Subject",
                            listData: provider.listSubject,
                            dropDownValue: selectedIssueID ?? "",
                            onClick: (DropDownDataModel value) {
                              selectedIssueID = value.id;
                              selectedIssue = value.value;
                              provider.notifyListeners();
                            },
                          ),
                        );
                      },
                      selectedValue: selectedIssue ?? "Select Issue",
                      canClick: true,
                      hint: "",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      isAddress: true,
                      lableText: "Description",
                      controller: descriptionController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      title: pickerImagePath == null
                          ? "Choose File"
                          : "Remove Selected",
                      onClickFunction: () {
                        if (pickerImagePath == null) {
                          imagePicker(provider);
                        } else {
                          pickerImagePath = null;
                          pickerImageName = null;
                          provider.notifyListeners();
                        }
                      },
                      icon: pickerImagePath == null ? Icons.upload : Icons.cancel,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (pickerImagePath != null)
                      Image.file(
                        File("$pickerImagePath"),
                        height: 200,
                      ),
                    CustomButton(
                      title: "Save",
                      onClickFunction: () {
                        if (descriptionController.text
                                .removeExtraSpaces()
                                .isNotEmpty &&
                            selectedIssueID != null) {
                          provider.sendTicket(
                            "$selectedIssueID",
                            descriptionController.text,
                            pickerImagePath,
                            pickerImageName,
                          );
                        } else {
                          GlobalFunctions.showToast(
                            "Fill all required filed",
                            false,
                          );
                        }
                      },
                    ),
                    Text(
                      "*  Please upload files in the following formats: GIF, JPG, JPEG, PNG, PDF. The maximum allowed file size is 4MB.",
                      style: appTextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  imagePicker(TicketProvider provider) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    pickerImagePath = image?.path;
    pickerImageName = image?.name;
    provider.notifyListeners();
  }
}
