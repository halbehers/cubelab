import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/scan/cube_face.dart';
import 'package:cubelab/ui/custom_bottom_sheet.dart';
import 'package:cubelab/l10n/scan/scan_localizations.dart';
import 'package:flutter/material.dart' hide TextField;

final _formKey = GlobalKey<FormState>();

enum CubeStateFormState { initial, filled, error }

class CubeStateForm extends StatefulWidget {
  const CubeStateForm({
    super.key,
    required this.onClose,
    this.onFormStateChanged,
  });

  final void Function() onClose;
  final void Function(CubeStateFormState state)? onFormStateChanged;

  @override
  State<CubeStateForm> createState() => _CubeStateFormState();
}

class _CubeStateFormState extends State<CubeStateForm> {
  CubeStateFormState _state = CubeStateFormState.initial;

  @override
  void initState() {
    super.initState();
  }

  void _onSubmit(BuildContext context) {
    if (_validate()) {
      widget.onClose();
    }
  }

  bool _validate() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    return true;
  }

  bool _isDirty() {
    // TODO
    return true;
  }

  void _updateState() {
    final previousState = _state;

    setState(() {
      if (!_validate()) {
        _state = CubeStateFormState.error;
      } else if (_isDirty()) {
        _state = CubeStateFormState.filled;
      } else {
        _state = CubeStateFormState.initial;
      }
      if (previousState != _state) widget.onFormStateChanged?.call(_state);
    });
  }

  void _onValueChanged<T>(T value, void Function(T) setter) {
    setter(value);
    _updateState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final t = ScanLocalizations.of(context)!;

    return CustomBottomSheet(
      onClose: widget.onClose,
      title: t.new_cube_state,
      isSubmittable: true,
      isSubmitEnabled: _state == CubeStateFormState.filled,
      onSubmit: () => _onSubmit(context),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 32.0,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 0.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                t.new_cube_state_description,
                style: appTheme.subduedBody,
              ),
            ),
            const Expanded(child: CubeFace(color: CubeColor.white)),
          ],
        ),
      ),
    );
  }
}
