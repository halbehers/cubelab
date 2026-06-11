enum CubeFaceMove {
  U,
  R,
  F,
  D,
  L,
  B;

  static List<String> get names =>
      CubeFaceMove.values.map((f) => f.name).toList();
  static int indexFromName(String name) =>
      CubeFaceMove.values.firstWhere((f) => f.name == name).index;
}
