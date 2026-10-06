import 'package:flutter/material.dart';
import 'package:kfon_lnp/utils/style.dart';

Widget errorTextBuilder(String? text) {
  return Text(
    "$text",
    style: appTextStyle(
      color: Colors.red,
    ),
  );
}
