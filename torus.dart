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
  printPoints(perspective(points));
}

normalize(double min, double max, List<Point3D> list) {
  List<double> yvalues = [];
  for (var point in list) {
    yvalues.add(((point.y - min) / (max - min)) + 1);
  }
  var minValue = yvalues.reduce(
    (value, element) => value < element ? value : element,
  );
  var maxValue = yvalues.reduce(
    (value, element) => value > element ? value : element,
  );
  print("$minValue, $maxValue");

  return yvalues;
}

perspective(List<Point3D> points) {
  var minnmax = calculateMinMax(points);
  List<Point3D> newpoints = [];
  double maxY = minnmax[2];
  double minY = minnmax[3];
  List<double> yvalues = normalize(minY, maxY, points);

  for (int i = 0; i < points.length; i++) {
    newpoints.add(
      Point3D(points[i].x / yvalues[i], yvalues[i], points[i].z / yvalues[i]),
    );
  }

  print(points.length);
  return newpoints;
}

void printPoints(List<Point3D> points) {
  for (var p in points) {
    print('${p.toString()}');
  }
}

printPointFirstTen(points) {
  for (int i = 0; i < 10; i++) {
    print('${points[i].toString()}');
  }
}

List<double> calculateMinMax(List<Point3D> points) {
  double maxX = -1000000;
  double maxY = -1000000;
  double maxZ = -1000000;
  double minX = 1000000;
  double minY = 1000000;
  double minZ = 1000000;
  points.reduce((value, element) => value.x < element.x ? value : element);
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

  var a = [maxX, minX, maxY, minY, maxZ, minZ];
  //print(a);
  return a;
}
