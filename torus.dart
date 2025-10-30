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
      double x = ((R + (r * cos(tempA))) * cos(tempB));
      double y = (((R + (r * cos(tempA))) * sin(tempB)));
      double z = (r * sin(tempA));

      points.add(new Point3D(x, z, y));
      tempB += beta;
    }
    tempA += alpha;
  }
  printPoints(points);
}

normalize(double min, double max, List<Point3D> list) {
  List<double> zvalues = [];
  for (var point in list) {
    zvalues.add(((point.z - min) / (max - min)) + 1);
  }
  return zvalues;
}

perspective(List<Point3D> points) {
  var minnmax = calculateMinMax(points);
  List<Point3D> newpoints = [];
  double maxY = minnmax[2];
  double minY = minnmax[3];
  List<double> yvalues = normalize(minY, maxY, points);
  for (int i = 0; i < points.length; i++) {
    newpoints.add(
      Point3D(points[i].x / yvalues[i], points[i].y, points[i].z / yvalues[i]),
    );
  }
  return newpoints;
}

void printPoints(List<Point3D> points) {
  for (var p in points) {
    print('${p.toString()}');
  }
}

List<double> calculateMinMax(List<Point3D> points) {
  double maxX = -1000000;
  double maxY = -1000000;
  double maxZ = -1000000;
  double minX = 1000000;
  double minY = 1000000;
  double minZ = 1000000;
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
  return [maxX, minX, maxY, minY, maxZ, minZ];
}
