import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/widget/utils_widgets/build_ui.dart';
import 'package:provider/provider.dart';
import '../../utils/global_functions.dart';
import '../../utils/global_variables.dart';
import '../../utils/style.dart';
import '../../widget/utils_widgets/custom_button.dart';
import '../../widget/utils_widgets/globalAppBar.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  List<bool> listExpended = [];
  final LocaleProvider _localeProvider = Get.find();

  @override
  void initState() {
    super.initState();

    var i = 0;
    for (i = 0; i < 3; i++) {
      listExpended.add(false);
    }
    listExpended[0] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, provider, snap) {
        return Scaffold(
          // appBar: globalAppBar("Profile"),
          body: BuildUI(
            isLoad: false,
            isError: false,
            mainUi: localUI(provider),
          ),
        );
      },
    );
  }

  Widget localUI(LocaleProvider provider) {
    if (provider.profileDataModel == null) {
      return Container();
    }
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Card(
              elevation: 8,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpansionPanelList(
                          elevation: 0,
                          //  expandedHeaderPadding: const EdgeInsets.all(0),
                          expansionCallback: (int index, bool isExpanded) {
                            listExpended[index] = isExpanded;
                            setState(() {});
                          },
                          children: [
                            buildExpendWidget(
                              "${provider.profileDataModel?.regDetails.heading}",
                              0,
                              registerDetails(provider),
                            ),
                            buildExpendWidget(
                              "${provider.profileDataModel?.subDetails.heading}",
                              1,
                              subDetails(provider),
                            ),
                            buildExpendWidget(
                              "${provider.profileDataModel?.bankDetails.heading}",
                              2,
                              bankDetails(provider),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: CustomButton(
                        title: 'Change Password',
                        onClickFunction: () {
                          _localeProvider.navigate(AppRoutes.CHANGEPASSSWORD);
                        },
                      ),
                    ),
                   // buildAppVersionText()
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/dummy_user.png'),
// Replace with your actual image
                    fit: BoxFit.fitHeight,
                  ),
                  shape: BoxShape.circle,
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

  ExpansionPanel buildExpendWidget(
      String title, int index, Widget inderWidget) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          visualDensity: const VisualDensity(horizontal: -4),
          title: Text(title),
        );
      },
      body: inderWidget,
      isExpanded: listExpended[index],
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildDetail(String? heading, String? value) {
    return heading == null || value == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$heading:  '),
                Expanded(
                  child: Text(
                    value,
                    style: appTextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget registerDetails(LocaleProvider provider) {
    return Column(
      children: [
        buildDetail(
          "Name",
          provider.profileDataModel!.regDetails.partnername,
        ),
        buildDetail(
          "Address",
          provider.profileDataModel!.regDetails.address,
        ),
        buildDetail(
          "Company Registration Number",
          provider.profileDataModel!.regDetails.companyregistrationno,
        ),
        buildDetail(
          "PAN No",
          provider.profileDataModel!.regDetails.incometaxno,
        ),
        buildDetail(
          "VAT Registration No",
          provider.profileDataModel!.regDetails.vatno,
        ),
        buildDetail(
          "GSTIN",
          provider.profileDataModel!.regDetails.gstin,
        ),
        buildDetail(
          "Contact Person",
          provider.profileDataModel!.regDetails.cperson,
        ),
        buildDetail(
          "Contact Phone",
          provider.profileDataModel!.regDetails.cpersonPhone,
        ),
        buildDetail(
          "Contact Email",
          provider.profileDataModel!.regDetails.cpersonEmail,
        ),
      ],
    );
  }

  Widget subDetails(LocaleProvider provider) {
    return Column(
      children: [
        buildDetail(
          "Partner ID",
          provider.profileDataModel!.subDetails.partnerid,
        ),
        buildDetail(
          "Partner Type",
          provider.profileDataModel!.subDetails.ptype,
        ),
        buildDetail(
          "Agreement Number",
          provider.profileDataModel!.subDetails.agreementno,
        ),
        buildDetail(
          "Agreement Date",
          provider.profileDataModel!.subDetails.agreementdate?.formatDate(
            dateFormat: DateFormat('yyyy-MM-dd'),
          ),
        ),
        buildDetail(
          "Agreement Renew Date",
          provider.profileDataModel!.subDetails.agreementdate?.formatDate(
            dateFormat: DateFormat('yyyy-MM-dd'),
          ),
        ),
      ],
    );
  }

  Widget bankDetails(LocaleProvider provider) {
    return Column(
      children: [
        buildDetail(
            "Bank Name", provider.profileDataModel!.bankDetails.bankName),
        buildDetail(
          "Bank Branch",
          provider.profileDataModel!.bankDetails.bankBranch,
        ),
        buildDetail(
          "Bank Account Holder Name",
          provider.profileDataModel!.bankDetails.bankAcholder,
        ),
        buildDetail(
          "Account Number",
          provider.profileDataModel!.bankDetails.bankAcno,
        ),
        buildDetail(
          "IFSC Code",
          provider.profileDataModel!.bankDetails.bankIfsc,
        ),
        buildDetail(
          "Bank Account Type",
          provider.profileDataModel!.bankDetails.bankActype,
        ),
      ],
    );
  }
}
