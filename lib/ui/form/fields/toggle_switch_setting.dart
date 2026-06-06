import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleSwitchItem<T> {
  const ToggleSwitchItem({required this.label, required this.value});

  final String label;
  final T value;
}

class ToggleSwitchField<T extends Enum> extends StatelessWidget {
  const ToggleSwitchField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onValueChanged,
    required this.items,
  });

  final String label;
  final T initialValue;
  final void Function(T value)? onValueChanged;
  final List<ToggleSwitchItem<T>> items;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;

    final int initialLabelIndex = items.indexWhere(
      (item) => item.value == initialValue,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: appTheme.body),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Center(
              child: ToggleSwitch(
                initialLabelIndex: initialLabelIndex,
                totalSwitches: items.length,
                customHeights: items.map((_) => 32.0).toList(),
                cornerRadius: 16.0,
                activeBgColor: [appTheme.secondaryColor],
                activeFgColor: appTheme.invertedTextColor,
                inactiveBgColor: appTheme.backgroundColor,
                inactiveFgColor: appTheme.subduedTextColor,
                animate: true,
                curve: Curves.elasticInOut,
                animationDuration: 200,
                dividerColor: appTheme.borderColor,
                radiusStyle: true,
                labels: items.map((item) => item.label).toList(),
                onToggle: (index) {
                  onValueChanged?.call(items[index!].value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
