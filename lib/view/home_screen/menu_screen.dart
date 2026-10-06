import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/utils/style.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // List<String> sampleSlider = [
  //   'https://kfon.kerala.gov.in/wp-content/uploads/2021/02/kfon-banner.jpg',
  //   'https://kfon.kerala.gov.in/wp-content/uploads/2021/11/kerala1-3.jpg',
  //   'https://kfon.kerala.gov.in/wp-content/uploads/2021/02/banner2-1.jpg',
  // ];

  final LocaleProvider _localeProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(),
            // Container(
            //   margin: const EdgeInsets.only(
            //     top: 5,
            //     bottom: 5,
            //   ),
            //   height: 180,
            //   width: double.infinity,
            //   child: CarouselSlider.builder(
            //     itemCount: sampleSlider.length,
            //     itemBuilder:
            //         (BuildContext context, int itemIndex, int pageViewIndex) =>
            //             Container(
            //       margin: const EdgeInsets.only(
            //         right: 5,
            //       ),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(
            //           15,
            //         ),
            //         child: Image.asset(
            //           "assets/images/slider.png",
            //           fit: BoxFit.cover,
            //         ),
            //
            //         // CachedNetworkImage(
            //         //   imageUrl: sampleSlider[itemIndex],
            //         //   fit: BoxFit.cover,
            //         // ),
            //       ),
            //     ),
            //     options: CarouselOptions(viewportFraction: 0.9),
            //   ),
            // ),
            Column(
              children: [
                SectionCard(
                  title: const [
                    'My Subscriber',
                  ],
                  children: [
                    _buildMenuRow(
                      [
                        MenuItem(
                          'KYC',
                          HugeIcons.strokeRoundedProfile,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.applicationList,
                            );
                          },
                        ),
                        MenuItem(
                          'Subscriber\nList',
                          HugeIcons.strokeRoundedUserGroup,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.subListScreen,
                            );
                          },
                        ),
                        MenuItem(
                          'Validity End\nin 7 Days',
                          HugeIcons.strokeRoundedCalendar03,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.subList7DaysScreen,
                            );
                          },
                        ),
                        MenuItem(
                          '',
                          HugeIcons.strokeRoundedCalendar03,
                          needShow: false,
                        ),
                      ],
                      size,
                    ),
                  ],
                ),
                SectionCard(
                  title: const ['Finance & CRM', ''],
                  children: [
                    _buildMenuRow(
                      [
                        MenuItem(
                          'Online\nTop-up',
                          HugeIcons.strokeRoundedWalletAdd01,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.lnpWalletTopUpScreen,
                            );
                          },
                        ),
                        MenuItem(
                          'Online Transaction History',
                          HugeIcons.strokeRoundedWorkHistory,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.lnpWalletTopUpHistoryScreen,
                            );
                          },
                        ),
                        MenuItem(
                          'Invoice\nList',
                          HugeIcons.strokeRoundedInvoice02,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.invoiceListScreen,
                            );
                          },
                        ),
                        MenuItem(
                          'Subscriber\nFinance',
                          HugeIcons.strokeRoundedSaveMoneyDollar,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.subscriberFinanceScreen,
                            );
                          },
                        ),
                      ],
                      size,
                    ),
                    _buildMenuRow(
                      [
                        MenuItem(
                          'Disbursement',
                          HugeIcons.strokeRoundedBitcoinWithdraw,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.disbursementListScreen,
                            );
                          },
                        ),
                        MenuItem(
                          'Create Ticket',
                          HugeIcons.strokeRoundedCustomerService01,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.createTicketScreen,
                            );
                          },
                        ),
                        MenuItem(
                          'Tickets',
                          HugeIcons.strokeRoundedMentoring,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.ticketListScreen,
                            );
                          },
                        ),
                        MenuItem(
                          '',
                          HugeIcons.strokeRoundedCalendar03,
                          needShow: false,
                        ),
                      ],
                      size,
                    ),
                  ],
                ),

                SectionCard(
                  title: const ['Inventory & My Supports'],
                  children: [
                    _buildMenuRow(
                      [
                        MenuItem(
                          'Device\nDetails',
                          HugeIcons.strokeRoundedDeliveryBox02,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.deeviceListScreen,
                            );
                          },
                        ),
                        MenuItem(
                          'New Subscriber Enquiry',
                          HugeIcons.strokeRoundedMentoring,
                          onClick: () {
                            _localeProvider.navigate(
                              AppRoutes.newSubEnquiryScreen,
                            );
                          },
                        ),
                        MenuItem(
                          '',
                          HugeIcons.strokeRoundedCalendar03,
                          needShow: false,
                        ),
                        MenuItem(
                          '',
                          HugeIcons.strokeRoundedCalendar03,
                          needShow: false,
                        ),
                      ],
                      size,
                    ),
                  ],
                ),
                // SectionCard(
                //   title: const ['My Supports'],
                //   children: [
                //     _buildMenuRow(
                //       [
                //         MenuItem(
                //           'New Subscriber Enquire',
                //           HugeIcons.strokeRoundedMentoring,
                //           onClick: () {
                //             _localeProvider.navigate(
                //               AppRoutes.newSubEnquiryScreen,
                //             );
                //           },
                //         ),
                //         MenuItem('', HugeIcons.strokeRoundedCalendar03,
                //             needShow: false),
                //         MenuItem('', HugeIcons.strokeRoundedUserGroup,
                //             needShow: false),
                //         MenuItem('', HugeIcons.strokeRoundedCalendar03,
                //             needShow: false),
                //       ],
                //       size,
                //     ),
                //   ],
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuRow(List<MenuItem> menuItems, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: menuItems.map((item) {
        return InkWell(
          borderRadius: BorderRadius.circular(
            50,
          ),
          onTap: () {
            item.onClick?.call();
          },
          child: menuCard(
            title: item.title,
            icon: item.icon,
            size: size,
            needShow: item.needShow,
          ),
        );
      }).toList(),
    );
  }
}

class SectionCard extends StatelessWidget {
  final List<String> title;
  final List<Widget> children;

  const SectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...List.generate(
              title.length,
              (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index != 0 && title[index].isNotEmpty)
                      const Column(
                        children: [
                          SizedBox(height: 5),
                          Divider(),
                          SizedBox(height: 5),
                        ],
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (title[index].isNotEmpty)
                      Text(
                        "    ${title[index]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        children[index],
                      ],
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget menuCard(
    {required String title,
    required IconData icon,
    required Size size,
    bool needShow = true}) {
  return SizedBox(
    width: size.width / 5,
    child: needShow
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  color: secondaryColor.withAlpha(
                    20,
                  ),
                  border: Border.all(
                    color: secondaryColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  child: Icon(
                    icon,
                    color: secondaryColor,
                    size: 22.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 30,
                  maxHeight: 55,
                ),
                child: Text(
                  title,
                  style: appTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          )
        : null,
  );
}

class MenuItem {
  final String title;
  final IconData icon;
  final bool needShow;
  final Function? onClick;

  MenuItem(
    this.title,
    this.icon, {
    this.onClick,
    this.needShow = true,
  });
}
