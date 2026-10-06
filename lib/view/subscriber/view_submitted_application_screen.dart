import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/providers/subscriber/sub_view_edit_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/build_ui.dart';
import 'package:provider/provider.dart';

import '../../widget/utils_widgets/globalAppBar.dart';

class ViewSubmittedApplicationScreen extends StatefulWidget {
  final String appID;
  final int type;

  const ViewSubmittedApplicationScreen(
      {super.key, required this.appID, required this.type});

  @override
  State<ViewSubmittedApplicationScreen> createState() =>
      _ViewSubmittedApplicationScreenState();
}

class _ViewSubmittedApplicationScreenState
    extends State<ViewSubmittedApplicationScreen> {
  @override
  void initState() {
    print(widget.appID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubViewEditProvider(type: 1, cafID: widget.appID),
      builder: (context, provider) => Consumer<SubViewEditProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            appBar: globalAppBar("View Application"),
            body: BuildUI(
              isLoad: provider.isLoading,
              isError: provider.isError,
              mainUi: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.type == 3
                            ? "KYC Subscription Created"
                            : "KYC Closed",
                        style: appTextStyle(
                          color: widget.type == 3 ? Colors.black : Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    initiallyExpanded: false,
                    title: const Text("Personal Details"),
                    children: createData(
                      provider.cafDetailsDataModel?.personalData ?? {},
                    ),
                    //  [

                    // cardDetails(
                    //   "Application No",
                    //   provider
                    //       .cafDetailsDataModel?.personalData?.applicationNo,
                    // ),
                    // cardDetails(
                    //   "Applicant Name",
                    //   provider
                    //       .cafDetailsDataModel?.personalData?.applicantName,
                    // ),
                    // cardDetails(
                    //   "Mobile No",
                    //   provider.cafDetailsDataModel?.personalData?.mobileNo,
                    // ),
                    // cardDetails(
                    //   "Email",
                    //   provider.cafDetailsDataModel?.personalData?.email,
                    // ),
                    // cardDetails(
                    //   "KYC Type",
                    //   provider.cafDetailsDataModel?.personalData?.kycType,
                    // ),
                    // cardDetails(
                    //   "Date of Birth",
                    //   provider.cafDetailsDataModel?.personalData?.dateOfBirth
                    //       ?.formatDate(dateFormat: DateFormat("dd-MM-yyyy")),
                    // ),
                    // cardDetails(
                    //   "Date of Birth",
                    //   provider.cafDetailsDataModel?.personalData?.dateOfBirth
                    //       ?.formatDate(dateFormat: DateFormat("dd-MM-yyyy")),
                    // ),
                    // cardDetails(
                    //     "Subscription Type",
                    //     provider.cafDetailsDataModel?.personalData
                    //         ?.subscriptionType),
                    // cardDetails(
                    //   "Subscription Type",
                    //   provider
                    //       .cafDetailsDataModel?.personalData?.appliedPackage,
                    // ),
                    // ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: false,
                    title: const Text("Permanent Address"),
                    children: createData(
                      provider.cafDetailsDataModel?.paddressData ?? {},
                    ),
                  ),
                  ExpansionTile(
                    initiallyExpanded: false,
                    title: const Text("Installation Address"),
                    children: createData(
                      provider.cafDetailsDataModel?.iaddressData ?? {},
                    ),
                  ),
                  ExpansionTile(
                    initiallyExpanded: false,
                    title: const Text("Support Documents"),
                    children: createDataClick(
                      provider.cafDetailsDataModel?.supportDocs ?? {},
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  checkNullOrEmpty(String? data) {
    if (data == null) {
      return false;
    }
    if (data.toString() == "null") {
      return false;
    }
    if (data.toString().isEmpty) {
      return false;
    }
    if (data.isEmpty) {
      return false;
    }
    return true;
  }

  checkItsUrl(String? data) {
    if (data == null) return false;

    return data.startsWith("https://") || data.startsWith("http://");
  }

  Widget cardDetails(String title, String? value) {
    if (!checkNullOrEmpty(value)) return SizedBox();
    return ListTile(
      leading: SizedBox(
        width: 150,
        child: Text("$title : "),
      ),
      title: Text(
        value ?? "-",
      ),
    );
  }

  Widget cardDetailsClicker(String title, String? value) {
    if (checkNullOrEmpty(value)) {
      return ListTile(
        leading: Text("$title : "),
        title: InkWell(
          onTap: checkNullOrEmpty(value)
              ? () {
                  launchUrlLocal("$value");
                }
              : null,
          child: Text(
            checkItsUrl(value)
                ? (checkNullOrEmpty(value) ? "Click Here" : "File not exist")
                : "$value",
            style: appTextStyle(
              color: checkItsUrl(value)
                  ? (checkNullOrEmpty(value) ? primaryColor : Colors.red)
                  : Colors.black,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  List<Widget> createData(Map<String, dynamic> map) {
    List<Widget> data = [];
    map.forEach(
      (key, value) {
        data.add(
          cardDetails(
            key,
            value.runtimeType == DateTime
                ? (value as DateTime)
                    .formatDate(dateFormat: DateFormat("dd-MM-yyyy"))
                : "$value",
          ),
        );
      },
    );
    return data;
  }

  List<Widget> createDataClick(Map<String, dynamic> map) {
    List<Widget> data = [];
    map.forEach(
      (key, value) {
        data.add(
          cardDetailsClicker(
            key,
            value.runtimeType == DateTime
                ? (value as DateTime)
                    .formatDate(dateFormat: DateFormat("dd-MM-yyyy"))
                : "$value",
          ),
        );
      },
    );
    return data;
  }
}
