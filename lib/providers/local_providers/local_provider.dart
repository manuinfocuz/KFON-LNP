import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/auth/profile_data_model.dart';
import 'package:kfon_lnp/helper/db_helper.dart';
import 'package:kfon_lnp/repository/auth_repository.dart';

import '../../data_model/main_dashboard_model.dart';
import '../../data_model/message_model.dart';
import '../../repository/local_repository.dart';
import '../../services/notification_service.dart';
import '../../utils/global_functions.dart';
import '../../utils/global_variables.dart';
import '../../utils/pref_keys.dart';
import '../../utils/routes.dart';
import '../../utils/shared_pref.dart';
import '../../widget/global_loader/global_loading_dialog_controller.dart';
import '../auth_provider.dart';

class LocaleProvider with ChangeNotifier {
  int currentIndex = 0;
  int currentBottomNavIndex = 0;
  Timer? timer;
  Locale _locale = supportedLocalesList[0];
  final LocalRepository _localRepository = LocalRepository();
  final AuthRepository _authRepository = AuthRepository();
  bool _isload = false;

  bool get isload => _isload;

  Locale get locale => _locale;

  late SharedPreferencesLocal _sharedPref;

  SharedPreferencesLocal get sharedPref => _sharedPref;

  late DBHelper _dbHelper;

  DBHelper get dbHelper => _dbHelper;

  String? _fcmtoken = "";

  String? get fcmtoken => _fcmtoken;

  // final NotificationService _notificationService = NotificationService.instance;
  //
  // NotificationService get notificationService => _notificationService;
  final Connectivity _connectivity = Connectivity();
  var isint = false;

  var msgdata = {};
  BuildContext? mContext;
  final deviceInfoPlugin = DeviceInfoPlugin();
  late AndroidDeviceInfo androidInfo;
  late IosDeviceInfo iosInfo;

  ProfileDataModel? profileDataModel;
  MainDashBoardModel? mainDashBoardModel;

  bool homeLoad = false;
  bool homeError = false;

  Future<void> init() async {
    if (Platform.isAndroid) {
      androidInfo = await deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfoPlugin.iosInfo;
    }

    isint = true;
    _isload = true;
    //   _notificationService.init(ongetnotification, onTokenRefresh);
    _sharedPref = await SharedPreferencesLocal().init();
    //   setFcmToken();

    configapp();

    _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) async {
        if (_isload && !result.contains(ConnectivityResult.none)) {
          configapp();
        }
      },
    );

    notifyListeners();
  }

  void appResume() {
    msgdata.addAll({"title": "resume"});
    print("Appresumed");
  }

  void setLocale(Locale locale) {
    //if (!supportedLocalesList.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void creatdDB() {
    _dbHelper = DBHelper().instance;
    dbHelper.init();
  }

  // void ongetnotification(RemoteMessage data) {
  //   msgdata.addAll({"title": "${data.notification?.title}"});
  //   notifyListeners();
  // }

  void onTokenRefresh(String? token) {
    _fcmtoken = token;
    notifyListeners();
  }

  // void setFcmToken() {
  //   notificationService.setFCMToken();
  //   notifyListeners();
  // }

  void configapp() async {
    //   var configdata = await _localRepository.configApp();
    //    if (configdata != null) {
    //      _isload = false;
    //    }
    //  notifyListeners();
  }

  LocaleProvider setContext(BuildContext context) {
    mContext = context;
    return this;
  }

  void doLogout({bool askConfirm = false}) {
    if (askConfirm) {
      GlobalFunctions.showDynamicDialog(
        title: 'Logout',
        content: 'Are you sure want to logout?',
        confirmButtonTitle: 'Yes',
        cancelButtonTitle: 'Cancel',
        onConfirmClick: () {
          confirmLogout();
        },
        onCancelClick: () {
          Get.back();
        },
      );
    } else {
      confirmLogout();
    }
  }

  void callBack()async{

    GlobalFunctions.showDynamicDialog(
      title: 'Call Back',
      content: 'Are you sure want to create call back request?',
      confirmButtonTitle: 'Yes',
      cancelButtonTitle: 'Cancel',
      onConfirmClick: ()async {
         Get.back();
       await GlobalLoadingDialogController.openDialog();
        await _localRepository.callBackRequest();
       await GlobalLoadingDialogController.closeDialog();
      },
      onCancelClick: () {
        Get.back();
      },
    );

  }

  void confirmLogout() {
    sharedPref.clear();
    globalLoginModel = null;
    navigateDeleteAll(AppRoutes.LOGIN);
    notifyListeners();
    timer?.cancel();
  }

  startTimer() {
    stopTimer();
    timer = Timer(
      const Duration(minutes: 55),
      () {
        if (globalLoginModel == null) {
          stopTimer();
          return;
        }
        AuthProvider().callGetToken(this, "${globalLoginModel?.partnerid}",
            "${globalLoginModel?.password}",
            canNavigate: false, isAuto: true);
      },
    );
  }

  stopTimer() {
    if (timer != null) {
      timer?.cancel();
    }
  }

  /// you can use promise to find on back / resume applicable all navigation like navigate(route).then(()=>callback())
  Future? navigate(AppRoutes appRoutes, {dynamic argument}) {
    /// just navigate to route
    return Get.toNamed(
      appRoutes.name,
      arguments: argument,
    );
  }

  Future? navigateDeleteLast(AppRoutes appRoutes, {dynamic argument}) {
    /// delete the route and navigate
    return Get.offAndToNamed(
      appRoutes.name,
      arguments: argument,
    );
  }

  Future? navigateDeleteAll(AppRoutes appRoutes, {dynamic argument}) {
    /// delete all route and navigate
    return Get.offAllNamed(
      appRoutes.name,
      arguments: argument,
    );
  }

  Future? navigateDeleteUntil(AppRoutes appRoutes, {dynamic argument}) {
    /// delete all screen until given screen
    return Get.offNamedUntil(
      appRoutes.name,
      arguments: argument,
      (route) => false,
    );
  }

  Future<dynamic> getSetProfile({bool isFirst = true}) async {
    var profileData = await _authRepository.getProfile();
    if (profileData != null) {
      profileData as ProfileDataModel;
      profileDataModel = profileData;
      notifyListeners();
    } else {
      if (isFirst) {
        exit(0);
      }
    }
  }

  Future<void> changePassword(String oldPass, String newPass,
      String confirmPass, String selectedOption) async {
    GlobalLoadingDialogController.openDialog();
    var msgModel =
        await _authRepository.changePass(oldPass, newPass, confirmPass);

    await GlobalLoadingDialogController.closeDialog();
    if (msgModel != null) {
      // globalLoginModel?.password = newPass;
      // if (globalLoginModel != null) {
      //   sharedPref.setMap(
      //     PrefKeys.LOGINDATA,
      //     globalLoginModel!.toJson(),
      //   );
      // }

      // msgModel as MessageModel;

      GlobalFunctions.showToast(
        msgModel.message,
        true,
      );
      confirmLogout();
      Get.back();
    } else {}
    notifyListeners();
  }

  Future<void> getHomeData() async {
    homeError = false;
    homeLoad = true;
    notifyListeners();
    var data = await _localRepository.getDashBoardData();

    if (data != null) {
      mainDashBoardModel = data;
      print(mainDashBoardModel?.topPanels);
    } else {
      homeError = true;
    }
    homeLoad = false;
    notifyListeners();
  }
}
