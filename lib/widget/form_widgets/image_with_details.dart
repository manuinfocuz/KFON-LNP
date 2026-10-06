import 'package:flutter/material.dart';
import 'package:kfon_lnp/data_model/subscriber/aadharDetailsModel.dart';
import 'package:kfon_lnp/models/form_type_model.dart';
import 'package:kfon_lnp/providers/subscriber/sub_create_provider.dart';

import '../../utils/style.dart';

class ImageWithTitleBuilder extends StatelessWidget {
  final AadharDetailsModel? aadharDetailsModel;
  final SubCreateProvider provider;
  final FromTypeModel singleItem;

  const ImageWithTitleBuilder({
    super.key,
    this.aadharDetailsModel,
    required this.provider,
    required this.singleItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          "${aadharDetailsModel?.userImage}",
          height: 150,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                singleItem.innerWidget[0].name,
                style: appTextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${aadharDetailsModel?.doorno},\n${aadharDetailsModel?.streetlo},\n ${aadharDetailsModel?.cityname}-${aadharDetailsModel?.pincode}\n ",
                style: appTextStyle(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
