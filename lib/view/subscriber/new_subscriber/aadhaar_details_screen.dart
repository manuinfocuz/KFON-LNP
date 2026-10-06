import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';
import 'package:kfon_lnp/providers/auth_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/widget/utils_widgets/globalAppBar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../data_model/subscriber/aadharDetailsModel.dart';
import '../../../helper/validate_helper.dart';
import '../../../providers/local_providers/local_provider.dart';
import '../../../providers/subscriber/aadharValidateProvider.dart';
import '../../../utils/style.dart';
import '../../../widget/utils_widgets/custom_button.dart';
import '../../../widget/utils_widgets/custom_textfiled.dart';

var tag = "Aadhaar screen";

class AadhaarDetailsScreen extends StatefulWidget {
  final String cafID;
  final String profileID;
  final String? title;
  const AadhaarDetailsScreen({
    super.key,
    required this.cafID,
    required this.profileID,
    this.title,
  });

  @override
  State<AadhaarDetailsScreen> createState() => _AadhaarDetailsScreenState();
}

class _AadhaarDetailsScreenState extends State<AadhaarDetailsScreen> {
  TextEditingController aadhaarNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailIDController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String? aadharError;
  String? mobileNoError;
  String? emailIDError;

  bool isBillingPasswordEnabled = true;
  bool isInternetPasswordEnabled = false;
  String selectedOption = "1";

  final LocaleProvider _localeProvider = LocaleProvider();
  Timer? timer;
  int secondsRemaining = 60;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AadharValidateProvider(),
      builder: (context, snap) => Consumer<AadharValidateProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            body: Scaffold(
              appBar: globalAppBar("Aadhaar EKYC"),
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

                                IndexedStack(
                                  index: provider.aadharOtpSentDataModel == null
                                      ? 0
                                      : 1,
                                  children: [
                                    Column(
                                      children: [
                                        CustomTextField(
                                          inputType: TextInputType.number,
                                          errorText: aadharError,
                                          lableText: "Aadhaar Number",
                                          isPassword: false,
                                          onChangeText: (e) {
                                            aadharError = null;
                                            setState(() {});
                                          },
                                          controller: aadhaarNumberController,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CustomTextField(
                                          maxLength: 10,
                                          inputType: const TextInputType
                                              .numberWithOptions(),
                                          errorText: mobileNoError,
                                          lableText: "Mobile Number",
                                          isPassword: false,
                                          onChangeText: (e) {
                                            mobileNoError = null;
                                            setState(() {});
                                          },
                                          controller: mobileNumberController,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CustomTextField(
                                          inputType: TextInputType.emailAddress,
                                          errorText: emailIDError,
                                          lableText: "Email",
                                          isPassword: false,
                                          onChangeText: (e) {
                                            emailIDError = null;
                                            setState(() {});
                                          },
                                          controller: emailIDController,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(
                                          "OTP has been sent to registered mobile number",
                                          style: appTextStyle(fontSize: 13),
                                        ),
                                        const SizedBox(height: 20),
                                        PinCodeTextField(
                                          keyboardType: TextInputType.number,
                                          appContext: context,
                                          length: 6,
                                          controller: otpController,
                                          onChanged: (pin) {},
                                          pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            fieldHeight: 50,
                                            fieldWidth: 40,
                                            inactiveColor: Colors.grey,
                                            activeColor: primaryColor,
                                            selectedColor: accentColor,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            if (secondsRemaining == 0) {
                                              otpController.clear();
                                              var status =
                                                  await provider.sendOTP(
                                                aadhaarNumberController.text,
                                                emailIDController.text,
                                                mobileNumberController.text,
                                              );
                                              if (status) {
                                                startTimer();
                                              }

                                              setState(() {});
                                            }
                                          },
                                          child: Text(
                                            secondsRemaining == 0
                                                ? "OTP Not Get? "
                                                : "Resend OTP link will be enabled after $secondsRemaining Seconds",
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ],
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
                          title: provider.aadharOtpSentDataModel == null
                              ? 'Get OTP'
                              : "Verify OTP",
                          onClickFunction: () async {
                            // provider.aadharDetailsModel?.phone =
                            //     mobileNumberController.text;
                            // provider.aadharDetailsModel?.email =
                            //     emailIDController.text;
                            // _localeProvider.navigateDeleteLast(
                            //   AppRoutes.CREATESUBSCRIBER,
                            //   argument: [
                            //     widget.cafID,
                            //     widget.profileID,
                            //     provider.aadharDetailsModel,
                            //   ],
                            // );

                            // return;
                            if (provider.aadharOtpSentDataModel == null) {
                              aadharError = globalValidate(
                                  aadhaarNumberController.text,
                                  12,
                                  12,
                                  false,
                                  "Adadhar Number");

                              mobileNoError = globalValidate(
                                  mobileNumberController.text,
                                  10,
                                  10,
                                  false,
                                  "Mobile Number");

                              emailIDError = globalValidate(
                                  emailIDController.text, 0, 0, true, "Email");

                              if (aadharError == null &&
                                  mobileNoError == null &&
                                  emailIDError == null) {
                                otpController.clear();
                                await provider.sendOTP(
                                  aadhaarNumberController.text,
                                  emailIDController.text,
                                  mobileNumberController.text,
                                );
                                startTimer();
                              }
                            } else {
                              if (otpController.text.length != 6) {
                                GlobalFunctions.showToast(
                                    "Enter valid OTP", false);
                              } else {
                                var status = await provider
                                    .verifyOTP(otpController.text);
                                if (status) {
                                  _localeProvider.navigateDeleteLast(
                                    AppRoutes.CREATESUBSCRIBER,
                                    argument: [
                                      widget.cafID,
                                      widget.profileID,
                                      provider.aadharDetailsModel,
                                      widget.title,
                                    ],
                                  );
                                }
                              }
                            }

                            setState(() {});
                          },
                        ),
                      ),
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

  startTimer() {
    timer?.cancel();
    secondsRemaining = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {}
    });
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
