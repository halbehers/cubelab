import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/scan/cube_palette_color.dart';
import 'package:flutter/material.dart';

class CubePalette extends StatefulWidget {
  const CubePalette({super.key, this.onColorSelected});

  final void Function(CubeColor color)? onColorSelected;

  @override
  State<CubePalette> createState() => _CubePaletteState();
}

class _CubePaletteState extends State<CubePalette> {
  late CubeColor selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = CubeColor.white;
  }

  List<CubePaletteColor> buildColorItems(BuildContext context) {
    return CubeColor.values
        .map(
          (color) => CubePaletteColor(
            color: color,
            isSelected: color == selectedColor,
            onTap: () {
              widget.onColorSelected?.call(color);
              setState(() {
                selectedColor = color;
              });
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.0,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buildColorItems(context),
    );
  }
}
