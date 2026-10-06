import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kfon_lnp/utils/style.dart';

class CustomTextField extends StatefulWidget {
  final String? lableText;

  final TextEditingController controller;
  final bool isPassword;
  final Function(String value)? onChangeText;
  final String? hintText;
  final TextInputType? inputType;
  final List<TextInputFormatter> inputFormatter;
  final String? errorText;
  bool isAddress = false;
  bool isEditable = true;
  bool isPhone = false;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final int? maxLength;
  final bool showFiledCount;
  final Function? onTab;
  final Color errorColor;
  final bool autoCap;
  final bool intialPasswordVisible;
  final bool isRequired;
  final bool canClick;
  final bool needIncrease;
  final Function()? onIncrease;
  final Function()? onDecrease;
  CustomTextField({
    Key? key,
    required this.lableText,
    this.isPassword = false,
    this.onChangeText,
    required this.controller,
    this.hintText,
    this.inputType,
    this.inputFormatter = const [],
    this.errorText,
    this.isAddress = false,
    this.isEditable = true,
    this.isPhone = false,
    this.suffixIcon,
    this.prefixWidget,
    this.maxLength = 0,
    this.showFiledCount = false,
    this.onTab,
    this.errorColor = Colors.red,
    this.autoCap = false,
    this.intialPasswordVisible = false,
    this.isRequired = false,
    this.canClick = true,
    this.needIncrease = false,
    this.onIncrease,
    this.onDecrease,
  }) : super(key: key);

  AnimationController? _animationController;

  void callFun() {
    print(_animationController);
    _animationController?.forward(from: 0.0);
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passvisible = false;
  bool isFirst = false;

  callme() {}

  @override
  void initState() {
    passvisible = widget.intialPasswordVisible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> textFormatter = List.from(widget.inputFormatter);

    if (widget.autoCap) {
      textFormatter.add(
        UpperCaseTextFormatter(),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              // color: Colors.red,
              child: TextField(
                textInputAction: TextInputAction.next,
                // textCapitalization: widget.autoCap
                //     ? TextCapitalization.characters
                //     : TextCapitalization.none,
                onTap: () {
                  if (widget.onTab != null) {
                    widget.onTab!();
                  }
                },
                readOnly: !widget.isEditable,
                maxLines: widget.isAddress == true ? 3 : 1,
                inputFormatters: textFormatter,
                maxLength: widget.maxLength != 0
                    ? widget.maxLength
                    : widget.isPhone
                        ? 10
                        : null,
                keyboardType: widget.inputType ?? TextInputType.text,
                obscureText: widget.isPassword ? !passvisible : passvisible,
                controller: widget.controller,
                onChanged: widget.onChangeText,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  label: widget.lableText != null &&
                          (widget.lableText?.isNotEmpty ?? false)
                      ? Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: Text(
                                  widget.lableText ?? "",
                                ),
                              ),
                              if (widget.isRequired)
                                const WidgetSpan(
                                  child: Text(
                                    '*',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  counterText: !widget.showFiledCount ? "" : null,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.isAddress == true ? 5 : 2,
                    horizontal: 8,
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                  // labelText: widget.lableText,
                  hintText: widget.hintText ?? "",
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(
                  //     8,
                  //   ),
                  //   borderSide: const BorderSide(
                  //     color: Colors.red,
                  //   ),
                  // ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    borderSide: BorderSide(
                      color: widget.canClick ? primaryColor : Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    borderSide: BorderSide(
                      color: widget.canClick ? primaryColor : Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  prefix: widget.prefixWidget,
                  suffixIcon: widget.suffixIcon ??
                      (widget.isPassword
                          ? InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    passvisible = !passvisible;
                                  },
                                );
                              },
                              child: GestureDetector(
                                onLongPressStart: (details) {
                                  if (!passvisible) {
                                    setState(
                                      () {
                                        passvisible = true;
                                      },
                                    );
                                  }
                                },
                                onLongPressEnd: (details) {
                                  if (passvisible) {
                                    setState(
                                      () {
                                        passvisible = false;
                                      },
                                    );
                                  }
                                },
                                onTapCancel: () {
                                  if (!passvisible) {
                                    setState(
                                      () {
                                        passvisible = false;
                                      },
                                    );
                                  }
                                },
                                onTap: () {
                                  setState(
                                    () {
                                      passvisible = !passvisible;
                                    },
                                  );
                                },
                                child: Icon(
                                  !passvisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: widget.isPassword ? 20 : 0,
                                ),
                              ),
                            )
                          : null),
                ),
              ),
            ),
            if (widget.needIncrease)
              Positioned(
                right: 10,
                bottom: 5,
                top: 5,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.6),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.arrow_circle_up_sharp,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.onDecrease?.call();
                        },
                        child: const Icon(
                          Icons.arrow_circle_down_sharp,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
        widget.errorText != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${widget.errorText}",
                    style: TextStyle(
                      color: widget.errorColor,
                    ),
                  )
                ],
              )
            : const SizedBox()
      ],
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
