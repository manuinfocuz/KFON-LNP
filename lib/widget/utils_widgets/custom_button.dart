import 'package:flutter/material.dart';

import '../../utils/style.dart';

class CustomButton extends StatefulWidget {
  final String title;

  final Color fontColor;
  final Color iconColor;
  final IconData? icon;
  final String? imagePath;
  final Function() onClickFunction;
  final Function()? onLongClick;
  final Color buttonColor;
  final Color textColor;
  final bool isLoad;
  final bool isIconLeft;
  final BorderRadiusGeometry? borderRadius;
  final bool isBorderButton;

  const CustomButton({
    super.key,
    required this.title,
    this.fontColor = Colors.white,
    this.iconColor = Colors.white,
    this.icon,
    this.imagePath,
    required this.onClickFunction,
    this.buttonColor = accentColor,
    this.textColor = Colors.white,
    this.isLoad = false,
    this.isIconLeft = true,
    this.onLongClick,
    this.borderRadius,
    this.isBorderButton = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: widget.isBorderButton ? Colors.transparent : widget.buttonColor,
        borderRadius: widget.borderRadius ??
            BorderRadius.circular(
              40,
            ),
        border: widget.isBorderButton
            ? Border.all(
                color: widget.buttonColor,
                width: 2,
              )
            : null,
      ),
      child: ElevatedButton(
        onLongPress: () {
          widget.onLongClick?.call();
        },
        onPressed: () {
          !widget.isLoad ? widget.onClickFunction() : null;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: widget.isLoad
            ? const CircularProgressIndicator(
                color: primaryColor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.icon != null || widget.imagePath != null)
                    Row(
                      children: [
                        if (widget.icon != null && widget.isIconLeft)
                          Icon(
                            widget.icon,
                            color: widget.iconColor,
                          ),
                        if (widget.imagePath != null)
                          Image.asset(
                            "${widget.imagePath}",
                            height: 30,
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  Text(
                    widget.title,
                    style: appTextStyle(
                      color: widget.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (widget.icon != null && !widget.isIconLeft)
                    Icon(
                      widget.icon,
                      color: widget.iconColor,
                    ),
                ],
              ),
      ),
    );
  }
}
