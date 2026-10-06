import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/providers/ticket/ticket_provider.dart';
import 'package:kfon_lnp/providers/utlis/dynamic_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/globalAppBar.dart';
import 'package:provider/provider.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  final LocaleProvider _localeProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicketProvider(type: 3),
      builder: (context, snap) => Consumer<TicketProvider>(
        builder: (BuildContext context, TicketProvider provider, snap) {
          return Scaffold(
            appBar: globalAppBar(
              "My Tickets",
            ),
            floatingActionButton: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
              ),
              onPressed: () {
                _localeProvider
                    .navigate(
                  AppRoutes.createTicketScreen,
                )
                    ?.then(
                  (e) {
                    provider.ticketPage = 1;
                    provider.getTicketList();
                  },
                );
              },
              label: Text(
                "Create Ticket",
                style: appTextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    backgroundColor: accentColor,
                    color: Colors.white,
                    onRefresh: () async {
                      provider.ticketPage = 1;
                      provider.getTicketList();
                    },
                    child: ListView.builder(
                      controller: provider.scrollController,
                      itemCount: provider.ticketListModel?.tlist.length ?? 0,
                      itemBuilder: (context, index) {
                        var singleItem = provider.ticketListModel?.tlist[index];
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            onTap: () {
                              Get.lazyReplace(() => provider);
                              _localeProvider.navigate(
                                AppRoutes.ticketDetailsScreen,
                                argument: singleItem?.ticketid,
                              );
                            },
                            title: Text(
                              "TicketID: ${singleItem?.ticketid}",
                              style: TextStyle(fontSize: 12),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${singleItem?.subject}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${singleItem?.createdDate?.formatDate(dateFormat: DateFormat('dd-MMM-yyyy hh:mm:ss a'))}"),
                              ],
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (singleItem?.status?.toLowerCase() == "open")
                                    ? dangerColor
                                    : (singleItem?.status?.toLowerCase() == "closed")
                                    ? Colors.green
                                    : Colors.orange,
                              ),

                              child: Text(
                                "${singleItem?.status}",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
