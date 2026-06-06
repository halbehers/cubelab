import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/theme/icon_path.dart';

enum IconSize {
  small(18),
  medium(24),
  large(32);

  const IconSize(this.value);

  final double value;
}

class IconColorMapper extends ColorMapper {
  const IconColorMapper({
    required this.appTheme,
    this.isActive = false,
    this.color,
  });

  final AppTheme appTheme;
  final bool isActive;
  final Color? color;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    if (color == const Color(0xFF000000)) {
      return this.color ??
          (isActive ? appTheme.iconActiveColor : appTheme.iconColor);
    }
    return color;
  }
}

class HIcon extends StatelessWidget {
  const HIcon({
    super.key,
    required this.iconPath,
    this.isActive = false,
    this.size = IconSize.medium,
    this.color,
  });

  final IconPath iconPath;
  final bool isActive;
  final IconSize size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;

    if (iconPath == IconPath.empty) {
      return SizedBox(width: size.value, height: size.value);
    }

    return SvgPicture.asset(
      iconPath.path,
      width: size.value,
      height: size.value,
      colorMapper: IconColorMapper(
        appTheme: appTheme,
        color: color,
        isActive: isActive,
      ),
    );
  }
}
