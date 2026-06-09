import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:cubelab/scan/cube_state.dart';
import 'package:cubelab/scan/cube_color.dart';
import 'package:cubelab/scan/cube_face_colors.dart';
import 'package:cubelab/scan/cube_phase.dart';

void main() {
  final solvedFaces = <CubeFaceColor>[
    CubeFaceColors(0, List.filled(9, CubeColor.white)),
    CubeFaceColors(1, List.filled(9, CubeColor.red)),
    CubeFaceColors(2, List.filled(9, CubeColor.blue)),
    CubeFaceColors(3, List.filled(9, CubeColor.yellow)),
    CubeFaceColors(4, List.filled(9, CubeColor.orange)),
    CubeFaceColors(5, List.filled(9, CubeColor.green)),
  ];

  test('fromFacelets of solved cube produces solved state', () {
    final state = CubeState.fromFacelets(solvedFaces);

    expect(state.isSolved(), isTrue);
    expect(
      state.cornersPerm,
      equals(Uint8List.fromList(List.generate(8, (i) => i))),
    );
    expect(
      state.edgesPerm,
      equals(Uint8List.fromList(List.generate(12, (i) => i))),
    );
    expect(state.cornersOri, equals(Uint8List(8)));
    expect(state.edgesOri, equals(Uint8List(12)));
  });

  CubeState _createSolvedState() {
    final state = CubeState();
    for (int i = 0; i < 8; i++) {
      state.cornersPerm[i] = i;
      state.cornersOri[i] = 0;
    }
    for (int i = 0; i < 12; i++) {
      state.edgesPerm[i] = i;
      state.edgesOri[i] = 0;
    }
    return state;
  }

  test('fromFacelets rejects invalid face count', () {
    expect(
      () => CubeState.fromFacelets([CubeFaceColors(0, List.filled(9, CubeColor.white))]),
      throwsArgumentError,
    );
  });

  test('current phase detects initial scramble stage', () {
    final state = _createSolvedState();
    state.edgesPerm[0] = 1;
    state.edgesPerm[1] = 0;

    expect(state.getCurrentPhase(), CubePhase.initialScramble);
  });

  test('current phase detects cross stage', () {
    final state = _createSolvedState();
    state.cornersPerm[0] = 1;
    state.cornersPerm[1] = 0;

    expect(state.getCurrentPhase(), CubePhase.cross);
  });

  test('current phase detects f2l stage', () {
    final state = _createSolvedState();
    state.cornersOri[4] = 1;

    expect(state.getCurrentPhase(), CubePhase.f2l);
  });

  test('current phase detects oll stage', () {
    final state = _createSolvedState();
    state.cornersPerm[4] = 5;
    state.cornersPerm[5] = 4;

    expect(state.getCurrentPhase(), CubePhase.oll);
  });

  test('current phase detects solved stage for solved cube', () {
    final state = _createSolvedState();

    expect(state.getCurrentPhase(), CubePhase.solved);
  });
}
