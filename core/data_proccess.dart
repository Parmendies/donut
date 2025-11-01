import 'point3d.dart';
import 'math_utils.dart';

List<Point3D> roundAll(List<Point3D> points) {
  List<Point3D> newPoints = [];
  for (var element in points) {
    newPoints.add(
      Point3D(
        (element.x * 5).round().toDouble(),
        (element.y * 5),
        (element.z * 5).round().toDouble(),
      ),
    );
  }
  return newPoints;
}

List<Point3D> removeBehind(List<Point3D> points) {
  var minMaxList = calculateMinMax(points);
  List<List<Point3D?>> matris = List.generate(
    300,
    (index) => List.generate(300, (index) => null),
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
      if (matris[newPoint.x.toInt()][newPoint.z.toInt()]!.y < newPoint.y) {
        collided++;
        matris[newPoint.x.toInt()][newPoint.z.toInt()] = newPoint;
      }
    }
  }

  matris.removeWhere((row) => row.isEmpty);
  return matris.expand((e) => e).whereType<Point3D>().toList();
}
