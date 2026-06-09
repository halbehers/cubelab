import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/main.dart';
import 'package:flutter/material.dart';

class CubePaletteColor extends StatelessWidget {
  const CubePaletteColor({
    super.key,
    required this.color,
    this.isSelected = false,
    this.onTap,
  });

  final CubeColor color;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: appTheme.secondaryColor.withValues(
              alpha: isSelected ? 1.0 : 0.0,
            ),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(color: appTheme.borderColor, width: 2.0),
            borderRadius: BorderRadius.circular(16.0),
            color: color.toColor(appTheme),
          ),
        ),
      ),
    );
  }
}
