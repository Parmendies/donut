import 'dart:math';
import 'point3c.dart';

int R = 10;
int r = 5;
double alpha = 0.1;
double beta = 0.1;
void main(List<String> args) {
  List<Point3D> points = [];

  double tempA = 0;
  while (tempA < 2 * pi) {
    double tempB = 0;
    while (tempB < 2 * pi) {
      int x = ((R + (r * cos(tempA))) * cos(tempB)).round();
      int y = (((R + (r * cos(tempA))) * sin(tempB)).round());
      int z = (r * sin(tempA)).round();
      points.add(new Point3D(x, z, y));
      tempB += beta;
    }
    tempA += alpha;
  }
  printPoints(points);
}

List<Point3D> givePerspective(List<Point3D> points) {
  List<Point3D> newPoints = [];
  for (var p in points) {
    try {
      int z = p.z + R + r + 1;
      z = (z / 10).round();

      int x = p.x ~/ z;
      int y = p.y ~/ z;
      int index = newPoints.indexWhere((p) => p.x == x && p.y == y);
      if (index == -1) {
        newPoints.add(new Point3D(x, y, p.z));
      } else {
        if (newPoints[index].z < p.z) {
          newPoints[index] = new Point3D(x, y, p.z);
        }
      }
    } on UnsupportedError catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }
  return newPoints;
}

void printPoints(List<Point3D> points) {
  for (var p in points) {
    print('${p.toString()}');
  }
}

void calculateMinMax(List<Point3D> points) {
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
