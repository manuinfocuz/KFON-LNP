import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/local_providers/local_provider.dart';
import '../../utils/global_functions.dart';
import '../../utils/page_bg.dart';
import '../../utils/style.dart';
import '../../widget/utils_widgets/custom_button.dart';

class SubOtpScreen extends StatefulWidget {
  const SubOtpScreen({
    super.key,
    required this.username,
    required this.password, required this.mobile,
  });

  final String username;
  final String password;
  final String mobile;

  @override
  State<SubOtpScreen> createState() => _SubOtpScreenState();
}

class _SubOtpScreenState extends State<SubOtpScreen> {
  final TextEditingController pinEditingController = TextEditingController();
  static const int pinLength = 6;

  final LocaleProvider _localeProvider = Get.find();

  int _seconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _seconds = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: pageBG(
              showBG: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splash_logo.png',
                    width: 150,
                  ),
                  const SizedBox(height: 25),

                  Text(
                    "OTP Verification",
                    style: appStylishTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        widget.mobile,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 45),
                    child: PinCodeTextField(
                      appContext: context,
                      length: pinLength,
                      controller: pinEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {},
                      onChanged: (_) {},
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        inactiveColor: Colors.grey,
                        activeColor: dangerColor,
                        selectedColor: accentColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 85),
                    child: CustomButton(
                      isLoad: provider.isLoading,
                      title: 'Login',
                      onClickFunction: () async {
                        if (pinEditingController.text.length == pinLength) {
                          // _timer?.cancel();
                          await provider.verifyOtpLogin(
                            _localeProvider,
                            widget.username,
                            widget.password,
                            pinEditingController.text,
                          );

                        } else {
                          GlobalFunctions.showToast(
                            "Please enter valid OTP",
                            false,
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Go Back"),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive code?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 6),

                      TextButton(
                        onPressed: _seconds == 0
                            ? () async {
                                  pinEditingController.clear();
                                  startTimer();
                                  final resp = await provider.sendOtpLogin(
                                    _localeProvider,
                                    widget.username,
                                    widget.password,
                                  );
                                  if (resp!=null) {
                                    startTimer();
                                  }
                                }
                            : null,
                        child: Text(
                          "Resend",
                          style: TextStyle(
                            fontSize: 14,
                            color: _seconds == 0
                                ? Colors.deepPurple
                                : Colors.black54,
                            fontWeight: _seconds == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),

                      const SizedBox(width: 4),

                      // Timer
                      if (_seconds > 0)
                        Text(
                          "00:${_seconds.toString().padLeft(2, '0')}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
