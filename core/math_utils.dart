import 'dart:math';
import 'dart:math' as math;
import 'point3d.dart';

List<Point3D> calculatePoints(int R, int r, double alpha, double beta) {
  List<Point3D> points = [];
  double tempA = 0;
  while (tempA < 2 * pi) {
    double tempB = 0;
    while (tempB < 2 * pi) {
      double x = ((R + (r * cos(tempA))) * cos(tempB));
      double y = (((R + (r * cos(tempA))) * sin(tempB)));
      double z = (r * sin(tempA)) + R + r + 1;
      points.add(new Point3D(x, z, y));
      tempB += beta;
    }
    tempA += alpha;
  }
  return points;
}

List<double> calculateMinMax(List<Point3D> points) {
  double maxX = -1000000;
  double maxY = -1000000;
  double maxZ = -1000000;
  double minX = 1000000;
  double minY = 1000000;
  double minZ = 1000000;

  for (var p in points) {
    if (p.x > maxX) maxX = p.x;
    if (p.y > maxY) maxY = p.y;
    if (p.z > maxZ) maxZ = p.z;
    if (p.x < minX) minX = p.x;
    if (p.y < minY) minY = p.y;
    if (p.z < minZ) minZ = p.z;
  }
  // print("x uzunluk: ${maxX - minX}, z uzunluk: ${maxZ - minZ}");
  //        0       1     2     3     4     5
  return [maxX, maxY, maxZ, minX, minY, minZ];
}

List<double> normalizeYvalues(List<double> minMaxList, List<Point3D> points) {
  List<double> yValues = [];
  double maxY = minMaxList[1];
  double minY = minMaxList[4];

  for (var point in points) {
    yValues.add(((point.y - minY) / (maxY - minY)) + 1);
  }

  return yValues;
}

rotateOnY(List<Point3D> points, double angle) {
  List<Point3D> rotatedPoints = [];
  angle = deg2rad(angle);
  double cosA = cos(angle);
  double sinA = sin(angle);

  for (var point in points) {
    double x = point.x * cosA - point.y * sinA;
    double y = point.x * sinA + point.y * cosA;

    rotatedPoints.add(Point3D(x, y, point.z));
  }

  return rotatedPoints;
}

rotateOnX(List<Point3D> points, double angle) {
  List<Point3D> rotatedPoints = [];
  angle = deg2rad(angle);
  double cosA = cos(angle);
  double sinA = sin(angle);

  for (var point in points) {
    double y = point.y * cosA - point.z * sinA;
    double z = point.y * sinA + point.z * cosA;

    rotatedPoints.add(Point3D(point.x, y, z));
  }

  return rotatedPoints;
}

rotateOnZ(List<Point3D> points, double angle) {
  List<Point3D> rotatedPoints = [];
  angle = deg2rad(angle);
  double cosA = cos(angle);
  double sinA = sin(angle);

  for (var point in points) {
    double x = point.x * cosA - point.y * sinA;
    double y = point.x * sinA + point.y * cosA;

    rotatedPoints.add(Point3D(x, y, point.z));
  }

  return rotatedPoints;
}

double deg2rad(double deg) => deg * math.pi / 180.0;
