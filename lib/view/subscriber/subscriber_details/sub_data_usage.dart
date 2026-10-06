import 'package:data_table_2/data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../data_model/subscriber/active_subscriber_list.dart';
import '../../../data_model/subscriber/data_usage_model.dart';
import '../../../providers/subscriber/subscriber_details_provider.dart';
import '../../../widget/utils_widgets/build_ui.dart';
import '../../../widget/utils_widgets/globalAppBar.dart';

class SubDataUsage extends StatefulWidget {
  final ActiveSubscriberSub userData;

  const SubDataUsage({super.key, required this.userData});

  @override
  State<SubDataUsage> createState() => _SubDataUsageState();
}

class _SubDataUsageState extends State<SubDataUsage> {
  SubscriberDetailsProvider subscriberDetailsProvider = Get.find();

  @override
  void initState() {
    Future.delayed(
      (Duration(milliseconds: 100)),
      () {
        // print(subscriberDetailsProvider.dataUsageModel?.toJson());
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: subscriberDetailsProvider,
      builder: (context, provider) => Consumer<SubscriberDetailsProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            // appBar: globalAppBar(
            //   "Data Usage",
            // ),
            body: BuildUI(
              isLoad: provider.isLoading,
              isError: provider.isError,
              mainUi: localUI(provider, size),
            ),
          );
        },
      ),
    );
  }

  Widget localUI(SubscriberDetailsProvider provider, Size size) {
    return RefreshIndicator(
      backgroundColor: accentColor,
      color: Colors.white,
      onRefresh: ()async{
        provider.getDataUsage();
      },
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          child: Column(
            children: [
              topTitles(provider.dataUsageModel),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     cardUsage(
              //       "Total Upload",
              //       "${provider.dataUsageModel?.totalUpload}",
              //       Icons.upload,
              //     ),
              //     cardUsage(
              //       "Total Download",
              //       "${provider.dataUsageModel?.totalDownload}",
              //       Icons.download,
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     cardUsage(
              //       "Total Usage",
              //       "${provider.dataUsageModel?.totalUsage}",
              //       Icons.data_usage,
              //     ),
              //   ],
              // ),

              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: double.tryParse(
                          provider.dataUsageModel?.remaingVol ?? "0",
                        ),
                        color: Colors.green,
                        title: "",
                        //     '70%', // Display the percentage
                      ),
                      PieChartSectionData(
                        value: double.parse(
                          provider.dataUsageModel?.totalUsage ?? "0",
                        ),
                        //
                        // Percentage of remaining data
                        color: Colors.red,
                        title: "",
                        // title:
                        //     '30%', // Display the percentage
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    indicator("Used", Colors.red),
                    const SizedBox(
                      width: 10,
                    ),
                    indicator("Available", Colors.green)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Radsessions",
                    style:
                        appTextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: size.height - 100,
                child: dataTable(provider),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardUsage(String title, String usage, IconData icon) {
    return Card(
      child: SizedBox(
        width: 170,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: appTextStyle(fontSize: 16),
              ),
              Icon(
                icon,
                size: 30,
              ),
              Text(
                usage,
                style: appTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dataTable(SubscriberDetailsProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.grey.withOpacity(0.5)),
        isHorizontalScrollBarVisible: false,
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 2000,
        columns: const [
          DataColumn2(
            label: Text('Callingstation ID'),
            fixedWidth: 150,
          ),
          DataColumn2(
            label: Text('Framed IP Address'),
            fixedWidth: 150,
          ),
          DataColumn2(
            label: Text('Acct Start Time'),
            fixedWidth: 150,
          ),
          DataColumn2(
            label: Text('Acct Stop Time'),
            fixedWidth: 150,
          ),
          DataColumn2(
            label: Text('Upload'),
            fixedWidth: 150,
          ),
          DataColumn2(
            label: Text('Download'),
            fixedWidth: 150,
          ),
          DataColumn2(
            label: Text('Nas IP Address'),
            fixedWidth: 150,
          ),
        ],
        rows: List<DataRow>.generate(
            provider.dataUsageModel?.radsessions.length ?? 0, (index) {
          var singleData = provider.dataUsageModel?.radsessions[index];
          return DataRow(
            cells: [
              DataCell(
                Text(
                  "${singleData?.callingstationid}",
                ),
              ),
              DataCell(
                Text(
                  "${singleData?.framedipaddress}",
                ),
              ),
              DataCell(
                Text(
                  "${singleData?.acctstarttime}",
                ),
              ),
              DataCell(
                Text(
                  "${singleData?.acctstoptime ?? "Online"}",
                ),
              ),
              DataCell(
                Text(
                  "${singleData?.upload}",
                ),
              ),
              DataCell(
                Text(
                  "${singleData?.download}",
                ),
              ),
              DataCell(
                Text(
                  "${singleData?.nasipaddress}",
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget singleDetail(IconData icon, String title, String subTitle) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -4),
      // to c
      leading: Icon(icon),
      title: Text(
        title,
        style: appTextStyle(fontSize: 13),
      ),
      subtitle: Text(
        subTitle,
        style: appTextStyle(
          fontSize: 11,
          color: Colors.grey.withOpacity(0.9),
        ),
      ),
    );
  }

  Widget indicator(String title, MaterialColor color) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50)),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: appTextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget topTitles(DataUsageModel? dataUsageModel) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        // singleDetail(
        //   Icons.list_alt,
        //   "${profileData?.packagename}",
        //   "Plan Name",
        // ),
        singleDetail(
          Icons.data_usage_outlined,
          "${dataUsageModel?.totalUsage ?? "0"} MB",
          "Data Used",
        ),

        singleDetail(
          Icons.upload,
          "${dataUsageModel?.totalUpload ?? "0"} MB",
          "Data Uploaded",
        ),

        singleDetail(
          Icons.download,
          "${dataUsageModel?.totalDownload ?? "0"} MB",
          "Data Downloaded",
        ),
        singleDetail(
          Icons.data_saver_on_outlined,
          "${dataUsageModel?.remaingVol ?? "0"} MB",
          "Data Available",
        ),
        // singleDetail(
        //   Icons.data_saver_on_outlined,
        //   "${dataUsageModel?.remaingVol} MB",
        //   "Remaining Data",
        // ),
        // singleDetail(
        //   Icons.date_range,
        //   "${profileData?.expiry?.formatDate()}",
        //   "Valid Till",
        // ),
        // singleDetail(
        //   Icons.rotate_left_outlined,
        //   "${profileData?.rolloverData} MB",
        //   "Data Rollover",
        // ),
      ],
    );
  }
}
