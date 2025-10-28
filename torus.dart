import 'dart:math';
import 'point.dart';

void main(List<String> args) {
  int R = 10;
  int r = 5;

  double alpha = 0.1;
  double beta = 0.1;

  List<Point3D> points = [];

  double tempA = 0;
  while (tempA < 2 * pi) {
    double tempB = 0;
    while (tempB < 2 * pi) {
      points.add(
        Point3D(
          ((R + (r * cos(tempA))) * cos(tempB)).round(),
          (((R + (r * cos(tempA))) * sin(tempB)).round()) + R + r + 1,
          (r * sin(tempA)).round(),
        ),
      );
      tempB += beta;
    }
    tempA += alpha;
  }
  for (var p in points) {
    print('${p.toString()}');
  }
  int maxX = -1000000;
  int maxY = -1000000;
  int maxZ = -1000000;
  int minX = 1000000;
  int minY = 1000000;
  int minZ = 1000000;
  for (var p in points) {
    if (p.x > maxX) {
      maxX = p.x;
    }
    if (p.y > maxY) {
      maxY = p.y;
    }
    if (p.z > maxZ) {
      maxZ = p.z;
    }
    if (p.x < minX) {
      minX = p.x;
    }
    if (p.y < minY) {
      minY = p.y;
    }
    if (p.z < minZ) {
      minZ = p.z;
    }
  }

  print(maxX);
  print(minX);
  print('***************');
  print(maxY);
  print(minY);
  print('***************');
  print(maxZ);
  print(minZ);
}
