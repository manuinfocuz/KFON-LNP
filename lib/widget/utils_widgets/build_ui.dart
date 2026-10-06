import 'package:flutter/material.dart';
import 'package:kfon_lnp/widget/utils_widgets/error_widget.dart';

import '../focus_widget.dart';

class BuildUI extends StatelessWidget {
  final bool isLoad;
  final bool isError;
  final bool? isEmpty;
  final bool canRefresh;
  final Widget mainUi;
  final String? noDataFoundTitle;
  final Function? onRefreshClick;

  const BuildUI(
      {super.key,
      required this.isLoad,
      required this.isError,
      this.isEmpty = false,
      required this.mainUi,
      this.noDataFoundTitle = "No data Found",
      this.onRefreshClick,
      this.canRefresh = true});

  @override
  Widget build(BuildContext context) {
    return findWidget();
  }

  Widget findWidget() {
    if (isLoad) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError) {
      return ErrorWidgetLocal(onRetry: () {
        onRefreshClick != null ? onRefreshClick!() : null;
      });
    } else if ((isEmpty != null ? isEmpty! : false)) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$noDataFoundTitle"),
            if (canRefresh)
              FocusWidgetGlobal(
                isButton: true,
                onClick: () {
                  onRefreshClick!();
                },
                builder: (bool value) => const Text('Refresh'),
                onFocusChange: (bool value) {},
              ),
          ],
        ),
      );
    } else {
      return mainUi;
    }
  }
}
