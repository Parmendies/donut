import 'point3d.dart';
import 'math_utils.dart';

List<Point3D> perspective(List<Point3D> points) {
  var minMaxList = calculateMinMax(points);
  List<Point3D> newPoints = [];
  List<double> yValues = normalizeYvalues(minMaxList, points);
  /*   var a = yValues.reduce((value, element) => value > element ? value : element);
  var b = yValues.reduce((value, element) => value < element ? value : element);


  ps: y min 1 max 2 
 */
  for (int i = 0; i < points.length; i++) {
    newPoints.add(
      Point3D(points[i].x / yValues[i], yValues[i], points[i].z / yValues[i]),
    );
  }

  return newPoints;
}

List<Point3D> minToZero(
  List<Point3D> points,
  int screenWidth,
  int screenHeight,
) {
  var minMaxList = calculateMinMax(points);
  var minX = minMaxList[3];
  var minZ = minMaxList[5];

  if (minX < 0) {
    for (var point in points) {
      point.x += -minX;
    }
  } else if (minX > 0) {
    for (var point in points) {
      point.x -= minX;
    }
  }

  if (minZ < 0) {
    for (var point in points) {
      point.z += -minZ;
    }
  } else if (minZ > 0) {
    for (var point in points) {
      point.z -= minZ;
    }
  }
  return points;
}

List<Point3D> center(List<Point3D> points, int screenWidth, int screenHeight) {
  var minMaxList = calculateMinMax(points);
  var minX = minMaxList[3];
  var maxX = minMaxList[0];
  var minZ = minMaxList[5];
  var maxZ = minMaxList[2];
  var donutWidth = maxX - minX;
  var donutHeight = maxZ - minZ;
  if (screenWidth > donutWidth) {
    for (var element in points) {
      element.x += (screenWidth - donutWidth) / 2;
    }
  }
  if (screenHeight > donutHeight) {
    for (var element in points) {
      element.z += (screenHeight - donutHeight) / 2;
    }
  }
  return points;
}

display(List<Point3D> points, int screenSize) {
  var displayList = List.generate(
    screenSize + 10,
    (index) => List.generate(screenSize + 10, (index) => ' '),
  );
  for (var point in points) {
    displayList[point.x.round()][point.z.round()] = setChar(point);
  }
  for (var element in displayList) {
    element.add('\n');
  }
  displayList.removeWhere(
    (element) => element.every((element) {
      return element == ' ';
    }),
  );
  print(displayList);
}

List<String> charList = ["@", "#", "O", "X", "%", "*", "+", "=", "-", ",", "."];
String setChar(Point3D point) {
  int index = ((point.y - 1) * 10).round();

  return charList[index];
}
