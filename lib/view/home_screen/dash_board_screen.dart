import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/build_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVP;
import '../../data_model/main_dashboard_model.dart';

import '../../widget/home/main_menu_card.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  LocaleProvider localeProvider = Get.find();
  List<String> iconName = [
    'active_sub.svg',
    'new_app.svg',
    'val_end_7.svg',
    'new_act.svg',
    'kyc_submit_sub.svg',
    'act_corp.svg',
  ];
  // List<String> sampleSlider = [
  //   'https://kfon.kerala.gov.in/wp-content/uploads/2021/02/kfon-banner.jpg',
  //   'https://kfon.kerala.gov.in/wp-content/uploads/2021/11/kerala1-3.jpg',
  //   'https://kfon.kerala.gov.in/wp-content/uploads/2021/02/banner2-1.jpg',
  // ];

  // List<HomeGrid> lisGrid = [];
  // List<HomeGrid> walletGrid = [];

  @override
  void initState() {
    super.initState();
    getData();
    // lisGrid.add(
    //   HomeGrid(
    //     name: "Active subscribers",
    //     icon: Icons.person,
    //     count: 8,
    //     onClick: () {
    //       localeProvider.navigate(
    //         AppRoutes.ACTIVESUBSCRIBER,
    //         argument: 1,
    //       );
    //     },
    //   ),
    // );
    // lisGrid.add(
    //   HomeGrid(
    //     name: "New applications",
    //     icon: Icons.newspaper_rounded,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    // lisGrid.add(
    //   HomeGrid(
    //     name: "New activation",
    //     icon: Icons.shopping_cart,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    // lisGrid.add(
    //   HomeGrid(
    //     name: "Validity end in 7 days",
    //     icon: Icons.calendar_today_sharp,
    //     count: 0,
    //     onClick: () {
    //       localeProvider.navigate(
    //         AppRoutes.ACTIVESUBSCRIBER,
    //         argument: 2,
    //       );
    //     },
    //   ),
    // );
    // lisGrid.add(
    //   HomeGrid(
    //     name: "KYC to be submitted",
    //     icon: Icons.person_add,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    // lisGrid.add(
    //   HomeGrid(
    //     name: "Active corporate subscribers",
    //     icon: Icons.corporate_fare,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    //
    // walletGrid.add(
    //   HomeGrid(
    //     name: "Account Balance",
    //     icon: Icons.wallet,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    // walletGrid.add(
    //   HomeGrid(
    //     name: "Current Revenue",
    //     icon: Icons.money,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    // walletGrid.add(
    //   HomeGrid(
    //     name: "Last Month LNP-Share",
    //     icon: Icons.vertical_split,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    // walletGrid.add(
    //   HomeGrid(
    //     name: "Govt/Corporate Transferred Amount",
    //     icon: Icons.corporate_fare,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    // walletGrid.add(
    //   HomeGrid(
    //     name: "Recharge On Current month",
    //     icon: Icons.replay_circle_filled,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
    // walletGrid.add(
    //   HomeGrid(
    //     name: "Recharge Revenue",
    //     icon: Icons.receipt_sharp,
    //     count: 0,
    //     onClick: () {},
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider.value(
      value: localeProvider,
      builder: (context, widget) => Consumer<LocaleProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            backgroundColor: bgprimaryColor.withOpacity(
              0.3,
            ),
            body: BuildUI(
              isLoad: provider.homeLoad,
              isError: provider.homeError,
              mainUi: RefreshIndicator(
                backgroundColor: accentColor,
                color: Colors.white,
                onRefresh: () async {
                  await provider.getHomeData();
                },
                child: ListView(
                  children: [
                    // Container(
                    //   margin: const EdgeInsets.only(
                    //     top: 5,
                    //     bottom: 5,
                    //   ),
                      // height: 210,
                      // width: double.infinity,
                      // child: CarouselSlider.builder(
                      //   // itemCount: sampleSlider.length,
                      //   itemBuilder: (BuildContext context, int itemIndex,
                      //           int pageViewIndex) =>
                      //       Container(
                      //     margin: const EdgeInsets.only(
                      //       right: 5,
                      //       left: 5,
                      //     ),
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(
                      //         8,
                      //       ),
                      //       child: Image.asset(
                      //         "assets/images/slider.png",
                      //         fit: BoxFit.fill,
                      //       ),
                      //
                      //       // CachedNetworkImage(
                      //       //   imageUrl: sampleSlider[itemIndex],
                      //       //   fit: BoxFit.cover,
                      //       // ),
                      //     ),
                      //   ),
                      //   options: CarouselOptions(
                      //     viewportFraction: 1,
                      //   ),
                      // ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.8,
                        children: <Widget>[
                          dashboardMenuCard(
                            title: "Subscribers",
                            icons: HugeIcons.strokeRoundedUserMultiple02,
                            onTap: () {
                              provider.navigate(
                                AppRoutes.subListScreen,
                              );
                            },
                            colors: [
                              const Color(0xffF9A825),
                              const Color(0xffF57C00),
                            ],
                            index: 1,
                          ),
                          dashboardMenuCard(
                            title: "New Application",
                            icons: HugeIcons.strokeRoundedTaskAdd01,
                            onTap: () {
                              provider.navigate(
                                AppRoutes.newSubFormSelectScreen,
                              );
                            },
                            colors: [
                              const Color(0xffE91E63),
                              const Color(0xffD81B60),
                            ],
                            index: 2,
                          ),
                          // dashboardMenuCard(
                          //   title: "Activation",
                          //   icons: HugeIcons.strokeRoundedCheckmarkCircle04,
                          //   onTap: () {},
                          //   colors: [
                          //     const Color(0xff2196F3),
                          //     const Color(0xff1E88E5),
                          //   ],
                          //   index: 3,
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          )

                          // border: const GradientBoxBorder(
                          //   width: 1,
                          //   gradient: LinearGradient(
                          //     colors: [
                          //       Colors.green,
                          //       Colors.green,
                          //     ],
                          //   ),
                          // ),
                          ),
                      child: DottedBorder(
                        options: RectDottedBorderOptions(
                          dashPattern: const [6, 3],
                          strokeWidth: 1,
                          color: Colors.green,
                          borderPadding: const EdgeInsets.all(0),
                        ),
                        // borderType: BorderType.RRect,
                        // color: Colors.green,
                        // strokeWidth: 1,
                        // padding: const EdgeInsets.all(8.0),
                        // radius: const Radius.circular(
                        //   8,
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Account Balance",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorGreen,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "₹ ${localeProvider.mainDashBoardModel?.bottomPanels[0].value}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: colorGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),

                    DashboardStats(
                      data: localeProvider.mainDashBoardModel?.topPanels,
                    ),
                    //  mainMenu(size),
                    subMenu(size),
                    recentTopUps(
                      size,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget mainMenu(Size size) => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
        shrinkWrap: true,
        itemCount: localeProvider.mainDashBoardModel?.topPanels.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 120,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          var item = localeProvider.mainDashBoardModel?.topPanels[index];

          var cImage = "assets/images/";
          if (index + 1 > iconName.length) {
            cImage += iconName[0];
          } else {
            cImage += iconName[index];
          }
          // return MainMenuCard(
          //   "${item?.heading}",
          //   "${item?.value}",
          //   cImage,
          //   () {},
          //   index,
          // );

          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.receipt_long,
                      color: Colors.blue,
                    ),
                    // Add your custom icon or use an Icon widget
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${item?.heading}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "${item?.value}",
                  style: const TextStyle(
                    color: fontBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          );
        },
      );

  // Widget subMenu(Size size) => GridView.builder(
  //       physics: const NeverScrollableScrollPhysics(),
  //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //       shrinkWrap: true,
  //       itemCount: localeProvider.mainDashBoardModel?.bottomPanels.length ?? 0,
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         mainAxisExtent: 100,
  //         mainAxisSpacing: 10,
  //         crossAxisSpacing: 10,
  //         crossAxisCount: size.width ~/ 150,
  //       ),
  //       itemBuilder: (BuildContext context, int index) {
  //         var item = localeProvider.mainDashBoardModel?.bottomPanels[index];
  //         return GradientCard(
  //           // icon: Icons.money,
  //           title: "${item?.heading}",
  //           value: "${item?.value}",
  //           gradientColors: const [primaryColor, accentColor],
  //           onClick: () {},
  //         );
  //       },
  //     );

  Widget subMenu(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          // const Row(
          //   children: [
          //     Text(
          //       "Statistics",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 18,
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 8,
          ),

          // Column(
          //   children: [
          //     Row(
          //       children: [
          //         _buildGridItem(
          //           localeProvider.mainDashBoardModel?.bottomPanels[0],
          //         ),
          //         _buildGridItem(
          //           localeProvider.mainDashBoardModel?.bottomPanels[1],
          //         ),
          //         _buildGridItem(
          //           localeProvider.mainDashBoardModel?.bottomPanels[2],
          //         ),
          //       ],
          //     ),
          //   ],
          // )
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            itemCount: (localeProvider
                        .mainDashBoardModel?.bottomPanels.isNotEmpty ==
                    true
                ? (localeProvider.mainDashBoardModel!.bottomPanels.length - 1)
                : 0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 120,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              var item =
                  localeProvider.mainDashBoardModel?.bottomPanels[index + 1];
              // return _buildGridItem(
              //   item,
              // );

              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/s_${index + 1}.svg',
                          height: 30,
                        ),
                        // Add your custom icon or use an Icon widget
                        const SizedBox(width: 8),
                        Expanded(
                          child: Center(
                            child: Text(
                              "${item?.heading}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${item?.value}",
                      style: const TextStyle(
                        color: fontBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BottomPanel? itemData) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: const GradientBoxBorder(
          width: 1,
          gradient: LinearGradient(
            colors: [
              secondaryColor,
              primaryColor,
            ],
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${itemData?.value}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            "${itemData?.heading}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void getData() async {
    Future.delayed(
      const Duration(microseconds: 100),
      () async {
        await localeProvider.getHomeData();
        //  setState(() {});
      },
    );
  }

  Widget recentTopUps(Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 15,
      ),
      padding: const EdgeInsets.only(
        top: 5,
        left: 5,
        bottom: 10,
        right: 5,
      ),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.grey,
        // ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Text(
                "Recent Subscriber Top-up",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: localeProvider
                    .mainDashBoardModel?.recentTrans?.transList.length ??
                0,
            itemBuilder: (context, index) {
              var singleItem = localeProvider
                  .mainDashBoardModel?.recentTrans?.transList[index];
              return Container(
                margin: const EdgeInsets.only(
                  bottom: 1,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.2,
                      offset: Offset(0.0, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name Column
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: Colors.grey.withOpacity(
                                  0.1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      10,
                                    ),
                                    child: SvgPicture.asset(
                                      index == 2
                                          ? 'assets/images/building.svg'
                                          : 'assets/images/user.svg',
                                      height: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  FittedBox(
                                    child: Text(
                                      "${singleItem?.username}",
                                      // You can dynamically replace this
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "${singleItem?.createdDate.formatDate(
                                        dateFormat: DateFormat(
                                            'dd-MMM-yyyy - hh:mm:ss a'),
                                      )}",
                                      // You can dynamically replace this
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Amount and Date Column
                      Expanded(
                        child: Column(
                          spacing: 3,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 110,
                              decoration: BoxDecoration(
                                color: singleItem?.rechargeMode == "1"
                                    ? Colors.pinkAccent
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 5,
                                  ),
                                  child: Text(
                                    "${singleItem?.cause}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "₹ ${singleItem?.amount}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Green text for amount
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget dashboardMenuCard(
      {required String title,
      required IconData icons,
      required Function() onTap,
      required List<Color> colors,
      required int index}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: SVP.Svg(
              'assets/images/bg_${index}_m.svg',
            ),
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
          // gradient: LinearGradient(
          //   colors: colors,
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: Colors.white,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DashboardStats extends StatelessWidget {
  const DashboardStats({
    super.key,
    required this.data,
  });
  final List<TopPanel>? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: GridView.builder(
        itemCount: data?.length ?? 0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,

          // Give the cards enough vertical space.
          mainAxisExtent: 115,
        ),
        itemBuilder: (context, i) {
          final item = data![i];

          return _StatCard(
            title: '${item.heading ?? ''}',
            value: '${item.value ?? ''}',
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData? icon;
  final String title, value;

  const _StatCard({
    this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1), // use withOpacity
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // make icon+title wrap / flex
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 3,
            children: [
              if (icon != null) Icon(icon, color: primaryColor, size: 20),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // value will scale down if needed
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
