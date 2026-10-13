import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/auth/login_data_model.dart';
import 'package:kfon_lnp/repository/auth_repository.dart';
import 'package:kfon_lnp/widget/global_loader/global_loading_dialog_controller.dart';

import '../data_model/message_model.dart';
import '../data_model/auth/remembered_login_model.dart';
import '../repository/remembered_login_repository.dart';
import '../utils/global_functions.dart';
import '../utils/global_variables.dart';
import '../utils/pref_keys.dart';
import '../utils/routes.dart';
import 'local_providers/local_provider.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  final RememberedLoginRepository _rememberedLoginRepository =
      RememberedLoginRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isError = false;

  bool get isError => _isError;

  set setIsError(bool value) {
    _isError = value;
    notifyListeners();
  }

  Future<dynamic> callGetToken(
      LocaleProvider localeProvider, String username, String password,
      {bool isAuto = false, bool canNavigate = true}) async {
    print('>>>>>>>call =token');
    if (!isAuto) {
      GlobalLoadingDialogController.openDialog();
      print('>>>>>>  function');
    }

    var tokenData = await _authRepository.getTokeKey();

    if (tokenData != null) {
      tokenTemp = tokenData.token;
      var loginData = await _authRepository.reLoginCheck(username, password);
      print('>>>>>> calllogin');
      //  var loginData = LoginDataModel(
      //    message: '',
      //    partnername: 'KSITIL',
      //    ptype: '4637487398',
      //    partnerid: '4637487398',
      //    password: '4637487398',
      //    status: true,
      //  );

      if (loginData != null) {
        print('>.>>>>>> login data');
        loginData as LoginDataModel;
        loginData.password = password;
        localeProvider.sharedPref.setMap(
          PrefKeys.LOGINDATA,
          loginData.toJson(),
        );
        globalLoginModel = loginData;
        localeProvider.sharedPref.setBool(PrefKeys.ISLOGIN, true);
        await localeProvider.getSetProfile(isFirst: canNavigate);
        print('>>>>>>   above navigate');

        if (canNavigate) localeProvider.navigateDeleteAll(AppRoutes.HOMESCREEN);
        localeProvider.startTimer();
        return loginData;
      } else {
        if (globalLoginModel != null) {
          localeProvider.doLogout();
        }
      }
    } else {
      if (globalLoginModel != null) {
        localeProvider.doLogout();
      }
    }
    if (!isAuto) {
      GlobalLoadingDialogController.closeDialog();
    }
  }

  Future<dynamic> verifyOtpLogin(LocaleProvider localeProvider, String username,
      String password, String otp,
      {bool isAuto = false,
      bool canNavigate = true,
      bool rememberMe = false}) async {
    if (!isAuto) {
      GlobalLoadingDialogController.openDialog();
      print('>>>>>>  function');
    }

    var tokenData = await _authRepository.getTokeKey();

    if (tokenData != null) {
      tokenTemp = tokenData.token;
      var loginData =
          await _authRepository.verifyOtpForLogin(username, password, otp);
      // GlobalLoadingDialogController.openDialog();
      //  var loginData = LoginDataModel(
      //    message: '',
      //    partnername: 'KSITIL',
      //    ptype: '4637487398',
      //    partnerid: '4637487398',
      //    password: '4637487398',
      //    status: true,
      //  );

      if (loginData != null) {
        print('>.>>>>>> login data');
        loginData as LoginDataModel;
        loginData.password = password;
        localeProvider.sharedPref.setMap(
          PrefKeys.LOGINDATA,
          loginData.toJson(),
        );
        globalLoginModel = loginData;
        localeProvider.sharedPref.setBool(PrefKeys.ISLOGIN, true);
        // OTP is verified here: save, or refresh a stale saved password.
        debugPrint('[RememberMe] OTP verified for $username, rememberMe=$rememberMe');
        try {
          if (rememberMe) {
            await _rememberedLoginRepository.save(username, password);
          } else {
            await _rememberedLoginRepository.refreshIfRemembered(
                username, password);
          }
          debugPrint('[RememberMe] save step finished');
        } catch (e, st) {
          debugPrint('[RememberMe] save FAILED: $e\n$st');
        }
        await localeProvider.getSetProfile(isFirst: true);
        GlobalLoadingDialogController.closeDialog();
        localeProvider.navigateDeleteAll(AppRoutes.HOMESCREEN);
        localeProvider.startTimer();
        return loginData;
      } else {
        debugPrint('[RememberMe] OTP verification failed, nothing saved');
        // Handle wrong OTP case
        GlobalLoadingDialogController.closeDialog();
        GlobalFunctions.showToast(
            'Invalid OTP. Please Enter correct OTP.', false);
        return null;
      }
    } else {
      GlobalLoadingDialogController.openDialog();
      if (globalLoginModel != null) {
        localeProvider.doLogout();
      }
    }
  }

  Future<List<RememberedLogin>> getRememberedLogins() async {
    try {
      final logins = await _rememberedLoginRepository.getAll();
      debugPrint('[RememberMe] loaded ${logins.length} saved login(s)');
      return logins;
    } catch (e, st) {
      debugPrint('[RememberMe] load FAILED: $e\n$st');
      return [];
    }
  }

  Future<void> deleteRememberedLogin(String username) {
    debugPrint('[RememberMe] deleting saved login $username');
    return _rememberedLoginRepository.remove(username);
  }

  Future<dynamic> sendOtpLogin(
      LocaleProvider localeProvider, String userName, String password,
      {bool rememberMe = false}) async {
    var otpStatus;
    GlobalLoadingDialogController.openDialog();
    var tokenData = await _authRepository.getTokeKey();

    if (tokenData != null) {
      tokenTemp = tokenData.token;
      otpStatus = await _authRepository.sendOtpForLogin(userName, password);
      GlobalLoadingDialogController.closeDialog();
      if (otpStatus != null) {
        print('>>>>>>>>> hello');
        // otpStatus as MessageModel;
        GlobalLoadingDialogController.closeDialog();
        // // Close loading dialog before showing toast and navigating
        GlobalFunctions.showToast(otpStatus.message, true);
        GlobalLoadingDialogController.closeDialog();
        debugPrint('[RememberMe] sendOtpLogin ok, opening OTP screen with rememberMe=$rememberMe');
        localeProvider.navigate(AppRoutes.SUBOTPSCREEN,
            argument: [userName, password, otpStatus.messageToDisplay, rememberMe])?.then((value) {
          userNameEditingController.clear();
          passwordEditingController.clear();
        });
      }
      return otpStatus;
    }
    Get.back();
    return otpStatus!;
  }

  Future<dynamic> sendOTP(String userName) async {
    var otpStatus;
    GlobalLoadingDialogController.openDialog();
    var tokenData = await _authRepository.getTokeKey();
    tokenTemp = tokenData.token;

    if (tokenData != null) {
      otpStatus = await _authRepository.sendOTP(userName);
      if (otpStatus != null) {
        otpStatus as MessageModel;

        GlobalFunctions.showToast(otpStatus.message, true);
      }
    }

    Get.back();
    return otpStatus;
  }

  Future<dynamic> verifyOTP(String userName, String otp) async {
    GlobalLoadingDialogController.openDialog();
    var tokenData = await _authRepository.getTokeKey();
    tokenTemp = tokenData.token;

    if (tokenData != null) {
      var otpStatus = await _authRepository.verifyOTP(userName, otp);
      if (otpStatus != null) {
        otpStatus as MessageModel;
        Get.back();
        GlobalFunctions.showToast(otpStatus.message, true);
      }
    }

    Get.back();
  }
}
