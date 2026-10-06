import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/local_providers/local_provider.dart';
import '../utils/global_functions.dart';
import '../utils/global_variables.dart';
import '../utils/page_bg.dart';
import '../utils/routes.dart';
import '../utils/style.dart';
import '../widget/global_loader/global_loading_dialog.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  late LocaleProvider localeProvider;

  @override
  void initState() {
    super.initState();
    localeProvider = context.read<LocaleProvider>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageBG(
        showBG: true,
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  "Welcome to",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/images/splash_logo.png",
                height: 80,
                width: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Are you an existing Partner?",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonClick("Click Here", () {
                    localeProvider.navigate(AppRoutes.LOGIN);
                  }, true),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  "Are you want to be a Partner?",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttonClick(
                    "FAQ",
                    () {
                      launchInBrowser(
                        faqUrl,
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    false,
                  ),
                  buttonClick(
                    "Register",
                    () async {
                      launchInBrowser(
                        registerUrl,
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonClick(String title, Function onclick, bool isTop) {
    return SizedBox(
      width: isTop ? null : 130,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            onclick();
          },
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          )),
    );
  }
}
