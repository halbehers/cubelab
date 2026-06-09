import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/main.dart';
import 'package:flutter/material.dart';

class CubeSticker extends StatelessWidget {
  const CubeSticker({super.key, this.color, this.onTap, this.locked = false});

  final CubeColor? color;
  final VoidCallback? onTap;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return GestureDetector(
      onTap: () {
        if (locked) {
          return;
        }
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: locked
                ? appTheme.borderColor.withValues(alpha: 0.4)
                : appTheme.borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: color?.toColor(appTheme) ?? appTheme.borderColor,
        ),
        height: 50,
      ),
    );
  }
}
