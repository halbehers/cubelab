import 'dart:typed_data';
import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/cube/cube_move.dart';
import 'package:cubelab/cube/cube_phase.dart';

class CubeState {
  CubeState();
  CubeState._();

  static const List<List<int>> _cornerFaceletFaces = [
    [0, 1, 2],
    [0, 2, 4],
    [0, 4, 5],
    [0, 5, 1],
    [3, 2, 1],
    [3, 4, 2],
    [3, 5, 4],
    [3, 1, 5],
  ];

  static const List<List<int>> _cornerFaceletIndices = [
    [8, 0, 2],
    [6, 0, 2],
    [0, 0, 2],
    [2, 0, 2],
    [2, 8, 6],
    [0, 8, 6],
    [6, 8, 6],
    [8, 8, 6],
  ];

  static const List<List<int>> _edgeFaceletFaces = [
    [0, 1],
    [0, 2],
    [0, 4],
    [0, 5],
    [3, 1],
    [3, 2],
    [3, 4],
    [3, 5],
    [2, 1],
    [2, 4],
    [5, 4],
    [5, 1],
  ];

  static const List<List<int>> _edgeFaceletIndices = [
    [5, 1],
    [7, 1],
    [3, 1],
    [1, 1],
    [5, 7],
    [1, 7],
    [3, 7],
    [7, 7],
    [5, 3],
    [3, 5],
    [3, 3],
    [5, 5],
  ];

  factory CubeState.fromFacelets(List<List<CubeColor>> faces) {
    if (faces.length != 6) {
      throw ArgumentError('Expected 6 faces, got ${faces.length}');
    }

    final state = CubeState._();
    final centerColors = List<CubeColor>.filled(6, CubeColor.white);
    for (int i = 0; i < 6; i++) {
      centerColors[i] = faces[i][4];
    }

    for (int i = 0; i < 8; i++) {
      final slotColors = List.generate(
        3,
        (j) => faces[_cornerFaceletFaces[i][j]][_cornerFaceletIndices[i][j]],
      );
      final cornerId = _findCornerId(slotColors, centerColors);
      state.cornersPerm[i] = cornerId;
      state.cornersOri[i] = _cornerOrientation(
        cornerId,
        slotColors,
        centerColors,
      );
    }

    for (int i = 0; i < 12; i++) {
      final slotColors = List.generate(
        2,
        (j) => faces[_edgeFaceletFaces[i][j]][_edgeFaceletIndices[i][j]],
      );
      final edgeId = _findEdgeId(slotColors, centerColors);
      state.edgesPerm[i] = edgeId;
      state.edgesOri[i] = _edgeOrientation(edgeId, slotColors, centerColors);
    }

    return state;
  }

  static int _findCornerId(
    List<CubeColor> slotColors,
    List<CubeColor> centerColors,
  ) {
    final slotSet = slotColors.toSet();
    for (int id = 0; id < _cornerFaceletFaces.length; id++) {
      final solvedSet = _cornerFaceletFaces[id]
          .map((face) => centerColors[face])
          .toSet();
      if (slotSet.length == solvedSet.length &&
          solvedSet.containsAll(slotSet)) {
        return id;
      }
    }
    throw FormatException('Invalid corner colors: $slotColors');
  }

  static int _findEdgeId(
    List<CubeColor> slotColors,
    List<CubeColor> centerColors,
  ) {
    final slotSet = slotColors.toSet();
    for (int id = 0; id < _edgeFaceletFaces.length; id++) {
      final solvedSet = _edgeFaceletFaces[id]
          .map((face) => centerColors[face])
          .toSet();
      if (slotSet.length == solvedSet.length &&
          solvedSet.containsAll(slotSet)) {
        return id;
      }
    }
    throw FormatException('Invalid edge colors: $slotColors');
  }

  static int _cornerOrientation(
    int cornerId,
    List<CubeColor> slotColors,
    List<CubeColor> centerColors,
  ) {
    final udColor = centerColors[_cornerFaceletFaces[cornerId][0]];
    final orientation = slotColors.indexOf(udColor);
    if (orientation < 0) {
      throw FormatException(
        'Unable to compute corner orientation for $slotColors',
      );
    }
    return orientation;
  }

  static int _edgeOrientation(
    int edgeId,
    List<CubeColor> slotColors,
    List<CubeColor> centerColors,
  ) {
    final primaryColor = centerColors[_edgeFaceletFaces[edgeId][0]];
    return slotColors[0] == primaryColor ? 0 : 1;
  }

  final Uint8List cornersPerm = Uint8List(8);
  final Uint8List cornersOri = Uint8List(8);
  final Uint8List edgesPerm = Uint8List(12);
  final Uint8List edgesOri = Uint8List(12);

  CubeState clone() {
    CubeState clone = CubeState();
    clone.cornersPerm.setAll(0, cornersPerm);
    clone.cornersOri.setAll(0, cornersOri);
    clone.edgesPerm.setAll(0, edgesPerm);
    clone.edgesOri.setAll(0, edgesOri);
    return clone;
  }

  List<List<CubeColor>> toFacelets() {
    final facelets = List.generate(6, (_) => List.filled(9, CubeColor.white));

    for (int f = 0; f < 6; f++) {
      facelets[f][4] = CubeColor.values[f];
    }

    for (int i = 0; i < 8; i++) {
      final cornerId = cornersPerm[i];
      final ori = cornersOri[i];
      for (int k = 0; k < 3; k++) {
        final face = _cornerFaceletFaces[i][k];
        final idx = _cornerFaceletIndices[i][k];
        facelets[face][idx] =
            CubeColor.values[_cornerFaceletFaces[cornerId][(k - ori + 3) % 3]];
      }
    }

    for (int i = 0; i < 12; i++) {
      final edgeId = edgesPerm[i];
      final ori = edgesOri[i];
      for (int k = 0; k < 2; k++) {
        final face = _edgeFaceletFaces[i][k];
        final idx = _edgeFaceletIndices[i][k];
        facelets[face][idx] =
            CubeColor.values[_edgeFaceletFaces[edgeId][(k + ori) % 2]];
      }
    }

    return facelets;
  }

  bool isSolved() {
    for (int i = 0; i < 8; i++) {
      if (cornersPerm[i] != i || cornersOri[i] != 0) return false;
    }
    for (int i = 0; i < 12; i++) {
      if (edgesPerm[i] != i || edgesOri[i] != 0) return false;
    }
    return true;
  }

  void applyMove(CubeMove move) {
    move.apply(this);
  }

  void applyMoves(Iterable<CubeMove> move) {
    for (final m in move) {
      applyMove(m);
    }
  }

  CubePhase getCurrentPhase() {
    if (isSolved()) return CubePhase.solved;

    // Check for cross
    for (int i = 0; i < 4; i++) {
      if (edgesPerm[i] != i || edgesOri[i] != 0) {
        return CubePhase.initialScramble;
      }
    }

    // Check for F2L
    for (int i = 0; i < 4; i++) {
      if (cornersPerm[i] != i || cornersOri[i] != 0) {
        return CubePhase.cross;
      }
    }

    // Check for OLL
    for (int i = 0; i < 8; i++) {
      if (cornersOri[i] != 0) {
        return CubePhase.f2l;
      }
    }
    for (int i = 0; i < 12; i++) {
      if (edgesOri[i] != 0) {
        return CubePhase.f2l;
      }
    }

    // Check for PLL
    for (int i = 0; i < 8; i++) {
      if (cornersPerm[i] != i) {
        return CubePhase.oll;
      }
    }
    for (int i = 0; i < 12; i++) {
      if (edgesPerm[i] != i) {
        return CubePhase.oll;
      }
    }

    return CubePhase.pll;
  }
}
