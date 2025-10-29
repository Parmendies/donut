class Point2D {
  static int _counter = 0;
  final int id;
  final int x, y;

  Point2D(this.x, this.y) : id = _counter++ {}

  @override
  String toString() {
    return "($x, $y) id: $id";
  }
}
