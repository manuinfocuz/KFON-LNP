import 'package:flutter/material.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/address_details.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/device_details.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/doc_upload.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/gst_information.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/installation_address_details.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/personel_details.dart';
import 'package:kfon_lnp/view/subscriber/sub_create/subscription_details.dart';

import '../../../data_model/subscriber/aadharDetailsModel.dart';
import '../../../providers/subscriber/sub_create_provider.dart';

class FormViewScreen extends StatelessWidget {
  final SubCreateProvider provider;
  final String cafID;
  final String profileID;
  final AadharDetailsModel? aadharDetailsModel;

  const FormViewScreen({
    super.key,
    required this.cafID,
    required this.profileID,
    required this.provider,
    this.aadharDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PersonalDetails(
            subCreateProvider: provider,
            caf: cafID,
            profileID: profileID,
            aadharDetailsModel: aadharDetailsModel,
          ),
          AddressDetailsScreen(
            subCreateProvider: provider,
            caf: cafID,
            profileID: profileID,
            isPermanent: true,
          ),
          InstallationAddressDetailsScreen(
            subCreateProvider: provider,
            caf: cafID,
            profileID: profileID,
            isPermanent: false,
          ),
          SubscriptionDetails(
            subCreateProvider: provider,
            caf: cafID,
            profileID: profileID,
          ),
          DeviceDetails(
            subCreateProvider: provider,
            caf: cafID,
            profileID: profileID,
          ),
          // if (provider.isGSTINAdd)
          GSTInformation(
            subCreateProvider: provider,
            caf: cafID,
            profileID: profileID,
          ),
          DocUpload(
            subCreateProvider: provider,
            caf: cafID,
            profileID: profileID,
            // isOnlyView: true,
          ),
        ],
      ),
    );
  }
}
