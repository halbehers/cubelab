import 'package:cubelab/main.dart';
import 'package:cubelab/theme/h_icon.dart';
import 'package:cubelab/theme/icon_path.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.child,
    required this.onClose,
    this.title,
    this.onSubmit,
    this.isSubmittable = false,
    this.isSubmitEnabled = true,
  });

  final Widget child;
  final void Function() onClose;
  final String? title;
  final bool isSubmittable;
  final bool isSubmitEnabled;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return MakeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.9,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: appTheme.backgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(32.0),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onClose,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: HIcon(iconPath: IconPath.cross),
                    ),
                  ),
                  if (title != null) Text(title!, style: appTheme.h3),
                  GestureDetector(
                    onTap: () {
                      if (isSubmittable &&
                          isSubmitEnabled &&
                          onSubmit != null) {
                        onSubmit?.call();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: isSubmittable
                          ? HIcon(
                              iconPath: IconPath.check,
                              size: IconSize.large,
                              color: isSubmitEnabled
                                  ? appTheme.textColor
                                  : appTheme.disabledTextColor,
                            )
                          : SizedBox.fromSize(
                              size: Size.square(IconSize.large.value),
                            ),
                    ),
                  ),
                ],
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class MakeDismissible extends StatelessWidget {
  const MakeDismissible({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(onTap: () {}, child: child),
    );
  }
}
