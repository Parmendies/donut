import 'data_proccess.dart';
import 'math_utils.dart';
import 'point3d.dart';
import 'visualize.dart';

int R = 10;
int r = 5;
double alpha = 0.1;
double beta = 0.1;

void main(List<String> args) {
  List<Point3D> points = calculatePoints(R, r, alpha, beta);
  points = rotateMatris(points, 45);
  /* 
  var per = perspective(points);
  var b = roundAll(per);

  var clean2 = removeBehind(b); */
  print(points);
}
