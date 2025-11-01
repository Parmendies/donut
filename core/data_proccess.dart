import 'point3d.dart';
import 'math_utils.dart';

List<Point3D> roundAll(List<Point3D> points) {
  List<Point3D> newPoints = [];
  const double carpan = 1.50;

  for (var element in points) {
    newPoints.add(
      Point3D(
        (element.x * carpan).round().toDouble(),
        (element.y),
        (element.z * carpan).round().toDouble(),
      ),
    );
  }
  return newPoints;
}

List<Point3D> removeBehind(List<Point3D> points) {
  var minMaxList = calculateMinMax(points);

  //TODO dynamic matris
  List<List<Point3D?>> matris = List.generate(
    1000,
    (index) => List.generate(1000, (index) => null),
  );
  int added = 0;
  int collided = 0;

  for (var i = 0; i < points.length; i++) {
    var newPoint = Point3D(
      points[i].x + minMaxList[0],
      points[i].y,
      points[i].z + minMaxList[4],
    );

    if (matris[newPoint.x.toInt()][newPoint.z.toInt()] == null) {
      added++;
      matris[newPoint.x.toInt()][newPoint.z.toInt()] = newPoint;
    } else {
      if (Point3D.isXYequal(
        matris[newPoint.x.toInt()][newPoint.z.toInt()]!,
        newPoint,
      )) {
        if (matris[newPoint.x.toInt()][newPoint.z.toInt()]!.y < newPoint.y) {
          collided++;
          matris[newPoint.x.toInt()][newPoint.z.toInt()] = newPoint;
        }
      }
      matris[newPoint.x.toInt()][newPoint.z.toInt()] = newPoint;
    }
  }

  matris.removeWhere((row) => row.isEmpty);
  for (var element in matris) {
    element.removeWhere((element) => element == null);
  }
  //    print("added $added, collided: $collided");

  return matris.expand((e) => e).whereType<Point3D>().toList();
}
