import 'dart:math';
import 'data_proccess.dart';
import 'math_utils.dart';
import 'point3d.dart';
import 'visualize.dart';

int R = 50;
int r = 25;
double alpha = 0.02;
double beta = 0.02;

int x = 0;
int y = 0;
int z = 0;

void main(List<String> args) {
  List<Point3D> points = calculatePoints(R, r, alpha, beta);
  var isPerspective = false;
  bool _shouldPrint = false;

  while (true) {
    x++;
    y++;
    z++;
    shouldPrint(points, _shouldPrint, isPerspective, x, y, z);
  }
}

void shouldPrint(
  List<Point3D> points,
  bool shouldPrint,
  bool isPerspective,
  int x,
  int y,
  int z,
) {
  var minMax = calculateMinMax(points);
  int screensize = max(
    (minMax[0] - minMax[3]).abs(),
    (minMax[2] - minMax[5]).abs(),
  ).toInt();

  points = rotateOnX(points, x.toDouble());
  points = rotateOnY(points, y.toDouble());
  points = rotateOnZ(points, z.toDouble());

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After rotation minMax: $minMax');
  }
  if (isPerspective) {
    print(points);
    return;
  }

  points = perspective(points);

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After perspective minMax: $minMax');
  }

  points = minToZero(points, screensize, screensize);

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After minToZero minMax: $minMax');
  }

  points = roundAll(points);

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After roundAll minMax: $minMax');
  }
  points = center(points, screensize, screensize);

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After centred minMax: $minMax');
  }

  points = removeBehind(points, screensize, shouldPrint);

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After removeBehind minMax: $minMax');
  } else {
    display(points, screensize);
  }
}
