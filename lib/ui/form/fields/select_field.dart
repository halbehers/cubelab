import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/theme/h_icon.dart';
import 'package:cubelab/theme/icon_path.dart';

class SelectItem<T> {
  const SelectItem({required this.label, required this.value});

  final String label;
  final T value;
}

class SelectField<T> extends StatefulWidget {
  const SelectField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onValueChanged,
    required this.items,
  });

  final String label;
  final T initialValue;
  final void Function(T value)? onValueChanged;
  final List<SelectItem<T>> items;

  @override
  State<SelectField<T>> createState() => _SelectFieldState<T>();
}

class _SelectFieldState<T> extends State<SelectField<T>> {
  late T selectedValue = widget.initialValue;

  void _onValueChanged(T value) {
    widget.onValueChanged?.call(value);
    setState(() {
      selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.0,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              widget.label,
              style: appTheme.body,
              overflow: TextOverflow.clip,
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: DropdownButton<T>(
              value: selectedValue,
              isExpanded: true,
              icon: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: HIcon(
                  iconPath: IconPath.arrowBottom,
                  size: IconSize.small,
                ),
              ),
              underline: Container(height: 2, color: appTheme.borderColor),
              borderRadius: BorderRadius.circular(16.0),
              dropdownColor: appTheme.highlightedBackgroundColor,
              items: widget.items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item.value,
                      child: Text(item.label, style: appTheme.body),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) _onValueChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
