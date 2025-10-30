class Point3D {
  static int _counter = 0;
  final int id;
  final double x, y, z;

  Point3D(this.x, this.y, this.z) : id = _counter++ {}

  @override
  String toString() {
    return "($x, $y, $z) id: $id";
  }
}
