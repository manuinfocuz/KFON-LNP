library my_prj.globals;

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:kfon_lnp/data_model/auth/login_data_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../providers/local_providers/local_provider.dart';

var appname = "app-name".i18n();
String faqUrl = "https://kfon.in/?page_id=222";

String registerUrl = "https://selfcare.kfon.co.in/partner/enquiry";
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

var supportedLocalesList = [
  const Locale('en', 'US'),
  const Locale('hi', 'IN'),
  const Locale('ta', 'IN'),
];
String un = "kfonrest";

String pw = "kfonrest@123";

String? tokenTemp;
LoginDataModel? globalLoginModel;

var providers = [
  ChangeNotifierProvider(
    create: (_) => LocaleProvider(),
  ),
];

PackageInfo? packageInfo;
