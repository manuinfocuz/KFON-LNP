import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:kfon_lnp/providers/finance/disbursement_provider.dart';
import 'package:kfon_lnp/providers/my_supports/new_enquires_provider.dart';
import 'package:kfon_lnp/providers/subscriber/subscriber_details_provider.dart';
import 'package:kfon_lnp/view/auth_screens/sub_otp_screen.dart';
import 'package:kfon_lnp/view/crm/ticket_screens/create_ticket_screen.dart';
import 'package:kfon_lnp/view/crm/ticket_screens/ticket_details_screen.dart';
import 'package:kfon_lnp/view/crm/ticket_screens/ticket_list_screen.dart';
import 'package:kfon_lnp/view/finance/disbursement/disbursement_details_screen.dart';
import 'package:kfon_lnp/view/finance/disbursement/disbursement_list.dart';
import 'package:kfon_lnp/view/finance/invoice_screen/invoice_list_screen.dart';
import 'package:kfon_lnp/view/finance/recharge_screens/online_top_up_screen.dart';
import 'package:kfon_lnp/view/finance/recharge_screens/recharge_history_screen.dart';
import 'package:kfon_lnp/view/finance/recharge_screens/recharge_web_implement.dart';
import 'package:kfon_lnp/view/finance/subscriber_finance/subscriber_finance_screen.dart';
import 'package:kfon_lnp/view/inventory/device_list_screen.dart';
import 'package:kfon_lnp/view/lading_page.dart';
import 'package:kfon_lnp/view/my_suports/new_sub_enquires_details_screen.dart';
import 'package:kfon_lnp/view/my_suports/new_sup_enquires_screen.dart';
import 'package:kfon_lnp/view/subscriber/new_subscriber/aadhaar_details_screen.dart';
import 'package:kfon_lnp/view/subscriber/new_subscriber/new_sub_select_form_type.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/subscriber_form_screen.dart';
import 'package:kfon_lnp/view/subscriber/subscriber_applications_screen.dart';
import 'package:kfon_lnp/view/subscriber/subscriber_details/active_subscriber_screen.dart';
import 'package:kfon_lnp/view/subscriber/subscriber_details/add_pon_port_screen.dart';
import 'package:kfon_lnp/view/subscriber/subscriber_details/subscriber_details_screen.dart';

import 'package:kfon_lnp/widget/pdf_viewer.dart';
import 'package:localization/localization.dart';
import 'package:kfon_lnp/data_services/api_helper.dart';
import 'package:kfon_lnp/providers/auth_provider.dart';
import 'package:kfon_lnp/providers/local_providers/app_provider.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/view/auth_screens/login_screen.dart';
import 'package:kfon_lnp/view/auth_screens/pin_code_enter_screen.dart';
import 'package:kfon_lnp/view/auth_screens/sub_forget_password.dart';
import 'package:kfon_lnp/view/home_screen/drawer_screen.dart';

import 'package:kfon_lnp/view/profile/change_pass.dart';
import 'package:kfon_lnp/view/profile/view_profile_screen.dart';

import 'package:kfon_lnp/view/splash_screen.dart';

import 'package:kfon_lnp/view/subscriber/subscriber_details/sub_data_usage.dart';

import 'package:kfon_lnp/view/subscriber/view_submitted_application_screen.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'data_model/subscriber/active_subscriber_list.dart';
import 'firebase_options.dart';
import 'helper/firebase_config.dart';

//wrap all class with LocaleProvider inorder use localizations
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   name: "",
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  Get.lazyPut(() => ApiHelper());
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    packageInfo = await PackageInfo.fromPlatform();
    print("packageInfo: ${packageInfo?.version}");
    FBConfig fbConfig = FBConfig();
    await fbConfig.init();
    Get.lazyReplace(
      () => fbConfig,
      fenix: true,
    );
  } on Exception catch (e) {}
  runApp(
    const AppProviders(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    callsetfun();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.microtask(
        () => context.read<LocaleProvider>().appResume(),
      );
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/utils/i18n/'];
    return Consumer<LocaleProvider>(
      builder: (context, provider, snapshot) {
        Get.lazyPut(() => provider);
        return Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          },
          child: MyMaterialApp(context, provider, snapshot),
        );
      },
    );
  }

  void callsetfun() async {
    context.read<LocaleProvider>().init();
  }
}

class MyMaterialApp extends StatelessWidget {
  final LocaleProvider provider;
  final BuildContext context;
  final Widget? snapshot;

  const MyMaterialApp(this.context, this.provider, this.snapshot, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(
          1,
        ), // Set the global textScaleFactor here
      ),
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "KFON LNP",
        theme: ThemeData(
          textTheme: textTheme.copyWith(
            bodyMedium: textTheme.bodyMedium,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: primaryColor,
            background: Colors.white,
          ),
          useMaterial3: true,
        ),
        supportedLocales: supportedLocalesList,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          LocalJsonLocalization.delegate,
        ],
        locale: provider.locale,
        initialRoute: AppRoutes.SPLASHSCREEN.name,
        routes: {
          AppRoutes.SPLASHSCREEN.name: (context) {
            return ChangeNotifierProvider(
              create: (_) => AuthProvider(),
              builder: (context, provider) => Consumer<AuthProvider>(
                builder: (context, provider, snap) => const SplashScreen(),
              ),
            );
          },
          // AppRoutes.LANDINGPAGE.name: (context) {
          //   return const LandingPage();
          // },
          AppRoutes.LOGIN.name: (context) {
            return const LoginScreen();
          },
          AppRoutes.SUBFORGETPASSWORD.name: (context) {
            return const SubForgetPassword();
          },
          AppRoutes.PINCODESCREEN.name: (context) {
            return const PinCodeEnterScreen();
          },
          AppRoutes.HOMESCREEN.name: (context) {
            return const DrawerScreen();
          },
          AppRoutes.PROFILESCREEN.name: (context) {
            return const ViewProfileScreen();
          },
          AppRoutes.CHANGEPASSSWORD.name: (context) {
            return const ChangePass();
          },
          AppRoutes.SUBOTPSCREEN.name: (context) {
            final data = ModalRoute.of(context)!.settings.arguments as List;

            return  SubOtpScreen(
              username: data[0],
              password: data[1],
              mobile: data[2],
            );
          },
          AppRoutes.ACTIVESUBSCRIBER.name: (context) {
            final type = ModalRoute.of(context)!.settings.arguments as int;
            return ActiveSubscriberScreen(
              type: type,
            );
          },
          AppRoutes.SUBSCRIBERDETAILSSCREEN.name: (context) {
            final data = ModalRoute.of(context)!.settings.arguments
                as ActiveSubscriberSub;
            return SubscriberDetailsScreen(
              applicant: data,
            );
          },
          AppRoutes.ponPortAddScreen.name: (context) {
            final data = ModalRoute.of(context)!.settings.arguments
                as SubscriberDetailsProvider;
            return AddPonPortScreen(
              provider: data,
            );
          },
          AppRoutes.CREATESUBSCRIBER.name: (context) {
            final data =
                ModalRoute.of(context)!.settings.arguments as List<dynamic>;

            return SubscriberFormScreen(
              cafID: data[0],
              profileID: data[1],
              aadharDetailsModel: data[2],
              title:data[3],
            );
          },
          AppRoutes.AADHARDETAILSSCREEN.name: (context) {
            final data =
                ModalRoute.of(context)!.settings.arguments as List<String>;
            return AadhaarDetailsScreen(
              cafID: data[0],
              profileID: data[1],
               title:data[2],
            );
          },
          AppRoutes.RECHARGEWEBIMPLEMENT.name: (context) {
            final data =
                ModalRoute.of(context)!.settings.arguments as List<dynamic>;
            return RechargeWebImplement(
              url: data[0],
              body: data[1],
            );
          },
          AppRoutes.ticketDetailsScreen.name: (context) {
            final data = ModalRoute.of(context)!.settings.arguments.toString();
            return TicketDetailsScreen(
              ticketID: data,
            );
          },
          AppRoutes.subDataUsageScreen.name: (context) {
            final data = ModalRoute.of(context)!.settings.arguments
                as ActiveSubscriberSub;
            return SubDataUsage(
              userData: data,
            );
          },
          AppRoutes.viewSubmittedApplicationScreen.name: (context) {
            final data =
                ModalRoute.of(context)!.settings.arguments as List<dynamic>;
            return ViewSubmittedApplicationScreen(
                appID: data[0], type: data[1]);
          },
          AppRoutes.pdfViewScreen.name: (context) {
            final data = ModalRoute.of(context)!.settings.arguments as File;
            return PDFViewerPlugin(
              file: data,
            );
          },
          AppRoutes.disbursementDetailsScreen.name: (context) {
            final data = ModalRoute.of(context)!.settings.arguments
                as DisbursementProvider;

            return DisbursementDetailsScreen(
              provider: data,
            );
          },
          AppRoutes.subEnquiryDetailsScreen.name: (context) {
            final data = ModalRoute.of(context)!.settings.arguments
                as NewEnquiresProvider;

            return NewSubEnquiresDetailsScreen(
              provider: data,
            );
          },
          AppRoutes.applicationList.name: (context) {
            return const SubscriberApplicationScreen();
          },
          AppRoutes.subListScreen.name: (context) {
            return const ActiveSubscriberScreen(
              type: 1,
            );
          },
          AppRoutes.subList7DaysScreen.name: (context) {
            return Builder(
              builder: (context) {
                return const ActiveSubscriberScreen(
                  type: 2,
                );
              },
            );
          },
          AppRoutes.lnpWalletTopUpScreen.name: (context) {
            return const OnlineTopUpScreen();
          },
          AppRoutes.lnpWalletTopUpHistoryScreen.name: (context) {
            return const RechargeHistoryScreen();
          },
          AppRoutes.invoiceListScreen.name: (context) {
            return const InvoiceListScreen();
          },
          AppRoutes.disbursementListScreen.name: (context) {
            return const DisbursementList();
          },
          AppRoutes.subscriberFinanceScreen.name: (context) {
            return const SubscriberFinanceScreen();
          },
          AppRoutes.deeviceListScreen.name: (context) {
            return const DeviceListScreen();
          },
          AppRoutes.newSubEnquiryScreen.name: (context) {
            return const NewSupEnquiresScreen();
          },
          AppRoutes.createTicketScreen.name: (context) {
            return const CreateTicketScreen();
          },
          AppRoutes.ticketListScreen.name: (context) {
            return const TicketListScreen();
          },
          AppRoutes.newSubFormSelectScreen.name: (context) {
            return const NewSubSelectFormTypeScreen();
          },
        },
      ),
    );
  }
}
