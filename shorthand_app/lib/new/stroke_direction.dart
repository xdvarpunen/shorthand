import 'package:shorthand_app/engine/point.dart';

enum StrokeCutDirection {
  none,
  vertical,
  horizontal,
}

class StrokeCut {
  final StrokeCutDirection direction;
  final List<Point> source;
  final List<List<Point>> result;
  final List<StrokeCut> subCuts;

  StrokeCut(
    this.direction,
    this.source,
    this.result,
  ) : subCuts = [];
}

class StrokeCutter {
  // --- CUT BY VERTICAL DIRECTION CHANGE (up ↔ down) ---
  static List<List<Point>> cutByVerticalDirectionChange(
    List<Point> stroke,
  ) {
    final segments = <List<Point>>[];
    if (stroke.length < 2) return segments;

    var current = <Point>[Point(stroke[0].x, stroke[0].y)];
    bool? goingUp;

    for (var i = 1; i < stroke.length; i++) {
      final prev = stroke[i - 1];
      final curr = stroke[i];
      final isUp = curr.y < prev.y;

      if (goingUp != null && isUp != goingUp) {
        segments.add(current);
        current = <Point>[Point(prev.x, prev.y)];
      }

      current.add(Point(curr.x, curr.y));
      goingUp = isUp;
    }

    segments.add(current);
    return segments;
  }

  // --- CUT BY HORIZONTAL DIRECTION CHANGE (left ↔ right) ---
  static List<List<Point>> cutByHorizontalDirectionChange(
    List<Point> stroke,
  ) {
    final segments = <List<Point>>[];
    if (stroke.length < 2) return segments;

    var current = <Point>[Point(stroke[0].x, stroke[0].y)];
    bool? goingRight;

    for (var i = 1; i < stroke.length; i++) {
      final prev = stroke[i - 1];
      final curr = stroke[i];
      final isRight = curr.x > prev.x;

      if (goingRight != null && isRight != goingRight) {
        segments.add(current);
        current = <Point>[Point(prev.x, prev.y)];
      }

      current.add(Point(curr.x, curr.y));
      goingRight = isRight;
    }

    segments.add(current);
    return segments;
  }
}
