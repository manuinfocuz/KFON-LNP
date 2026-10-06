import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusWidgetGlobal extends StatefulWidget {
  final Widget Function(bool value) builder;
  final Function()? onClick;
  final Function(bool value) onFocusChange;
  final bool autofocus;
  final bool isButton;

  const FocusWidgetGlobal(
      {Key? key,
      required this.builder,
      required this.onFocusChange,
      required this.onClick,
      this.autofocus = false,
      this.isButton = false})
      : super(key: key);

  @override
  State<FocusWidgetGlobal> createState() => _FocusWidgetGlobalState();
}

class _FocusWidgetGlobalState extends State<FocusWidgetGlobal> {
  var isFocus = false;

  @override
  Widget build(BuildContext context) {
    return !widget.isButton
        ? InkWell(
            autofocus: widget.autofocus,
            onFocusChange: widget.onFocusChange,
            onTap: widget.onClick,
            child: widget.builder(isFocus),
          )
        : ElevatedButton(
            autofocus: widget.autofocus,
            onFocusChange: widget.onFocusChange,
            onPressed: widget.onClick,
            child: widget.builder(isFocus),
          );
  }
}
