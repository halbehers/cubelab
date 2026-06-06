import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/theme/app_theme.dart';

class ButtonSettingConfirm {
  const ButtonSettingConfirm({
    this.display = true,
    this.title,
    required this.content,
    this.confirmText,
    this.cancelText,
  });

  final bool display;
  final String? title;
  final String content;
  final String? confirmText;
  final String? cancelText;
}

class ButtonSetting extends StatefulWidget {
  const ButtonSetting({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textStyle,
    required this.onTap,
    this.withConfirm,
  });

  final String label;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final void Function() onTap;
  final ButtonSettingConfirm? withConfirm;

  @override
  State<ButtonSetting> createState() => _ButtonSettingState();
}

class _ButtonSettingState extends State<ButtonSetting> {
  void _onTap(BuildContext context) {
    if (widget.withConfirm == null) return;

    AppTheme appTheme = context.appTheme;

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: appTheme.highlightedBackgroundColor,
          title: widget.withConfirm!.title != null
              ? Text(widget.withConfirm!.title!)
              : null,
          content: Text(widget.withConfirm!.content, style: appTheme.subduedH4),
          actions: [
            GestureDetector(
              onTap: () {
                widget.onTap();

                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? appTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  widget.withConfirm!.confirmText ?? 'Yes',
                  style: widget.textStyle ?? appTheme.invertedBody,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.withConfirm!.cancelText ?? 'No',
                  style: appTheme.body,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;

    return GestureDetector(
      onTap: () =>
          widget.withConfirm != null ? _onTap(context) : widget.onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? appTheme.secondaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            widget.label,
            style: widget.textStyle ?? appTheme.invertedBody,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
