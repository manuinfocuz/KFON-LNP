import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../utils/routes.dart';

class GlobalLoadingDialog {
  static void openDialog({animationAsset = "assets/loading.json"}) {
    Get.dialog(
      name: AppRoutes.LOADING_DIALOG.name,
      barrierDismissible: false,
      SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              animationAsset,
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
