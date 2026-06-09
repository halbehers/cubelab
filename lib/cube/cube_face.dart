enum CubeFace {
  U,
  R,
  F,
  D,
  L,
  B;

  static List<String> get names => CubeFace.values.map((f) => f.name).toList();
  static int indexFromName(String name) =>
      CubeFace.values.firstWhere((f) => f.name == name).index;
}