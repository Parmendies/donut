class Point3D {
  static int _counter = 0;
  final int id;
  final double x, y, z;

  Point3D(this.x, this.y, this.z) : id = _counter++ {}

  @override
  String toString() {
    return "($x, $y, $z)";
  }

  static bool isXYequal(Point3D a, Point3D b) {
    return a.x == b.x && a.z == b.z;
  }
}
