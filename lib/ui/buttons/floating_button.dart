import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/theme/h_icon.dart';
import 'package:cubelab/theme/icon_path.dart';
import 'package:cubelab/ui/glossy_container.dart';

enum FloatingButtonSize { small, medium, large }

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.iconPath,
    this.caption,
    this.iconSize = IconSize.medium,
    this.displayCaptions = false,
    this.squared = false,
    this.onTap,
  });

  final IconSize iconSize;
  final IconPath iconPath;
  final String? caption;
  final bool displayCaptions;
  final bool squared;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;

    return GlossyContainer(
      opacity: 0.2,
      color: appTheme.pureHighlightColor,
      borderRadius: BorderRadius.circular(squared ? 8.0 : 1000.0),
      border: BoxBorder.all(color: appTheme.borderColor),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 12.0,
            children: [
              HIcon(iconPath: iconPath, size: iconSize),
              if (displayCaptions && caption != null)
                Text(caption!, style: appTheme.body),
            ],
          ),
        ),
      ),
    );
  }
}
