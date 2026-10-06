import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/app_matrix.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/view/auth_screens/sub_otp_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/auth_provider.dart';
import '../../utils/api_end_points.dart';
import '../../utils/global_functions.dart';
import '../../utils/global_variables.dart';
import '../../utils/routes.dart';
import '../../widget/utils_widgets/custom_button.dart';
import '../../widget/utils_widgets/custom_textfiled.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? pwError;
  String? unError;
  final LocaleProvider _localeProvider = Get.find();
  bool isTryingUAT = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      builder: (context, provider) => Consumer<AuthProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: AppMatrix.availableHeight(
                      context: context,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onDoubleTap: () {
                                AppEndPoints.isLive = false;
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 50, bottom: 20),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/splash_logo.png',
                                    // Replace with your logo image asset
                                    width: 150,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            CustomTextField(
                              errorText: unError,
                              lableText: 'Username',
                              isPassword: false,
                              onChangeText: (String value) {
                                unError = null;
                                setState(() {});
                              },
                              controller: provider.userNameEditingController,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              errorText: pwError,
                              lableText: 'Password',
                              isPassword: true,
                              onChangeText: (String value) {
                                pwError = null;
                                setState(() {});
                              },
                              controller: provider.passwordEditingController,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: CustomButton(
                                isLoad: provider.isLoading,
                                title: 'Send OTP',
                                onClickFunction: () async {
                                  AppEndPoints.isLive = true;
                                  onLoginPress(provider);
                                },
                                onLongClick: () {
                                  if (!AppEndPoints.isLive) {
                                    GlobalFunctions.showToast(
                                      "Enter UAT",
                                      false,
                                    );
                                    onLoginPress(provider);
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
                                  onPressed: ()  {
                                     _localeProvider.navigate(
                                      AppRoutes.SUBFORGETPASSWORD,
                                    ) ?.then((_) {
                                        provider.userNameEditingController.clear();
                                        provider.passwordEditingController.clear();
                                        setState(() {});
                                      });
                                  }, // Changed it here.
                                  child: const Text("Forgot Password?"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Divider(),
                            const SizedBox(
                              height: 15,
                            ),
                            const Center(
                              child: Text(
                                "Are you want to be a Partner?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomButton(
                              isBorderButton: true,
                              fontColor: primaryColor,
                              buttonColor: primaryColor,
                              isLoad: provider.isLoading,
                              title: 'LNP Enquiry',
                              onClickFunction: () {
                                launchInBrowser(
                                  registerUrl,
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // CustomButton(
                            //   isBorderButton: true,
                            //   fontColor: Colors.green,
                            //   buttonColor: Colors.green,
                            //   isLoad: provider.isLoading,
                            //   title: 'FAQ',
                            //   onClickFunction: () {
                            //     launchInBrowser(
                            //       faqUrl,
                            //       mode: LaunchMode.inAppWebView,
                            //     );
                            //   },
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildAppVersionText(),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onLoginPress(AuthProvider provider) {
    if (provider.userNameEditingController.text.isEmpty) {
      unError = "Username can't be empty";
    } else {
      unError = null;
    }

    if (provider.passwordEditingController.text.isEmpty) {
      pwError = "Password can't be empty";
    } else {
      pwError = null;
    }

    setState(() {});

    if (provider.userNameEditingController.text.isEmpty ||
        provider.passwordEditingController.text.isEmpty) {
      return;
    }

    provider.sendOtpLogin(
      _localeProvider,
      provider.userNameEditingController.text,
      provider.passwordEditingController.text,
    );
  }
}
