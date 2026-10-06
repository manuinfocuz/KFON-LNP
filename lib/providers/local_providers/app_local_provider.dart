import 'package:flutter/material.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:provider/provider.dart';

import 'local_provider.dart';

class AppLocalProviders extends StatelessWidget {
  final Widget Function(
          BuildContext context, LocaleProvider localeProvider, Widget? snapshot)
      child;
  const AppLocalProviders({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localprovider, snapshot) {
        return child(context, localprovider, snapshot);
      },
    );
  }
}
