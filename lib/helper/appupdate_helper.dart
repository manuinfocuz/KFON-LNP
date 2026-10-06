import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/global_variables.dart';
import 'firebase_config.dart';

class AppUpdateHelper {
  FBConfig fbConfig = Get.find();

  bool checkForUpdate({Function? callBack}) {
    var latestBuild = fbConfig.getValue("latestBuild").asInt();
    var latestSupportBuild = fbConfig.getValue("latestSupportBuild").asInt();

    if (latestSupportBuild > latestBuild) {
      if (callBack != null) {
        callBack();
      }
    }

    var isUpdate = checkIsUpdateAvailable(
      latestBuild: latestBuild,
    );
    var isForceUpdate = checkIsForceOrNot(
      latestSupportBuild: latestSupportBuild,
    );
    if (isUpdate) {
      showUpdateDialog(
        showLater: !isForceUpdate,
      ).then((e) {
        if (callBack != null) {
          callBack();
        }
      });
    }

    return isUpdate || isForceUpdate;
  }

  bool checkIsForceOrNot({int latestSupportBuild = 0}) {
    int currentBuild = int.tryParse("${packageInfo?.buildNumber}") ?? 10000;

    if (currentBuild < latestSupportBuild) {
      return true;
    }

    return false;
  }

  checkIsUpdateAvailable({
    required int latestBuild,
  }) {
    int currentBuild = int.tryParse("${packageInfo?.buildNumber}") ?? 10000;
    if (currentBuild < latestBuild) {
      return true;
    }

    return false;
  }

  openStore() {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = packageInfo?.packageName;
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  showUpdateDialog({bool showLater = true}) async {
    return Get.dialog(
      AlertDialog(
        title: const Text("Update Available"),
        content: const Text("A new version of the app is available."),
        actions: [
          if (showLater)
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Later"),
            ),
          TextButton(
            onPressed: () {
              openStore();
            },
            child: const Text("Update Now"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
