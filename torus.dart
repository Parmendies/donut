import 'dart:math';
import 'point3d.dart';

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
  var per = perspective(points);
  var rounded = roundAll(per);
  var behindRemoved = removeBehind(rounded);
}

removeBehind(List<Point3D> points) {
  var minMaxList = calculateMinMax(points);
  List<List<Point3D?>> list = List.generate(
    //TODO
    300,
    (index) => List.generate(300, (index) => null),
  );

  for (var i = 0; i < points.length; i++) {
    var newPoint = Point3D(
      points[i].x + minMaxList[0],
      points[i].y,
      points[i].z + minMaxList[4],
    );
    if (list[newPoint.x.toInt()][newPoint.z.toInt()] == null) {
      list[newPoint.x.toInt()][newPoint.z.toInt()] = newPoint;
    } else {
      if (list[newPoint.x.toInt()][newPoint.z.toInt()]!.y < newPoint.y) {
        list[newPoint.x.toInt()][newPoint.z.toInt()] = newPoint;
      }
    }
  }
  for (var element in list) {
    element.removeWhere((element) => element == null);
  }
  list.removeWhere((element) => element.isEmpty);
  print(list);
  return list;
}

roundAll(List<Point3D> points) {
  List<Point3D> newpoints = [];
  for (var element in points) {
    newpoints.add(
      Point3D(
        (element.x * 5).round().toDouble(),
        (element.y * 5).round().toDouble(),
        (element.z * 5).round().toDouble(),
      ),
    );
  }
  return newpoints;
}

normalize(minMaxList, List<Point3D> list) {
  List<double> yvalues = [];
  var minY = minMaxList[3];
  var maxY = minMaxList[2];
  for (var point in list) {
    yvalues.add(((point.y - minY) / (maxY - minY)) + 1);
  }

  return yvalues;
}

perspective(List<Point3D> points) {
  var minnmax = calculateMinMax(points);
  List<Point3D> newpoints = [];
  List<double> yvalues = normalize(minnmax, points);

  for (int i = 0; i < points.length; i++) {
    newpoints.add(
      Point3D(points[i].x / yvalues[i], yvalues[i], points[i].z / yvalues[i]),
    );
  }

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
