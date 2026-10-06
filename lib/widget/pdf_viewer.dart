import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kfon_lnp/utils/style.dart';
import 'package:share_plus/share_plus.dart';

import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../utils/global_functions.dart';
import 'global_loader/global_loading_dialog_controller.dart';

class PDFViewerPlugin extends StatefulWidget {
  final File file;

  const PDFViewerPlugin({super.key, required this.file});

  @override
  State<PDFViewerPlugin> createState() => _PDFViewerPluginState();
}

class _PDFViewerPluginState extends State<PDFViewerPlugin> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      GlobalLoadingDialogController.openDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Invoice",
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          color: Colors.white,
          onPressed: () async {
            final result =
                await SharePlus.instance.share(
                  ShareParams(
                    files: [XFile(widget.file.path)]
                  )
                );
          },
          icon: const Icon(
            Icons.share,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SfPdfViewerTheme(
        data: const SfPdfViewerThemeData(
          backgroundColor: Colors.white, //<----
        ),
        child: SfPdfViewer.file(
          widget.file,
          onDocumentLoaded: (details) {
            GlobalLoadingDialogController.closeDialog();
          },
          onDocumentLoadFailed: (de) {
            GlobalLoadingDialogController.closeDialog();
            Get.back();
            GlobalFunctions.showToast(de.error, false);
          },
        ),
      ),
    );
  }
}
