import 'package:cubelab/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum CubeColor {
  white("W"),
  red("R"),
  blue("B"),
  orange("O"),
  green("G"),
  yellow("Y");

  const CubeColor(this.abbreviation);

  final String abbreviation;

  Color toColor(AppTheme appTheme) {
    switch (this) {
      case CubeColor.white:
        return appTheme.cubeWhiteColor;
      case CubeColor.red:
        return appTheme.cubeRedColor;
      case CubeColor.blue:
        return appTheme.cubeBlueColor;
      case CubeColor.orange:
        return appTheme.cubeOrangeColor;
      case CubeColor.green:
        return appTheme.cubeGreenColor;
      case CubeColor.yellow:
        return appTheme.cubeYellowColor;
    }
  }
}
