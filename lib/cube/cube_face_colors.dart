import 'package:cubelab/cube/cube_color.dart';
import 'package:cubelab/cube/cube_face.dart';

class CubeFaceColors {
  CubeFaceColors(this.face, this.colors);

  final CubeFace face;
  List<CubeColor> colors = List.filled(9, CubeColor.white);
}
