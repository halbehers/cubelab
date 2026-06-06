import 'package:flutter/material.dart';
import 'package:cubelab/theme/h_icon.dart';
import 'package:cubelab/theme/icon_path.dart';
import 'package:cubelab/theme/app_theme.dart';

class CalendarHeaderBackButton {
  const CalendarHeaderBackButton({
    this.display = true,
    required this.text,
    this.onTap,
    this.style,
  });

  final bool display;
  final String text;
  final VoidCallback? onTap;
  final TextStyle? style;
}

class CalendarHeader extends StatelessWidget implements PreferredSizeWidget {
  const CalendarHeader({
    super.key,
    required this.selectedViewIndex,
    required this.onViewIndexChanged,
    this.backButton,
  });

  final int selectedViewIndex;
  final void Function(int) onViewIndexChanged;
  final CalendarHeaderBackButton? backButton;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    final bool displayBackButton = backButton != null && backButton!.display;
    final bool displayBackButtonAsButton =
        backButton != null && backButton!.onTap != null;

    return AppBar(
      backgroundColor: appTheme.backgroundColor,
      flexibleSpace: const SizedBox.shrink(),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8,
          vertical: 24,
        ),
        child: Row(
          mainAxisAlignment: displayBackButton
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (displayBackButton)
              GestureDetector(
                onTap: backButton!.onTap,
                child: Container(
                  decoration: displayBackButtonAsButton
                      ? BoxDecoration(
                          color: appTheme.highlightedBackgroundColor,
                          borderRadius: BorderRadius.circular(1000.0),
                          border: BoxBorder.all(color: appTheme.borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: appTheme.shadowColor,
                              blurRadius: 7,
                              spreadRadius: -3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        )
                      : null,
                  child: Padding(
                    padding: const EdgeInsetsGeometry.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Wrap(
                      spacing: 8.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (displayBackButtonAsButton)
                          const HIcon(
                            iconPath: IconPath.arrowLeft,
                            size: IconSize.small,
                          ),
                        Text(
                          backButton!.text,
                          style: backButton!.style ?? appTheme.body,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(400, 70);
}
