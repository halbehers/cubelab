import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/theme/h_icon.dart';
import 'package:cubelab/theme/icon_path.dart';

class ButtonStackItem<ID> {
  const ButtonStackItem({
    required this.id,
    required this.iconPath,
    this.caption,
  });

  final ID id;
  final IconPath iconPath;
  final String? caption;
}

enum ButtonStackSize { small, medium, large }

class ButtonStack<ID> extends StatelessWidget {
  const ButtonStack({
    super.key,
    required this.items,
    this.size = ButtonStackSize.medium,
    this.margin,
    required this.onSelectionChanged,
    this.selectedId,
    this.displayCaptions = false,
  });

  final List<ButtonStackItem<ID>> items;
  final ButtonStackSize size;
  final EdgeInsetsGeometry? margin;
  final void Function(ID) onSelectionChanged;
  final ID? selectedId;
  final bool displayCaptions;

  IconSize getIconSize() {
    switch (size) {
      case ButtonStackSize.small:
        return IconSize.small;
      case ButtonStackSize.medium:
        return IconSize.medium;
      case ButtonStackSize.large:
        return IconSize.large;
    }
  }

  ID getSelectedId() {
    return selectedId ?? items.first.id;
  }

  bool _hasCaption(ButtonStackItem<ID> item) =>
      displayCaptions && item.caption != null;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;
    return Container(
      decoration: BoxDecoration(
        color: appTheme.highlightedBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(displayCaptions ? 24.0 : 1000.0),
        ),
        border: BoxBorder.all(color: appTheme.borderColor),
        boxShadow: [
          BoxShadow(
            color: appTheme.shadowColor,
            blurRadius: 7,
            spreadRadius: -3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: margin,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: 12,
          horizontal: items.length == 1 && !_hasCaption(items[0]) ? 12 : 24,
        ),
        child: Wrap(
          spacing: displayCaptions ? 24 : 16,
          children: items
              .map(
                (item) => GestureDetector(
                  onTap: () => onSelectionChanged(item.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HIcon(
                        iconPath: item.iconPath,
                        isActive: getSelectedId() == item.id,
                        size: getIconSize(),
                      ),
                      ...(_hasCaption(item)
                          ? [
                              Padding(
                                padding: const EdgeInsetsGeometry.only(top: 4),
                                child: Text(
                                  item.caption!,
                                  style: getSelectedId() == item.id
                                      ? appTheme.smallTextSecondary
                                      : appTheme.smallText,
                                ),
                              ),
                            ]
                          : []),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
