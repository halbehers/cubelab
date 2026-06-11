import 'dart:math';
import 'package:cubelab/cube/cube_move.dart';
import 'package:cubelab/cube/cube_state.dart';
import 'package:cubelab/main.dart';
import 'package:flutter/material.dart';

class Cube3D extends StatefulWidget {
  const Cube3D({
    super.key,
    required this.cubeState,
    this.movesToAnimate,
    this.onAnimationComplete,
  });

  final CubeState cubeState;
  final List<CubeMove>? movesToAnimate;
  final VoidCallback? onAnimationComplete;

  @override
  State<Cube3D> createState() => _Cube3DState();
}

class _Cubie {
  _Cubie(this.x, this.y, this.z, this.faceColors);

  // Logical slot coordinates: each axis in {-1, 0, 1}
  int x, y, z;

  // face index (0-5 = U,R,F,D,L,B) → color (null = interior)
  final Map<int, Color> faceColors;
}

class _Cube3DState extends State<Cube3D> with TickerProviderStateMixin {
  double _yaw = 0.4;
  double _pitch = -0.5;

  late List<_Cubie> _cubies;

  // animation
  late AnimationController _moveController;
  List<CubeMove> _pendingMoves = [];
  CubeMove? _currentMove;
  CubeState _animState = CubeState();

  @override
  void initState() {
    super.initState();
    _animState = widget.cubeState.clone();
    _cubies = [];
    _moveController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 280),
          )
          ..addListener(_onAnimTick)
          ..addStatusListener(_onAnimStatus);
    _scheduleNextMove();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cubies.isEmpty) {
      _cubies = _buildCubies(_animState);
    }
  }

  @override
  void didUpdateWidget(Cube3D old) {
    super.didUpdateWidget(old);
    if (widget.cubeState != old.cubeState &&
        (widget.movesToAnimate == null || widget.movesToAnimate!.isEmpty)) {
      setState(() {
        _animState = widget.cubeState.clone();
        _cubies = _buildCubies(widget.cubeState);
      });
    }
    if (widget.movesToAnimate != old.movesToAnimate) {
      _moveController.stop();
      _pendingMoves = List.of(widget.movesToAnimate ?? []);
      _currentMove = null;
      _animState = widget.cubeState.clone();
      _cubies = _buildCubies(widget.cubeState);
      _scheduleNextMove();
    }
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  void _onAnimTick() => setState(() {});

  void _onAnimStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      // Commit the move to animState and rebuild cubies from the new state
      if (_currentMove != null) {
        _animState.applyMove(_currentMove!);
        _currentMove = null;
      }
      setState(() => _cubies = _buildCubies(_animState));
      _scheduleNextMove();
    }
  }

  void _scheduleNextMove() {
    if (_pendingMoves.isEmpty) {
      widget.onAnimationComplete?.call();
      return;
    }
    _currentMove = _pendingMoves.removeAt(0);
    _moveController.forward(from: 0);
  }

  // Build the 26-cubie list from a CubeState's face colors
  List<_Cubie> _buildCubies(CubeState state) {
    final appTheme = context.appTheme;
    final facelets = state.toFacelets();

    // face index → (normal axis 0/1/2, sign +1/-1)
    // U=0 →  Y+, R=1 → X+, F=2 → Z+, D=3 → Y-, L=4 → X-, B=5 → Z-
    const faceAxis = [1, 0, 2, 1, 0, 2];
    const faceSign = [1, 1, 1, -1, -1, -1];

    // For each face, the (x,y,z) cubie coordinate filtered by this face:
    // cubies on face f have coordinate[faceAxis[f]] == faceSign[f].

    // Facelet index (0-8) → (row, col) in face-local 3×3 grid.
    // We need to define the face-local (col, row) → cubie (a,b) offsets.
    // Face-local axes (right, down) per face, in world (x,y,z):
    //   U  (Y+): right=X+, down=Z+  → (col→x, row→z)  row=0→z=-1
    //   R  (X+): right=Z-, down=Y-  → (col→-z, row→-y)
    //   F  (Z+): right=X+, down=Y-  → (col→x, row→-y)
    //   D  (Y-): right=X+, down=Z-  → (col→x, row→-z)
    //   L  (X-): right=Z+, down=Y-  → (col→z, row→-y)
    //   B  (Z-): right=X-, down=Y-  → (col→-x, row→-y)
    //
    // Each entry: [rightAxis(0=x,1=y,2=z), rightSign, downAxis, downSign]
    const faceLocalAxes = [
      [0, 1, 2, 1], // U
      [2, -1, 1, -1], // R
      [0, 1, 1, -1], // F
      [0, 1, 2, -1], // D
      [2, 1, 1, -1], // L
      [0, -1, 1, -1], // B
    ];

    final cubies = <_Cubie>[];

    // Build all 26 cubie positions and assign an empty color map
    final cubieMap = <(int, int, int), Map<int, Color>>{};
    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        for (int z = -1; z <= 1; z++) {
          if (x == 0 && y == 0 && z == 0) continue; // skip core
          cubieMap[(x, y, z)] = {};
        }
      }
    }

    // Assign sticker colors to the right cubies
    for (int f = 0; f < 6; f++) {
      final axis = faceAxis[f];
      final sign = faceSign[f];
      final local = faceLocalAxes[f];
      final rightAxis = local[0];
      final rightSign = local[1];
      final downAxis = local[2];
      final downSign = local[3];

      for (int idx = 0; idx < 9; idx++) {
        final row = idx ~/ 3; // 0,1,2
        final col = idx % 3; // 0,1,2
        final rOff = col - 1; // -1,0,+1
        final dOff = row - 1;

        final coords = [0, 0, 0];
        coords[axis] = sign;
        coords[rightAxis] = (coords[rightAxis] + rOff * rightSign).clamp(-1, 1);
        coords[downAxis] = (coords[downAxis] + dOff * downSign).clamp(-1, 1);

        final key = (coords[0], coords[1], coords[2]);
        final color = facelets[f][idx].toColor(appTheme);
        cubieMap[key]?[f] = color;
      }
    }

    for (final entry in cubieMap.entries) {
      final k = entry.key;
      cubies.add(_Cubie(k.$1, k.$2, k.$3, entry.value));
    }

    return cubies;
  }

  // Face normal vectors indexed by face (U,R,F,D,L,B)
  static const List<List<double>> _faceNormals = [
    [0, 1, 0], // U
    [1, 0, 0], // R
    [0, 0, 1], // F
    [0, -1, 0], // D
    [-1, 0, 0], // L
    [0, 0, -1], // B
  ];

  // Face local axes: [rightAxis, rightSign, downAxis, downSign]  (0=x,1=y,2=z)
  static const List<List<int>> _faceLocalAxes = [
    [0, 1, 2, 1],
    [2, -1, 1, -1],
    [0, 1, 1, -1],
    [0, 1, 2, -1],
    [2, 1, 1, -1],
    [0, -1, 1, -1],
  ];

  static const List<int> _faceAxis = [1, 0, 2, 1, 0, 2];
  static const List<int> _faceSign = [1, 1, 1, -1, -1, -1];

  // Build a Y-then-X rotation matrix from yaw and pitch angles.
  List<List<double>> _viewMatrix() {
    final cy = cos(_yaw), sy = sin(_yaw);
    final cx = cos(_pitch), sx = sin(_pitch);
    // Ry * Rx
    return [
      [cy, sy * sx, sy * cx],
      [0, cx, -sx],
      [-sy, cy * sx, cy * cx],
    ];
  }

  List<double> _rotateVec(
    List<List<double>> m,
    double vx,
    double vy,
    double vz,
  ) {
    return [
      m[0][0] * vx + m[0][1] * vy + m[0][2] * vz,
      m[1][0] * vx + m[1][1] * vy + m[1][2] * vz,
      m[2][0] * vx + m[2][1] * vy + m[2][2] * vz,
    ];
  }

  // Rotate a vector around an axis by angle (radians)
  List<double> _rotateAround(List<double> v, int axis, double angle) {
    final c = cos(angle), s = sin(angle);
    final x = v[0], y = v[1], z = v[2];
    switch (axis) {
      case 0:
        return [x, c * y - s * z, s * y + c * z]; // X axis
      case 1:
        return [c * x + s * z, y, -s * x + c * z]; // Y axis
      case 2:
        return [c * x - s * y, s * x + c * y, z]; // Z axis
      default:
        return v;
    }
  }

  bool _isCenterSticker(int fi, _Cubie cubie) {
    final axis = _faceAxis[fi];
    final coords = [cubie.x, cubie.y, cubie.z];
    for (int i = 0; i < 3; i++) {
      if (i != axis && coords[i] != 0) return false;
    }
    return true;
  }

  List<_Quad> _collectQuads(List<List<double>> vm, double scale, Color bodyColor) {
    final quads = <_Quad>[];
    final anim = _moveController.value;
    final move = _currentMove;
    const focal = 5.0;

    for (final cubie in _cubies) {
      double moveAngle = 0;
      int moveAxis = 0;
      if (move != null && anim > 0) {
        final f = move.face;
        final axis = _faceAxis[f];
        if ([cubie.x, cubie.y, cubie.z][axis] == _faceSign[f]) {
          final turns = move.rotation == 3 ? -1 : move.rotation;
          moveAngle = -anim * turns * (pi / 2);
          moveAxis = axis;
        }
      }

      for (final faceEntry in cubie.faceColors.entries) {
        final fi = faceEntry.key;
        final color = faceEntry.value;
        final n = _faceNormals[fi];

        // Cull before doing any projection work
        final rn = _rotateVec(vm, n[0], n[1], n[2]);
        if (rn[2] >= 0) continue;

        final local = _faceLocalAxes[fi];
        final rightAxis = local[0];
        final rightSign = local[1];
        final downAxis = local[2];
        final downSign = local[3];

        final cx = cubie.x.toDouble() + 0.5 * n[0];
        final cy = cubie.y.toDouble() + 0.5 * n[1];
        final cz = cubie.z.toDouble() + 0.5 * n[2];

        // Project a sticker of the given half-size; returns (screen points, avgViewZ)
        (List<Offset>, double) project(double half) {
          final pts = <Offset>[];
          double z = 0;
          for (final s in [[-1.0, -1.0], [1.0, -1.0], [1.0, 1.0], [-1.0, 1.0]]) {
            var pt = [cx, cy, cz];
            pt[rightAxis] += s[0] * half * rightSign;
            pt[downAxis] += s[1] * half * downSign;
            if (moveAngle != 0) pt = _rotateAround(pt, moveAxis, moveAngle);
            final r = _rotateVec(vm, pt[0], pt[1], pt[2]);
            final pz = r[2] + focal;
            pts.add(Offset(r[0] * focal / pz * scale, -r[1] * focal / pz * scale));
            z += r[2];
          }
          return (pts, z / 4);
        }

        // Body background: full cubie face in bodyColor, sorted just behind its sticker
        final (bgPts, bgZ) = project(0.5);
        quads.add(_Quad(bgPts, bodyColor, bgZ + 0.001));

        // Color sticker: inset, rounded corners
        final (sPts, sZ) = project(0.44);
        final radius = _isCenterSticker(fi, cubie) ? 16.0 : 4.0;
        quads.add(_Quad(sPts, color, sZ, cornerRadius: radius));
      }
    }

    // Painter's algorithm: furthest first (camera at z=-focal, higher avgZ = farther)
    quads.sort((a, b) => b.avgZ.compareTo(a.avgZ));
    return quads;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _yaw += details.delta.dx * 0.01;
          _pitch = (_pitch + details.delta.dy * 0.01).clamp(-1.4, 1.4);
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = min(constraints.maxWidth, constraints.maxHeight);
          return SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: _CubePainter(
                quads: _collectQuads(_viewMatrix(), size * 0.22, appTheme.textColor),
                borderColor: appTheme.textColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Quad {
  _Quad(this.points, this.color, this.avgZ, {this.cornerRadius = 0.0});
  final List<Offset> points;
  final Color color;
  final double avgZ;
  final double cornerRadius;
}

class _CubePainter extends CustomPainter {
  _CubePainter({required this.quads, required this.borderColor});

  final List<_Quad> quads;
  final Color borderColor;

  Path _buildPath(List<Offset> pts, double radius) {
    if (radius <= 0) {
      return Path()
        ..moveTo(pts[0].dx, pts[0].dy)
        ..lineTo(pts[1].dx, pts[1].dy)
        ..lineTo(pts[2].dx, pts[2].dy)
        ..lineTo(pts[3].dx, pts[3].dy)
        ..close();
    }
    final path = Path();
    for (int i = 0; i < 4; i++) {
      final prev = pts[(i + 3) % 4];
      final curr = pts[i];
      final next = pts[(i + 1) % 4];
      final toPrev = prev - curr;
      final toNext = next - curr;
      final lenPrev = toPrev.distance;
      final lenNext = toNext.distance;
      if (lenPrev < 1e-6 || lenNext < 1e-6) continue;
      final r = min(radius, min(lenPrev, lenNext) * 0.49);
      final p1 = curr + toPrev / lenPrev * r;
      final p2 = curr + toNext / lenNext * r;
      if (i == 0) {
        path.moveTo(p1.dx, p1.dy);
      } else {
        path.lineTo(p1.dx, p1.dy);
      }
      path.quadraticBezierTo(curr.dx, curr.dy, p2.dx, p2.dy);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);

    final fillPaint = Paint()..style = PaintingStyle.fill;

    for (final quad in quads) {
      final path = _buildPath(quad.points, quad.cornerRadius);
      fillPaint.color = quad.color;
      canvas.drawPath(path, fillPaint);
    }
  }

  @override
  bool shouldRepaint(_CubePainter old) =>
      old.quads != quads || old.borderColor != borderColor;
}
