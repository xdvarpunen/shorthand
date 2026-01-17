import 'package:shorthand_app/common/model/point.dart';

class LineUtil {
  // Check if the line is vertical
  bool checkVerticalLine(List<Point> line) {
    if (line.isEmpty) {
      throw ArgumentError("Line should not be null or empty");
    }
    if (line.length < 2) {
      throw ArgumentError("Line should have at least two points");
    }
    final startPoint = line[0];
    final endPoint = line[line.length - 1];
    final width = (endPoint.x - startPoint.x).abs();
    final height = (endPoint.y - startPoint.y).abs();
    return width < height;
  }

  // Check if the line is horizontal
  bool checkHorizontalLine(List<Point> line) {
    if (line.isEmpty) {
      throw ArgumentError("Line should not be null or empty");
    }
    if (line.length < 2) {
      throw ArgumentError("Line should have at least two points");
    }
    final startPoint = line[0];
    final endPoint = line[line.length - 1];
    final width = (endPoint.x - startPoint.x).abs();
    final height = (endPoint.y - startPoint.y).abs();
    return width > height;
  }

  // Check if the line is descending (y decreases as x increases)
  bool isDescending(List<Point> line) {
    return line[0].y < line[line.length - 1].y;
  }

  // Check if the line is ascending (y increases as x increases)
  bool isAscending(List<Point> line) {
    return line[0].y > line[line.length - 1].y;
  }
}
