import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kfon_lnp/providers/local_providers/app_local_provider.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/view/home_screen/dash_board_screen.dart';
import 'package:kfon_lnp/view/home_screen/menu_screen.dart';
import 'package:kfon_lnp/view/profile/view_profile_screen.dart';

import '../../widget/utils_widgets/globalAppBar.dart';
import '../crm/ticket_screens/create_ticket_screen.dart';
import '../crm/ticket_screens/ticket_list_screen.dart';
import '../finance/disbursement/disbursement_list.dart';
import '../finance/invoice_screen/invoice_list_screen.dart';
import '../finance/recharge_screens/online_top_up_screen.dart';
import '../finance/recharge_screens/recharge_history_screen.dart';
import '../finance/subscriber_finance/subscriber_finance_screen.dart';

import '../inventory/device_list_screen.dart';
import '../my_suports/new_sup_enquires_screen.dart';

import '../subscriber/new_subscriber/new_sub_select_form_type.dart';
import '../subscriber/subscriber_applications_screen.dart';

import '../subscriber/subscriber_details/active_subscriber_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final LocaleProvider _localeProvider = Get.find();

  List<Widget?> screenList = [
    const MenuScreen(), //0
    const SubscriberApplicationScreen(), //1
    const NewSubSelectFormTypeScreen(), //2
    const ActiveSubscriberScreen(
      type: 1,
    ), //3
    Builder(
      builder: (context) {
        return const ActiveSubscriberScreen(
          type: 2,
        );
      },
    ), //4
    null, //5
    const OnlineTopUpScreen(), //6
    const RechargeHistoryScreen(), //7
    const CreateTicketScreen(), //8
    const TicketListScreen(), //9
    const InvoiceListScreen(), //10
    const DisbursementList(), //11
    const SubscriberFinanceScreen(), //12
    const NewSupEnquiresScreen(), //13
    const DeviceListScreen(), //14
  ];

  List<Widget?> screenBottomList = [
    const DashBoardScreen(), //1
    // const MenuScreen(), //0

    const MenuScreen(), //0
    // const NewSubSelectFormTypeScreen(), //2
    //   const TicketListScreen(), //3

    const ViewProfileScreen(), //4
  ];

  @override
  void initState() {
    _localeProvider.currentIndex = 0;
    _localeProvider.currentBottomNavIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLocalProviders(
      child: (context, providerss, snap) {
        return PopScope(
          // canPop: false,
          onPopInvoked: (status) async {
            GlobalFunctions.showDynamicDialog(
              title: "Exit",
              content: "Are you sure want to exit?",
              confirmButtonTitle: "Yes",
              cancelButtonTitle: "No",
              onConfirmClick: () {
                exit(0);
              },
              onCancelClick: () {
                Get.back();
              },
            );
          },
          child: Scaffold(
            key: _scaffoldKey,
            appBar: globalAppBar(
              "Hello ${_localeProvider.profileDataModel?.regDetails.partnername}",
              isHome: true,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.black,
              selectedItemColor: primaryColor,
              showUnselectedLabels: true,
              unselectedFontSize: 12,
              selectedFontSize: 12,
              currentIndex: _localeProvider.currentBottomNavIndex,
              onTap: (index) {
                // if (index == 1 || index == 3) {
                //   return;
                // }
                setState(() {
                  _localeProvider.currentBottomNavIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    HugeIcons.strokeRoundedHome01,
                  ),
                  label: 'Home',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     HugeIcons.strokeRoundedStar,
                //   ),
                //   label: 'Favorites',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(
                    HugeIcons.strokeRoundedDashboardCircle,
                  ),
                  label: 'All Services',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     HugeIcons.strokeRoundedSettings02,
                //   ),
                //   label: 'Settings',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(
                    HugeIcons.strokeRoundedUserCircle,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
            // drawer: AppDrawer(
            //     callBack: (int index) {
            //       _localeProvider.currentIndex = index;
            //       setState(() {});
            //       if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
            //         _scaffoldKey.currentState?.openEndDrawer();
            //       } else {
            //         _scaffoldKey.currentState?.openDrawer();
            //       }
            //     },
            //     currentIndex: _localeProvider.currentIndex),
            body: Column(
              children: [
                Expanded(
                  child:
                      screenBottomList[_localeProvider.currentBottomNavIndex] ??
                          const SizedBox(),
                ),

                // ConvexAppBar(
                //   style: TabStyle.values[7],
                //   // This gives the center "+" button effect
                //   backgroundColor: Colors.white,
                //   activeColor: primaryColor,
                //   color: Colors.grey,
                //   items: const [
                //     TabItem(
                //       icon: HugeIcons.strokeRoundedHome01,
                //       title: 'Home',
                //     ),
                //     TabItem(
                //       icon: HugeIcons.strokeRoundedStar,
                //       title: 'Favorites',
                //     ),
                //     TabItem(
                //       icon: HugeIcons.strokeRoundedDashboardCircle,
                //       title: 'All Services',
                //     ), // Central "+" button
                //     TabItem(
                //       icon: HugeIcons.strokeRoundedSettings02,
                //       title: 'Settings',
                //     ),
                //     TabItem(
                //       icon: HugeIcons.strokeRoundedUserCircle,
                //       title: 'Profile',
                //     ),
                //   ],
                //   initialActiveIndex: _localeProvider.currentBottomNavIndex,
                //   // Default to first item
                //   onTap: (index) {
                //     setState(() {
                //       _localeProvider.currentBottomNavIndex = index;
                //     });
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppDrawer extends StatefulWidget {
  final Function(int index) callBack;
  final int currentIndex;

  const AppDrawer(
      {super.key, required this.callBack, required this.currentIndex});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final LocaleProvider _localeProvider = Get.find();
  List<ExpansionTileController> expansionControllers = [
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset(
                "assets/images/splash_logo.png",
                width: 50,
                height: 40,
                scale: 7,
              ),
            ),
          ),
          navItem(
            "Home",
            Icons.home,
            0,
            isIn: false,
          ),
          extendMenuWidget(
            title: navMainItem(
              "Subscribers Applications",
              Icons.list_alt,
            ),
            children: [
              navItem(
                "Applications List",
                Icons.list_alt,
                1,
              ),
              navItem(
                "Create CAF",
                Icons.create_new_folder_outlined,
                2,
              ),
            ],
            index: [
              1,
              2,
            ],
            mainKey: 0,
          ),
          extendMenuWidget(
            title: navMainItem(
              "My Subscribers",
              Icons.my_library_add_outlined,
            ),
            children: [
              navItem(
                "Subscriber List",
                Icons.person,
                3,
              ),
              navItem(
                "Validity end in 7 days",
                Icons.date_range_rounded,
                4,
              ),
            ],
            index: [
              3,
              4,
            ],
            mainKey: 1,
          ),
          extendMenuWidget(
            title: navMainItem(
              "CRM",
              Icons.dashboard_customize,
            ),
            children: [
              navItem(
                "Create Ticket",
                Icons.support_agent,
                8,
              ),
              navItem(
                "Tickets",
                Icons.support_agent,
                9,
              ),
            ],
            index: [
              8,
              9,
            ],
            mainKey: 2,
          ),
          extendMenuWidget(
            title: navMainItem(
              "Finance",
              Icons.payments_outlined,
            ),
            children: [
              navItem(
                "LNP Wallet Top-up",
                Icons.payment,
                6,
              ),
              navItem(
                "Online Transaction History",
                Icons.phone_iphone,
                7,
              ),
              navItem(
                "Invoice",
                Icons.file_copy_outlined,
                10,
              ),
              navItem(
                "Disbursement",
                Icons.payments_outlined,
                11,
              ),
              navItem(
                "Subscriber Finance",
                Icons.person,
                12,
              ),
            ],
            index: [
              6,
              7,
              10,
              11,
              12,
            ],
            mainKey: 3,
          ),
          extendMenuWidget(
            title: navMainItem(
              "Inventory",
              Icons.inventory,
            ),
            children: [
              navItem(
                "Device List",
                Icons.devices_other_outlined,
                14,
              ),
              // navItem(
              //   "Device Request",
              //   Icons.device_unknown,
              //   15,
              // ),
            ],
            index: [
              14,
              15,
            ],
            mainKey: 4,
          ),
          extendMenuWidget(
            title: navMainItem(
              "My Supports",
              Icons.support_agent,
            ),
            children: [
              navItem(
                "New Subscriber Enquire",
                Icons.new_label_outlined,
                13,
              ),
            ],
            index: [
              13,
            ],
            mainKey: 5,
          ),
          navItem(
            "Logout",
            Icons.logout,
            1110,
            isIn: false,
          ),
        ],
      ),
    );
  }

  Widget navMainItem(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Text(
          title,
          style: appTextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget navItem(String title, IconData icon, int index, {bool isIn = true}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isIn ? 15 : 5,
      ),
      visualDensity: const VisualDensity(
        vertical: -4,
        horizontal: -4,
      ),
      // to
      leading: Icon(
        icon,
        color: widget.currentIndex == index ? primaryColor : Colors.black,
      ),
      title: Text(
        title,
        style: appTextStyle(
          color: widget.currentIndex == index ? primaryColor : Colors.black,
        ),
      ),
      onTap: () {
        if (index == 12) {}
        if (index == 1110) {
          _localeProvider.doLogout(askConfirm: true);
          return;
        }

        widget.callBack(index);

        setState(() {});
      },
    );
  }

  Widget extendMenuWidget({
    required Widget title,
    required List<Widget> children,
    required List<int> index,
    required int mainKey,
    bool enable = true,
  }) {
    return ExpansionTile(
      enabled: enable,
      onExpansionChanged: (bool expanded) {
        var i = 0;
        if (!expanded) return;
        for (var e in expansionControllers) {
          if (mainKey != i) {
            e.collapse();
          }
          i++;
        }
      },
      controller: expansionControllers[mainKey],
      initiallyExpanded: index.contains(
        _localeProvider.currentIndex,
      ),
      tilePadding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 5,
      ),
      visualDensity: const VisualDensity(
        vertical: -4,
        horizontal: -2,
      ),
      title: title,
      children: children,
    );
  }
}
