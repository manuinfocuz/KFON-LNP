
import 'package:flutter/material.dart';

import '../../utils/style.dart';

class GlobalBGWidgetWithBack extends StatefulWidget {
  final bool showLogout;
  final Function()? onBackPress;
  final String? header;
  final bool isHeaderTitle;
  final bool showBackButton;
  final double bgHeight;

  const GlobalBGWidgetWithBack(
      {super.key,
      this.onBackPress,
      this.header,
      this.isHeaderTitle = false,
      this.showBackButton = true,
      this.bgHeight = 400,
      this.showLogout = false});

  @override
  State<GlobalBGWidgetWithBack> createState() => _GlobalBGWidgetWithBackState();
}

class _GlobalBGWidgetWithBackState extends State<GlobalBGWidgetWithBack> {
  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: widget.bgHeight,
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  accentColor,
                  primaryColor,
                ],
              ),
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
                bottomRight: Radius.circular(150),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  if (widget.showBackButton)
                    Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.onBackPress == null) {
                                  return;
                                }
                                if (!widget.showLogout) {
                                  widget.onBackPress!();
                                }
                              },
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (widget.isHeaderTitle)
                              Text(
                                widget.header ?? "",
                                style: appStylishTextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                          ],
                        ),
                      ],
                    ),
                  if (!widget.showBackButton)
                     SizedBox(
                      height:safePadding/5,
                    ),

                  
                  if (!widget.isHeaderTitle)
                    Column(
                      children: [
                        Stack(

                          children: [

                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/splash_logo.png",
                                  height: 50,
                                ),
                              ],
                            ),
                            if (widget.showLogout)
                              Positioned(
                                top: 5,
                                right: 20,
                                child: InkWell(
                                  onTap: () {
                                    if (widget.showLogout) {
                                      widget.onBackPress!();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.logout,
                                    color: primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.header ?? "",
                          style: appStylishTextStyle(
                              fontSize: 26, color: Colors.white),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
