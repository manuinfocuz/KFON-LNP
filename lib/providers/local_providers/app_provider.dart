import 'package:flutter/material.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: child,
    );
  }
}
