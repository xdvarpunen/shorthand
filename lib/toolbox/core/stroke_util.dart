import 'package:shorthand_app/toolbox/model/point.dart';

enum StrokeOrientation {
  horizontal,
  vertical,
  undefined,
}

class StrokeInspector {
  static double width(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) return 0;

    final minX =
        stroke.map((p) => p.x).reduce((v, e) => v < e ? v : e);
    final maxX =
        stroke.map((p) => p.x).reduce((v, e) => v > e ? v : e);

    return maxX - minX;
  }

  static double height(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) return 0;

    final minY =
        stroke.map((p) => p.y).reduce((v, e) => v < e ? v : e);
    final maxY =
        stroke.map((p) => p.y).reduce((v, e) => v > e ? v : e);

    return maxY - minY;
  }

  static StrokeOrientation getOrientation(List<Point>? stroke) {
    if (stroke == null || stroke.length < 2) {
      return StrokeOrientation.undefined;
    }

    final w = width(stroke);
    final h = height(stroke);

    if (w == h) return StrokeOrientation.undefined;

    return h > w
        ? StrokeOrientation.vertical
        : StrokeOrientation.horizontal;
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
