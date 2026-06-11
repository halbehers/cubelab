import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/scan/cube_palette.dart';
import 'package:cubelab/scan/cube_sticker.dart';
import 'package:flutter/material.dart';

class CubeFace extends StatefulWidget {
  const CubeFace({
    super.key,
    required this.color,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
    required this.onStickerTap,
  });

  final CubeColor color;
  final List<CubeColor> colors;
  final CubeColor selectedColor;
  final Function(CubeColor) onColorSelected;
  final Function(int) onStickerTap;

  @override
  State<CubeFace> createState() => _CubeFaceState();
}

class _CubeFaceState extends State<CubeFace> {
  @override
  void initState() {
    super.initState();
  }

  List<CubeSticker> buildStickers() {
    return widget.colors
        .asMap()
        .entries
        .map(
          (entry) => CubeSticker(
            color: entry.value,
            locked: entry.key == 4,
            onTap: () => widget.onStickerTap(entry.key),
          ),
        )
        .toList();
  }

  Widget buildColorIndicator(
    BuildContext context,
    CubeAdjacentColorPosition position,
  ) {
    final appTheme = context.appTheme;
    final bool isHorizontal =
        position == CubeAdjacentColorPosition.top ||
        position == CubeAdjacentColorPosition.bottom;
    final double length = 100;
    final double thickness = 7;

    return Container(
      height: isHorizontal ? thickness : length,
      width: isHorizontal ? length : thickness,
      decoration: BoxDecoration(
        color: widget.color.getAdjacentColor(position).toColor(appTheme),
        border: Border.all(
          color: appTheme.borderColor.withValues(alpha: 0.4),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(3.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32.0,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                // Left indicator
                buildColorIndicator(context, CubeAdjacentColorPosition.left),
                const SizedBox(width: 8.0),
                // Grid with top/bottom indicators
                Expanded(
                  child: Column(
                    children: [
                      // Top indicator
                      buildColorIndicator(
                        context,
                        CubeAdjacentColorPosition.top,
                      ),
                      const SizedBox(height: 8.0),
                      // The grid
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: buildStickers(),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Bottom indicator
                      buildColorIndicator(
                        context,
                        CubeAdjacentColorPosition.bottom,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                // Right indicator
                buildColorIndicator(context, CubeAdjacentColorPosition.right),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: CubePalette(onColorSelected: widget.onColorSelected),
        ),
      ],
    );
  }
}
