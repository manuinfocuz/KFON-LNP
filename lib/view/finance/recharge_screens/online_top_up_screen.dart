import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kfon_lnp/data_model/recharge/payment_gateway_details.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/providers/finance/recharge_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_button.dart';
import 'package:kfon_lnp/widget/utils_widgets/custom_textfiled.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes.dart';
import '../../../widget/utils_widgets/globalAppBar.dart';

class OnlineTopUpScreen extends StatefulWidget {
  const OnlineTopUpScreen({super.key});

  @override
  State<OnlineTopUpScreen> createState() => _OnlineTopUpScreenState();
}

class _OnlineTopUpScreenState extends State<OnlineTopUpScreen> {
  late final LocaleProvider _localeProvider = Get.find();
  TextEditingController amountController = TextEditingController();
  List<List<dynamic>> paymetGWList = [
    ["assets/images/ikm.png", "IKM"],
    ["assets/images/hdfcbank.jpg", "HDFC"],
  ];
  var selectedGateway;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RechargeProvider(),
      builder: (context, provider) =>
          Consumer<RechargeProvider>(builder: (context, provider, snap) {
        return Scaffold(
          appBar: globalAppBar(
            "Wallet TOP-UP",
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: CustomTextField(
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            inputType: TextInputType.number,
                            maxLength: 10,
                            lableText: "Amount",
                            isPassword: false,
                            onChangeText: (e) {},
                            controller: amountController,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Select Payment Gatway",
                          style: appTextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            paymetGWList.length,
                            (index) {
                              var singleItem = paymetGWList[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: ListTile(
                                    onTap: () {
                                      selectedGateway = index;
                                      setState(() {});
                                    },
                                    leading: Image.asset("${singleItem[0]}"),
                                    trailing: Radio(
                                      value: index,
                                      groupValue: selectedGateway,
                                      onChanged: (value) {
                                        selectedGateway = index;
                                        setState(() {});
                                      },
                                    )),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: CustomButton(
                    title: "Process To Pay",
                    onClickFunction: () {
                      if (amountController.text.isEmpty) {
                        GlobalFunctions.showToast(
                          "Amount must not be empty",
                          false,
                        );
                        return;
                      }
                      if (double.tryParse(amountController.text) == null) {
                        GlobalFunctions.showToast(
                          "Invalid Amount",
                          false,
                        );
                        return;
                      }

                      if (selectedGateway == null) {
                        GlobalFunctions.showToast(
                          "Please select payment gateway",
                          false,
                        );
                        return;
                      }

                      GlobalFunctions.showDynamicDialog(
                        title: 'Service Charges and Taxes',
                        content: "",
                        child: const ServiceTaxWidget(),
                        confirmButtonTitle: 'Yes, Agree',
                        cancelButtonTitle: 'Cancel',
                        onConfirmClick: () async {
                          Get.back();
                          var data = await provider.getPaymentGateway(
                            selectedGateway,
                            amountController.text,
                          );
                          var prepareIkmModel = provider.paymentGatewayDetails!;

                          String formData = "";
                          if (provider.paymentGatewayDetails!.encryptedData !=
                                  null &&
                              provider.paymentGatewayDetails!.encryptedData!
                                  .isNotEmpty) {
                            formData =
                                'encRequest=${prepareIkmModel.encryptedData}&access_code=${prepareIkmModel.accessCode}';

                            // Convert the form data to Uint8List
                          } else {
                            formData =
                                'PGBREQ_STR=${prepareIkmModel.pgbreqStr}&PGTUID=${prepareIkmModel.pgtuid}';
                          }

                          Uint8List body = Uint8List.fromList(
                            utf8.encode(formData),
                          );
                          _localeProvider.navigate(
                            AppRoutes.RECHARGEWEBIMPLEMENT,
                            argument: [
                              prepareIkmModel.pgwUrl,
                              body,
                            ],
                          );
                        },
                        onCancelClick: () {
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// String _loadHTML(PaymentGatewayDetails prepareIkmModel) {
//   print(prepareIkmModel.toJson());
//   if (prepareIkmModel.encryptedData != null &&
//       prepareIkmModel.encryptedData!.isNotEmpty) {
//     return _loadHTMLHDFC(prepareIkmModel);
//   }
//   var data = '''
//       <html>
//      <body onload="setTimeout(function() { document.myForm.submit(); }, 10)">
//        <form name="myForm" action="${prepareIkmModel.pgwUrl}" method="POST">
//   <input type="hidden" id="PGBREQ_STR" name="PGBREQ_STR" value="${prepareIkmModel.pgbreqStr}"><br>
//   <input type="hidden" id="PGTUID" name="PGTUID" value="${prepareIkmModel.pgtuid}"><br><br>
//   <ul>Wait we are loading if not load automatically   <input type="submit" value="Click Here"></ul>
//
//
// </form>
// </body>
//       </html>
//     ''';
//
//   return data;
// }
//
// String _loadHTMLHDFC(PaymentGatewayDetails prepareIkmModel) {
//   return '''
//   <html>
//      <body onload="setTimeout(function() { document.myForm.submit(); }, 10)">
//        <form name="myForm" action="${prepareIkmModel.pgwUrl}" method="POST">
//   <input type="hidden" id="encRequest" name="encRequest" value="${prepareIkmModel.encryptedData}"><br>
//   <input type="hidden" id="access_code" name="access_code" value="${prepareIkmModel.accessCode}"><br><br>
//   <ul>Wait we are loading if not load automatically   <input type="submit" value="Click Here"></ul>
//
//
// </form>
// </body>
//       </html>
//     ''';
// }

class ServiceTaxWidget extends StatelessWidget {
  const ServiceTaxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'The terms and condition shall be governed by Indian Laws. Any and all disputes, controversies and conflicts ("Disputes") arising out of the Program shall be settled through regular judicial process and the court of Ernakulam shall have exclusive jurisdiction to any matter arising hereof and Kerala fiber optic network liability shall be limited to the extent of registration fees charged and received by Kerala fiber optic network from the customers.',
            ),
            SizedBox(height: 20),
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Entity website considers the protection of your personal information a top priority when you use our services and access the website. The website will take all necessary measures to safeguard your privacy. If you decide to access the website, your visit and any dispute over privacy are subject to this Privacy Policy and Our Terms and Conditions of use. Our Policy regarding the collection, use and disclosure, if any, of personal information is very strict and we adhere to the best of practices to guard your personal information with care.',
            ),
            SizedBox(height: 20),
            Text(
              'Refund / Cancellation Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'If the payment is not successful, the amount will be reverted back to the customer\'s account within 5-8 working days time. Online application once approved, the fund cannot be refunded under any circumstances.',
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: support@kfon.in',
            ),
          ],
        ),
      ),
    );
  }
}
