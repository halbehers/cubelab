import 'package:cubelab/main.dart';
import 'package:flutter/material.dart';

enum ButtonType { filled, outlined, ghost }

enum ButtonIconPosition { left, right }

class Button extends StatelessWidget {
  final String text;
  final Widget? icon;
  final ButtonType type;
  final ButtonIconPosition iconPosition;
  final bool disabled;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;

  const Button({
    super.key,
    required this.text,
    this.icon,
    this.type = ButtonType.filled,
    this.iconPosition = ButtonIconPosition.left,
    this.disabled = false,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  bool get _isEnabled => !disabled && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final primaryColor = appTheme.primaryColor;
    final onPrimaryColor = appTheme.secondaryColor;
    final disabledColor = appTheme.disabledTextColor;
    final textColor = _isEnabled
        ? (type == ButtonType.filled ? onPrimaryColor : primaryColor)
        : disabledColor;

    final buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null && iconPosition == ButtonIconPosition.left) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(text),
        if (icon != null && iconPosition == ButtonIconPosition.right) ...[
          const SizedBox(width: 8),
          icon!,
        ],
      ],
    );

    final buttonStyle = ButtonStyle(
      padding: WidgetStateProperty.all(padding),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor;
        }
        return textColor;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (type == ButtonType.filled) {
          if (states.contains(WidgetState.disabled)) {
            return disabledColor.withValues(alpha: 0.12);
          }
          return primaryColor;
        }
        return Colors.transparent;
      }),
      side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
        if (type == ButtonType.outlined) {
          return BorderSide(
            color: states.contains(WidgetState.disabled)
                ? disabledColor.withValues(alpha: 0.38)
                : primaryColor,
          );
        }
        return null;
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return primaryColor.withValues(alpha: 0.12);
        }
        return null;
      }),
    );

    switch (type) {
      case ButtonType.filled:
        return ElevatedButton(
          style: buttonStyle,
          onPressed: _isEnabled ? onPressed : null,
          child: buttonChild,
        );
      case ButtonType.outlined:
        return OutlinedButton(
          style: buttonStyle,
          onPressed: _isEnabled ? onPressed : null,
          child: buttonChild,
        );
      case ButtonType.ghost:
        return TextButton(
          style: buttonStyle,
          onPressed: _isEnabled ? onPressed : null,
          child: buttonChild,
        );
    }
  }
}
