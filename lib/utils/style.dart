import 'dart:ui';

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff0a337b);
const Color secondaryColor = Color(0xffe62e78);
const Color bgprimaryColor = Color(0xffe0ecff);
const Color accentColor = Color(0xffe62e78);
const Color dangerColor = Color(0xffFF2121);
const Color inactiveColor = Color(0xffD9D9D9);
const Color subTextColor = Color(0xff999999);
const Color bottomBackColor = Color(0xffD5E8CA);
const Color monthBackGroundColor = Color(0xffA0C49D);
const Color linearGreen = Color(0xffB9EF9A);
const Color alertMessage = Color(0xffD3FEAB);
const Color formBorderColor = Color(0xffC4C4C4);
const Color colorGreen = Color(0xff346446);
const Color fontBlue = Color(0xff1c4c71);

const Color bgColor = Color(0xff3b4148);

TextStyle appTextStyle({
  double fontSize = 14,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );

TextStyle appStylishTextStyle({
  double fontSize = 14,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: 'Bree Serif',
    );