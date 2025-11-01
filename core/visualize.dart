import 'point3d.dart';
import 'math_utils.dart';

List<Point3D> perspective(List<Point3D> points) {
  var minMaxList = calculateMinMax(points);
  List<Point3D> newPoints = [];
  List<double> yValues = normalize(minMaxList, points);
  var a = yValues.reduce((value, element) => value > element ? value : element);
  var b = yValues.reduce((value, element) => value < element ? value : element);

  /*   print(a);
  print(b); */

  for (int i = 0; i < points.length; i++) {
    newPoints.add(
      Point3D(points[i].x / yValues[i], yValues[i], points[i].z / yValues[i]),
    );
  }

  return newPoints;
}
