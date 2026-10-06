import 'package:flutter/material.dart';

import '../../utils/routes.dart';


class DialogLocal {
  static showLocalDialog(BuildContext context) {
    return showDialog(
      routeSettings: RouteSettings(
        name:AppRoutes.LOADING_DIALOG.name
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: const SizedBox(),
        );
      },
    );
  }
}
