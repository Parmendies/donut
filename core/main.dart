import 'data_proccess.dart';
import 'math_utils.dart';
import 'point3d.dart';
import 'visualize.dart';

int R = 10;
int r = 5;
double alpha = 0.05;
double beta = 0.05;
int screenWidth = 100;
int screenHeight = 100;

void main(List<String> args) {
  List<Point3D> points = calculatePoints(R, r, alpha, beta);
  var isPerspective = true;
  bool _shouldPrint = false;

  shouldPrint(points, _shouldPrint, isPerspective);
}

void shouldPrint(List<Point3D> points, bool shouldPrint, bool isPerspective) {
  var minMax = calculateMinMax(points);
  if (shouldPrint) {
    print('Original minMax: $minMax');
  }
  points = rotateOnY(points, 45);

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

  points = minToZero(points, screenWidth, screenHeight);

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After minToZero minMax: $minMax');
  }

  points = center(points, screenWidth, screenHeight);

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After centred minMax: $minMax');
  }

  points = roundAll(points);

  if (shouldPrint) {
    minMax = calculateMinMax(points);
    print('After roundAll minMax: $minMax');
  }

  points = removeBehind(points, shouldPrint);

  if (shouldPrint) {
    minMax = calculateMinMax(points);

    print('After removeBehind minMax: $minMax');
  } else {
    print(points);
  }
}
