import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DynamicProvider<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T provider) child;
  final T provider;
  final bool isError;
  final bool isLoading;
  final bool isNoDataFound;
  const DynamicProvider({
    super.key,
    required this.child,
    required this.provider,
    this.isError = false,
    this.isLoading = false,
    this.isNoDataFound = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => provider,
      builder: (context, _) => Consumer<T>(
        builder: (context, provider, snap) {
          return child(
            context,
            provider,
          );
        },
      ),
    );
  }
}

class DynamicProviderValue<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T provider) child;
  final T provider;
  final bool isError;
  final bool isLoading;
  final bool isNoDataFound;
  const DynamicProviderValue({
    super.key,
    required this.child,
    required this.provider,
    this.isError = false,
    this.isLoading = false,
    this.isNoDataFound = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: provider,
      builder: (context, _) => Consumer<T>(
        builder: (context, provider, snap) {
          return child(
            context,
            provider,
          );
        },
      ),
    );
  }
}
