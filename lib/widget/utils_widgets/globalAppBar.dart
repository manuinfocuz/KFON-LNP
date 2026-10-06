import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/routes.dart';

import '../../utils/style.dart';

AppBar globalAppBar(String title,
    {bool isHome = false, Function? onBackPress}) {
  final LocaleProvider _localeProvider = Get.find();
  return AppBar(
    backgroundColor: Colors.white,
    // flexibleSpace: SizedBox(
    //   height: 150,
    //   child: ClipRRect(
    //     borderRadius: const BorderRadius.vertical(
    //       bottom: Radius.circular(15),
    //     ),
    //     child: Container(
    //       color: primaryColor,
    //       child: const Image(
    //         image: AssetImage(
    //           'assets/images/top_head.png',
    //         ),
    //         fit: BoxFit.fill,
    //       ),
    //     ),
    //   ),
    // ),

    leading: !isHome
        ? BackButton(
            color: Colors.black,
            onPressed: () {
              if (onBackPress != null) {
                onBackPress();
                return;
              }
              Get.back();
            },
          )
        : null,

    // Builder(
    //         builder: (context) => IconButton(
    //           icon: const Icon(
    //             Icons.sort,
    //           ),
    //           onPressed: () => Scaffold.of(context).openDrawer(),
    //         ),
    //       ),
    iconTheme: const IconThemeData(color: Colors.white),
    //backgroundColor: primaryColor,
    centerTitle: false,
    title: isHome
        ? Image.asset(
            'assets/images/splash_logo.png',
            width: 100,
          )
        : FittedBox(
          child: Text(
              title,
            ),
        ),

    // Text(
    //   title,
    //   style: appTextStyle(
    //     color: Colors.white,
    //   ),
    //   overflow: TextOverflow.ellipsis,
    // ),

    actions: [
      // if (isHome)
      //   IconButton(
      //     onPressed: () {
      //       //  _localeProvider.doLogout(askConfirm: true);
      //     },
      //     icon: Badge.count(
      //       count: 1,
      //       child: const Icon(
      //         HugeIcons.strokeRoundedNotification03,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),

      IconButton(
        onPressed: () {
          _localeProvider.callBack();
        },
        tooltip: 'Call Back Request',
        icon:  Icon(
          HugeIcons.strokeRoundedCallIncoming01,
          color: secondaryColor,

        ),
      ),
      if (isHome)
        IconButton(
          onPressed: () {
            _localeProvider.doLogout(askConfirm: true);
          },
          icon: const Icon(
            HugeIcons.strokeRoundedLogout01,
            color: Colors.black,
          ),
        ),
    ],
  );
}
