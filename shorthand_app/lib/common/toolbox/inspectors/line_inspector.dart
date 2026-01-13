import 'package:shorthand_app/engine/point.dart';

enum LineOrientation { horizontal, vertical, undefined }

class LineInspector {
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

  static double width(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) return 0;

    final minX = stroke.map((p) => p.x).reduce((v, e) => v < e ? v : e);
    final maxX = stroke.map((p) => p.x).reduce((v, e) => v > e ? v : e);

    return maxX - minX;
  }

  static double height(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) return 0;

    final minY = stroke.map((p) => p.y).reduce((v, e) => v < e ? v : e);
    final maxY = stroke.map((p) => p.y).reduce((v, e) => v > e ? v : e);

    return maxY - minY;
  }

  static LineOrientation getOrientation(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) {
      return LineOrientation.undefined;
    }

    final w = width(stroke);
    final h = height(stroke);

    if (w == h) return LineOrientation.undefined;

    return h > w ? LineOrientation.vertical : LineOrientation.horizontal;
  }

  static bool isDirectionUp(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) return false;

    final start = stroke.first;
    final end = stroke.last;

    // Smaller Y means "up"
    return end.y < start.y;
  }

  static bool isDirectionDown(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) return false;

    final start = stroke.first;
    final end = stroke.last;

    // Larger Y means "down"
    return end.y > start.y;
  }

  static bool isDirectionLeft(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) return false;

    final start = stroke.first;
    final end = stroke.last;

    // Smaller X means "left"
    return end.x < start.x;
  }

  static bool isDirectionRight(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) return false;

    final start = stroke.first;
    final end = stroke.last;

    // Larger X means "right"
    return end.x > start.x;
  }
}

// TODO isUp, isDown, isLeft, isRight, isUpAndRight isUpAndLeft...
