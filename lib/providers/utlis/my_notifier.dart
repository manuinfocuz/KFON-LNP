import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes.dart';
import '../../widget/global_loader/global_loading_dialog_controller.dart';

mixin MyNotifier on ChangeNotifier {
  var isDispose = false;
  final GlobalLoadingDialogController loadingController =
      GlobalLoadingDialogController();

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

  Future<SharedPreferencesLocal> get sharedPref async =>
      await SharedPreferencesLocal().init();

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!isDispose) {
      Future.delayed(
        const Duration(milliseconds: 0),
        () {
          super.notifyListeners();
        },
      );
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

  void backScreen() {
    /// jus back or close dialog

    return Get.back();
  }

  void openLoader() {
    GlobalLoadingDialogController.openDialog();
  }

  void closeLoader() {
    GlobalLoadingDialogController.closeDialog();
  }

  logOut() {
    sharedPref.then((value) {
      value.clear();
      navigateDeleteAll(AppRoutes.LOGIN);
      LocaleProvider localeProvider = Get.find();
      localeProvider.currentIndex = 0;
    });
  }
}
