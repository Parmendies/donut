import 'point3d.dart';

List<Point3D> roundAll(List<Point3D> points) {
  List<Point3D> newPoints = [];

  for (var element in points) {
    newPoints.add(
      Point3D(
        (element.x).round().toDouble(),
        (element.y),
        (element.z).round().toDouble(),
      ),
    );
  }
  return newPoints;
}

List<Point3D> removeBehind(
  List<Point3D> points,
  int screenSize, [
  bool shouldPrint = false,
]) {
  List<List<Point3D?>> matris = List.generate(
    screenSize.toInt() + 2,
    (index) => List.generate(screenSize.toInt() + 2, (index) => null),
  );
  int empty = 0;
  int conflict = 0;
  int passed = 0;
  int replaced = 0;

  for (var i = 0; i < points.length; i++) {
    var indexPoint = Point3D(points[i].x, points[i].y, points[i].z);

    if (matris[indexPoint.x.toInt()][indexPoint.z.toInt()] == null) {
      empty++;
      matris[indexPoint.x.toInt()][indexPoint.z.toInt()] = indexPoint;
    } else {
      conflict++;

      if (Point3D.isXYequal(
        matris[indexPoint.x.toInt()][indexPoint.z.toInt()]!,
        indexPoint,
      )) {
        if (matris[indexPoint.x.toInt()][indexPoint.z.toInt()]!.y >
            indexPoint.y) {
          replaced++;
          matris[indexPoint.x.toInt()][indexPoint.z.toInt()] = indexPoint;
        } else {
          passed++;
        }
      }
    }
  }

  matris.removeWhere((row) => row.isEmpty);
  for (var element in matris) {
    element.removeWhere((element) => element == null);
  }

  if (shouldPrint) {
    print(
      "empty: $empty, conflict: $conflict, replaced: $replaced, passed: $passed",
    );
  }

  return matris.expand((e) => e).whereType<Point3D>().toList();
}
