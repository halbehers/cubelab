import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/cube/cube_state.dart';
import 'package:cubelab/helpers/logger.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/scan/cube_face.dart';
import 'package:cubelab/theme/icon_path.dart';
import 'package:cubelab/ui/buttons/button.dart';
import 'package:cubelab/ui/cube_3d.dart';
import 'package:cubelab/ui/custom_bottom_sheet.dart';
import 'package:cubelab/l10n/scan/scan_localizations.dart';
import 'package:flutter/material.dart' hide TextField;

enum CubeStateFormState { initial, filled, error }

class CubeStateForm extends StatefulWidget {
  const CubeStateForm({
    super.key,
    required this.onClose,
    this.onStateCreated,
    this.onFormStateChanged,
  });

  final void Function() onClose;
  final void Function(CubeState state)? onStateCreated;
  final void Function(CubeStateFormState state)? onFormStateChanged;

  @override
  State<CubeStateForm> createState() => _CubeStateFormState();
}

class _CubeStateFormState extends State<CubeStateForm> {
  final _formKey = GlobalKey<FormState>();
  CubeStateFormState _state = CubeStateFormState.initial;
  int currentFaceIndex = 0;
  late Map<int, List<CubeColor>> faceColors;
  late CubeColor selectedColor;
  CubeState? cubeState;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    faceColors = {};
    for (int i = 0; i < 6; i++) {
      faceColors[i] = List.filled(9, CubeColor.values[i]);
    }
    selectedColor = CubeColor.white;
  }

  void _onSubmit(BuildContext context) {
    final t = ScanLocalizations.of(context)!;

    if (!_validate()) {
      setState(() => _errorMessage = t.error_invalid_color_count);
      return;
    }

    final faces = List.generate(6, (i) => faceColors[i]!);

    try {
      final state = CubeState.fromFacelets(faces);
      widget.onStateCreated?.call(state);
      getLogger().d('cube state: $state');
      setState(() {
        _errorMessage = null;
        cubeState = state;
      });
    } on FormatException {
      setState(() {
        _state = CubeStateFormState.error;
        _errorMessage = t.error_invalid_geometry;
      });
      widget.onFormStateChanged?.call(CubeStateFormState.error);
    }
  }

  bool _validate() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    final counts = List<int>.filled(CubeColor.values.length, 0);
    for (final colors in faceColors.values) {
      for (final c in colors) {
        final idx = c.index;
        final next = counts[idx] + 1;
        if (next > 9) return false; // too many of this color
        counts[idx] = next;
      }
    }
    // Ensure every color appears exactly 9 times
    for (final cnt in counts) {
      if (cnt != 9) return false;
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

  List<CubeFace> _buildCubeFaces() {
    return List.generate(
      6,
      (index) => CubeFace(
        key: ValueKey(CubeColor.values[index]),
        color: CubeColor.values[index],
        colors: faceColors[index]!,
        selectedColor: selectedColor,
        onColorSelected: (color) => setState(() => selectedColor = color),
        onStickerTap: (stickerIndex) => setState(() {
          faceColors[index]![stickerIndex] = selectedColor;
          _errorMessage = null;
        }),
      ),
    );
  }

  Widget buildReviewPanel() {
    getLogger().d("buildReviewPanel");
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Cube3D(cubeState: cubeState!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final t = ScanLocalizations.of(context)!;

    final cubeFaces = _buildCubeFaces();

    return CustomBottomSheet(
      onClose: widget.onClose,
      title: t.new_cube_state,
      isSubmittable: false,
      child: SafeArea(
        top: false,
        child: cubeState == null
            ? Form(
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
                    Expanded(child: cubeFaces[currentFaceIndex]),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          _errorMessage!,
                          style: appTheme.smallText.copyWith(
                            color: appTheme.dangerColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Button(
                            text: t.previous_face,
                            onPressed: () => setState(() {
                              if (currentFaceIndex > 0) currentFaceIndex--;
                            }),
                            disabled: currentFaceIndex == 0,
                            icon: IconPath.arrowLeft,
                            iconPosition: ButtonIconPosition.left,
                            type: ButtonType.ghost,
                            textStyle: appTheme.smallText,
                          ),
                          if (currentFaceIndex < 5)
                            Button(
                              text: t.next_face,
                              onPressed: () => setState(() {
                                if (currentFaceIndex < 5) currentFaceIndex++;
                              }),
                              icon: IconPath.arrowRight,
                              iconPosition: ButtonIconPosition.right,
                              type: ButtonType.ghost,
                              textStyle: appTheme.smallText,
                              disabled: currentFaceIndex == 5,
                            ),
                          if (currentFaceIndex == 5)
                            Button(
                              text: t.review,
                              onPressed: () => _onSubmit(context),
                              icon: IconPath.check,
                              iconPosition: ButtonIconPosition.right,
                              type: ButtonType.outlined,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : buildReviewPanel(),
      ),
    );
  }
}
