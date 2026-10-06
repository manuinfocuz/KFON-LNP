import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/auth/login_data_model.dart';
import 'package:kfon_lnp/utils/pref_keys.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:provider/provider.dart';
import '../helper/appupdate_helper.dart';
import '../providers/auth_provider.dart';
import '../providers/local_providers/local_provider.dart';
import '../utils/global_functions.dart';
import '../utils/global_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  LocaleProvider localeProvider = Get.find();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animationController.addStatusListener((status) {
      // if (status == AnimationStatus.completed) {
      //   localeProvider.navigateDeleteAll(AppRoutes.LOGIN);
      // }
    });

    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 10), () {
       checkUpdateBeforeNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 290,),
          Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animationController.value,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/splash_logo.png',
                width: size.width - 100,
              ), // Replace with your logo image
            ),
          ),
          Spacer(),
          buildAppVersionText(),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }

   @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  checkUpdateBeforeNavigate() async {
    try {
      var updateHelper = AppUpdateHelper();

      if (updateHelper.checkForUpdate(callBack: checkAll)) {
        print("in");
        return;
      }

      checkAll();
    } catch (e) {
      print(e);
      checkAll();
    }
  }

  void checkLogin() async {
    var isLogin = await localeProvider.sharedPref.getBool(PrefKeys.ISLOGIN);

    if (isLogin) {
      var loginData =
          await localeProvider.sharedPref.getMap(PrefKeys.LOGINDATA);
      if (loginData.isNotEmpty) {
        globalLoginModel = LoginDataModel.fromJson(loginData);
        if (mounted) {
          var authProvider = context.read<AuthProvider>();
          await authProvider.callGetToken(
            localeProvider,
            globalLoginModel!.partnerid,
            globalLoginModel!.password,
            isAuto: true,
          );
        }

        return;
      } else {
        clearAskLogout();
      }
    } else {
      clearAskLogout();
    }
  }

  void clearAskLogout() {
    localeProvider.navigateDeleteAll(AppRoutes.LOGIN);
    localeProvider.sharedPref.clear();
  }

//4637487398
  void checkAll() async {
    await localeProvider.init();
    Future.delayed(const Duration(milliseconds: 10), () {
      try {
        checkLogin();
      } catch (e) {
        clearAskLogout();
      }
    });
  }
}
