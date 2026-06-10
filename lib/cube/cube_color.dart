import 'package:cubelab/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum CubeAdjacentColorPosition { top, bottom, left, right }

enum CubeColor {
  white("W"),
  red("R"),
  blue("B"),
  orange("O"),
  green("G"),
  yellow("Y");

  const CubeColor(this.abbreviation);

  final String abbreviation;

  static final Map<CubeColor, Map<CubeAdjacentColorPosition, CubeColor>>
  adjacentColorInOrderFromTopByColor = {
    CubeColor.white: {
      CubeAdjacentColorPosition.top: CubeColor.blue,
      CubeAdjacentColorPosition.right: CubeColor.red,
      CubeAdjacentColorPosition.bottom: CubeColor.green,
      CubeAdjacentColorPosition.left: CubeColor.orange,
    },
    CubeColor.red: {
      CubeAdjacentColorPosition.top: CubeColor.white,
      CubeAdjacentColorPosition.right: CubeColor.blue,
      CubeAdjacentColorPosition.bottom: CubeColor.yellow,
      CubeAdjacentColorPosition.left: CubeColor.green,
    },
    CubeColor.blue: {
      CubeAdjacentColorPosition.top: CubeColor.white,
      CubeAdjacentColorPosition.right: CubeColor.orange,
      CubeAdjacentColorPosition.bottom: CubeColor.yellow,
      CubeAdjacentColorPosition.left: CubeColor.red,
    },
    CubeColor.orange: {
      CubeAdjacentColorPosition.top: CubeColor.white,
      CubeAdjacentColorPosition.right: CubeColor.green,
      CubeAdjacentColorPosition.bottom: CubeColor.yellow,
      CubeAdjacentColorPosition.left: CubeColor.blue,
    },
    CubeColor.green: {
      CubeAdjacentColorPosition.top: CubeColor.white,
      CubeAdjacentColorPosition.right: CubeColor.red,
      CubeAdjacentColorPosition.bottom: CubeColor.yellow,
      CubeAdjacentColorPosition.left: CubeColor.orange,
    },
    CubeColor.yellow: {
      CubeAdjacentColorPosition.top: CubeColor.green,
      CubeAdjacentColorPosition.right: CubeColor.red,
      CubeAdjacentColorPosition.bottom: CubeColor.blue,
      CubeAdjacentColorPosition.left: CubeColor.orange,
    },
  };

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

  CubeColor getAdjacentColor(CubeAdjacentColorPosition position) {
    return adjacentColorInOrderFromTopByColor[this]![position]!;
  }
}
