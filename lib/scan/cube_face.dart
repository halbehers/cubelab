import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/scan/cube_palette.dart';
import 'package:cubelab/scan/cube_sticker.dart';
import 'package:flutter/material.dart';

class CubeFace extends StatefulWidget {
  const CubeFace({super.key, required this.color});

  final CubeColor color;

  @override
  State<CubeFace> createState() => _CubeFaceState();
}

class _CubeFaceState extends State<CubeFace> {
  late List<CubeColor> faceColors;
  late CubeColor selectedColor;

  @override
  void initState() {
    super.initState();
    faceColors = List.filled(9, widget.color);
    selectedColor = CubeColor.white;
  }

  void setSelectedColor(CubeColor color) {
    selectedColor = color;
  }

  List<CubeSticker> buildStickers() {
    return faceColors
        .asMap()
        .entries
        .map(
          (entry) => CubeSticker(
            color: entry.value,
            locked: entry.key == 4,
            onTap: () => setState(() {
              faceColors[entry.key] = selectedColor;
            }),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32.0,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: buildStickers(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: CubePalette(onColorSelected: setSelectedColor),
        ),
      ],
    );
  }
}
