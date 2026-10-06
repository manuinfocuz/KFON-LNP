import 'package:flutter/material.dart';

import '../../utils/global_variables.dart';

class AppMatrix {
  AppMatrix._();

  static double get verticalMargin => 16.0;

  static double get horizontalMargin => 16.0;

  static double get verticalPadding => 16.0;

  static double get horizontalPadding => 16.0;

  static double get verticalSpace => 16.0;

  static double get horizontalSpace => 16.0;

  static double get globalBorderRadius => 20.0;

  static EdgeInsetsGeometry? get margin => EdgeInsets.symmetric(
    vertical: verticalMargin,
    horizontal: horizontalMargin,
  );

  static EdgeInsetsGeometry? get padding => EdgeInsets.symmetric(
    vertical: verticalPadding,
    horizontal: horizontalPadding,
  );

  static double get dynamicVerticalMargin => 16.0;

  static double get dynamicHorizontalMargin => 16.0;

  /// Returns the available height of the screen, subtracting the height of the app bar if specified.
  static double availableHeight({
    BuildContext? context,
    bool subtractAppBarHeight = false,
  }) {
    context ??= navigatorKey.currentContext;

    ///no tr
    if (context == null) {
      throw Exception('Context is null');
    }
    return MediaQuery.of(context).size.height -
        (subtractAppBarHeight ? AppBar().preferredSize.height : 0) -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).viewInsets.bottom;
  }

  /// Returns the available width of the screen.
  static double availableWidth({
    BuildContext? context,
  }) {
    context ??= navigatorKey.currentContext;

    ///no tr
    if (context == null) {
      throw Exception('Context is null');
    }
    return MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
  }

  static double setDefaultIfMore(double value, double max) {
    return value > max ? max : value;
  }

  static double setDefaultIfLess(double value, double min) {
    return value < min ? min : value;
  }
}