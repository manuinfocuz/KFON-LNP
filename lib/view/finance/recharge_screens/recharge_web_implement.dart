import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../widget/utils_widgets/global_bg_widget_with_back.dart';

class RechargeWebImplement extends StatefulWidget {
  final String url;
  final Uint8List body;

  const RechargeWebImplement({
    super.key,
    required this.url,
    required this.body,
  });

  @override
  State<RechargeWebImplement> createState() => _RechargeWebImplementState();
}

class _RechargeWebImplementState extends State<RechargeWebImplement> {
  //FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  WebViewController? controller;
  RxBool isLoading = true.obs;

  @override
  void initState() {
    // flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
    //   print(wvs.type);
    // });

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              isLoading.value = false;
            }
          },
          onPageStarted: (String url) {
            //     isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          widget.url,
        ),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        method: LoadRequestMethod.post,
        body: widget.body,
      );

    super.initState();
  }

  @override
  void dispose() {
    try {} catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlobalBGWidgetWithBack(
            header: "Recharge",
            isHeaderTitle: true,
            onBackPress: () {
              Get.back();
            },
          ),
          SafeArea(
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(
                left: 2,
                right: 2,
                top: 70,
              ),
              child: Obx(
                () => ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: controller != null && !isLoading.value
                      ? WebViewWidget(
                          controller: controller!,
                        )
                      : Container(
                          color: Colors.white,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// WebviewScaffold(
// debuggingEnabled: true,
// withJavascript: true,
// appCacheEnabled: true,
// url: Uri.dataFromString(
// widget.html.toString(),
// mimeType: 'text/html',
// ).toString(),
// ),
