import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';

class SwitchField extends StatefulWidget {
  const SwitchField({
    super.key,
    required this.label,
    this.initialValue = false,
    this.onValueChanged,
  });

  final String label;
  final bool initialValue;
  final void Function(bool value)? onValueChanged;

  @override
  State<SwitchField> createState() => _SwitchFieldState();
}

class _SwitchFieldState extends State<SwitchField> {
  late bool value;

  @override
  void initState() {
    super.initState();

    value = widget.initialValue;
  }

  void _onValueChanged(bool value) {
    setState(() {
      this.value = value;
    });
    widget.onValueChanged?.call(value);
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
          Text(widget.label, style: appTheme.body),
          Switch(
            value: value,
            activeThumbColor: appTheme.secondaryColor,
            onChanged: _onValueChanged,
          ),
        ],
      ),
    );
  }
}
