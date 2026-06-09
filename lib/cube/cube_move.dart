import 'dart:typed_data';

import 'package:cubelab/cube/cube_face.dart';
import 'package:cubelab/cube/cube_state.dart';

class CubeMove {
  CubeMove(this.face, this.rotation);

  final int face; // 0-5 for U, R, F, D, L, B
  // 1 for 90 degrees clockwise, 2 for 180 degrees, 3 for 90 degrees counterclockwise
  final int rotation;

  static const List<List<int>> _cornerPerms = [
    [3, 0, 1, 2, 4, 5, 6, 7],
    [4, 1, 2, 0, 7, 5, 6, 3],
    [1, 5, 2, 3, 0, 4, 6, 7],
    [0, 1, 2, 3, 5, 6, 7, 4],
    [0, 2, 6, 3, 4, 1, 5, 7],
    [0, 1, 3, 7, 4, 5, 2, 6],
  ];

  static const List<List<int>> _cornerOriDeltas = [
    [0, 0, 0, 0, 0, 0, 0, 0],
    [2, 0, 0, 1, 1, 0, 0, 2],
    [1, 2, 0, 0, 2, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 1, 2, 0, 0, 2, 1, 0],
    [0, 0, 1, 2, 0, 0, 2, 1],
  ];

  static const List<List<int>> _edgePerms = [
    [3, 0, 1, 2, 4, 5, 6, 7, 8, 9, 10, 11],
    [8, 1, 2, 3, 0, 5, 6, 7, 4, 9, 10, 11],
    [0, 9, 2, 3, 8, 1, 6, 7, 4, 5, 10, 11],
    [0, 1, 2, 3, 5, 6, 7, 4, 8, 9, 10, 11],
    [0, 1, 10, 3, 4, 5, 9, 7, 8, 2, 6, 11],
    [0, 1, 2, 11, 4, 5, 6, 10, 8, 9, 3, 7],
  ];

  static const List<List<int>> _edgeOriDeltas = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1],
  ];

  static CubeMove fromString(String move) {
    int face = CubeFace.indexFromName(move[0]);
    int rotation = 1; // default is 90 degrees clockwise
    if (move.length > 1) {
      if (move[1] == '2') {
        rotation = 2;
      } else if (move[1] == '\'') {
        rotation = 3;
      }
    }
    return CubeMove(face, rotation);
  }

  void apply(CubeState state) {
    for (int i = 0; i < rotation; i++) {
      _applyFace(state, face);
    }
  }

  static void _applyFace(CubeState state, int face) {
    final oldCornersPerm = Uint8List.fromList(state.cornersPerm);
    final oldCornersOri = Uint8List.fromList(state.cornersOri);
    final oldEdgesPerm = Uint8List.fromList(state.edgesPerm);
    final oldEdgesOri = Uint8List.fromList(state.edgesOri);

    final cornerPerm = _cornerPerms[face];
    final cornerOriDelta = _cornerOriDeltas[face];
    final edgePerm = _edgePerms[face];
    final edgeOriDelta = _edgeOriDeltas[face];

    for (int i = 0; i < 8; i++) {
      final permuted = cornerPerm[i];
      state.cornersPerm[i] = oldCornersPerm[permuted];
      state.cornersOri[i] = ((oldCornersOri[permuted] + cornerOriDelta[i]) % 3);
    }

    for (int i = 0; i < 12; i++) {
      final permuted = edgePerm[i];
      state.edgesPerm[i] = oldEdgesPerm[permuted];
      state.edgesOri[i] = ((oldEdgesOri[permuted] + edgeOriDelta[i]) % 2);
    }
  }

  @override
  String toString() {
    String move = CubeFace.names[face];
    if (rotation == 2) {
      move += '2';
    } else if (rotation == 3) {
      move += "'";
    }
    return move;
  }
}
