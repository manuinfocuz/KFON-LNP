import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


import '../../utils/style.dart';
import '../focus_widget.dart';

class ErrorWidgetLocal extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorWidgetLocal({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/error_animation.json',
            height: 200,
          ),
          Text(
            'Network Error',
            style: appTextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          FocusWidgetGlobal(
            isButton: true,
            onClick: onRetry,
            builder: (bool value) => const Text('Retry'),
            onFocusChange: (bool value) {},
          ),
        ],
      ),
    );
  }
}
