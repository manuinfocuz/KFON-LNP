import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../utils/style.dart';
import '../../../widget/utils_widgets/custom_button.dart';
import '../../../widget/utils_widgets/custom_textfiled.dart';
import '../../providers/auth_provider.dart';
import '../../utils/global_functions.dart';
import '../../utils/page_bg.dart';

class SubForgetPassword extends StatefulWidget {
  const SubForgetPassword({super.key});

  @override
  State<SubForgetPassword> createState() => _SubForgetPasswordState();
}

class _SubForgetPasswordState extends State<SubForgetPassword> {
  ///text: "kfon.rahimtest2"
  ///text: "rahim1233"

  TextEditingController userNameEditingController = TextEditingController();

  TextEditingController pinController = TextEditingController();
  static const int pinLength = 6;

  String? userNameError;
  bool isOTP = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      builder: (context, provider) => Consumer<AuthProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            body: pageBG(
              showBG: false,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: size.height / 12,
                      ),
                      Image.asset(
                        "assets/images/splash_logo.png",
                        height: 100,
                        width: 180,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width / 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              inputType: TextInputType.emailAddress,
                              isEditable: !isOTP,
                              errorText: userNameError,
                              lableText: 'PartnerID',
                              isPassword: false,
                              onChangeText: (String value) {
                                userNameError = null;
                                setState(() {});
                              },
                              controller: userNameEditingController,
                            ),
                            if (isOTP)
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  PinCodeTextField(
                                    keyboardType: TextInputType.number,
                                    appContext: context,
                                    length: pinLength,
                                    controller: pinController,
                                    onChanged: (pin) {},
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(8),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      inactiveColor: Colors.grey,
                                      activeColor: primaryColor,
                                      selectedColor: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            if (isOTP)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      var finalData = await provider.sendOTP(
                                          userNameEditingController.text);
                                      if (finalData != null) {
                                        pinController.text = '';
                                        isOTP = true;
                                        setState(() {});
                                      }
                                    },
                                    child: Text(
                                      "Resend OTP",
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 10),
                              child: CustomButton(
                                isLoad: false,
                                title: !isOTP ? 'Send OTP' : "Verify OTP",
                                onClickFunction: () async {
                                  if (userNameEditingController.text.isEmpty) {
                                    userNameError = "PartnerID can't be empty";
                                  } else {
                                    userNameError = null;
                                  }

                                  setState(() {});

                                  if (userNameError != null) {
                                    return;
                                  }

                                  if (isOTP) {
                                    if (pinController.text.length < 6) {
                                      GlobalFunctions.showToast(
                                        "OTP must be 6 digit",
                                        false,
                                      );
                                      setState(() {});
                                      return;
                                    }
                                    var finalData = await provider.verifyOTP(
                                      userNameEditingController.text,
                                      pinController.text,
                                    );
                                    if (finalData != null) {
                                      setState(() {});
                                      Get.back();
                                    }
                                  } else {
                                    var finalData = await provider.sendOTP(
                                        userNameEditingController.text);
                                    if (finalData != null) {
                                      isOTP = true;

                                      setState(() {});
                                    }
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Go Back"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
