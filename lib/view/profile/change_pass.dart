import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';
import 'package:kfon_lnp/providers/auth_provider.dart';
import 'package:kfon_lnp/widget/utils_widgets/globalAppBar.dart';
import 'package:provider/provider.dart';

import '../../providers/local_providers/local_provider.dart';
import '../../widget/utils_widgets/custom_button.dart';
import '../../widget/utils_widgets/custom_textfiled.dart';

var tag = "ChangePass";

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confrimPasswordController = TextEditingController();

  String? oldPassError;
  String? newPassError;
  String? confirmPassError;

  bool isBillingPasswordEnabled = true;
  bool isInternetPasswordEnabled = false;
  String selectedOption = "1";
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, provider, snap) => Scaffold(
        body: Scaffold(
          appBar: globalAppBar("Change Password"),
          body: Container(
            margin: const EdgeInsets.only(top: 140),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    width: double.infinity,
                    child: Card(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),

                            //  changeTypeWidget(),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              inputType: TextInputType.visiblePassword,
                              errorText: oldPassError,
                              lableText: "Old Password",
                              isPassword: true,
                              onChangeText: (e) {
                                oldPassError = null;
                                setState(() {});
                              },
                              controller: oldPasswordController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              inputType: TextInputType.visiblePassword,
                              errorText: newPassError,
                              lableText: "New Password",
                              isPassword: true,
                              onChangeText: (e) {
                                newPassError = null;
                                setState(() {});
                              },
                              controller: newPasswordController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              inputType: TextInputType.visiblePassword,
                              errorText: confirmPassError,
                              lableText: "Confirm Password",
                              isPassword: true,
                              onChangeText: (e) {
                                confirmPassError = null;
                                setState(() {});
                              },
                              controller: confrimPasswordController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: CustomButton(
                      title: 'Update password',
                      onClickFunction: () async {
                        if (oldPasswordController.text.isEmpty) {
                          oldPassError = "field_empty_error_message"
                              .i18n(["Old Password"]);
                        } else {
                          oldPassError = null;
                        }

                        if (newPasswordController.text.isEmpty) {
                          newPassError = "field_empty_error_message"
                              .i18n(["New Password"]);
                        } else {
                          newPassError = null;
                        }

                        if (confrimPasswordController.text.isEmpty) {
                          confirmPassError = "field_empty_error_message"
                              .i18n(["Confirm Password"]);
                        } else {
                          confirmPassError != null
                              ? confirmPassError = null
                              : null;
                        }

                        if (confrimPasswordController.text !=
                            newPasswordController.text) {
                          confirmPassError =
                              "New Password and confirm password must be same";
                        } else {
                          confirmPassError = null;
                        }
                        setState(() {});
                        if (oldPassError == null &&
                            confirmPassError == null &&
                            newPassError == null) {
                          await provider.changePassword(
                              oldPasswordController.text,
                              newPasswordController.text,
                              confrimPasswordController.text,
                              selectedOption);
                        }

                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget changeTypeWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioListTile(
          title: const Text('Portal Password'),
          value: '1',
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Internet Password'),
          value: '2',
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
        ),
      ],
    );
  }
}
