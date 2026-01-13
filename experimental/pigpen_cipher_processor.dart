import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/engine/stroke_direction.dart';
import 'package:shorthand_app/engine/stroke_util.dart';

// https://en.wikipedia.org/wiki/Pigpen_cipher

class BoundingBox {
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  BoundingBox._(this.minX, this.maxX, this.minY, this.maxY);

  /// Create a bounding box from a list of points
  factory BoundingBox.fromPoints(List<Point> points) {
    if (points.isEmpty) {
      throw ArgumentError('Points list cannot be empty');
    }

    double minX = points.first.x;
    double maxX = points.first.x;
    double minY = points.first.y;
    double maxY = points.first.y;

    for (final p in points) {
      if (p.x < minX) minX = p.x;
      if (p.x > maxX) maxX = p.x;
      if (p.y < minY) minY = p.y;
      if (p.y > maxY) maxY = p.y;
    }

    return BoundingBox._(minX, maxX, minY, maxY);
  }

  /// Center point of the bounding box
  Point get center => Point((minX + maxX) / 2, (minY + maxY) / 2);

  double get width => maxX - minX;
  double get height => maxY - minY;

  /// Check if a point is inside the bounding box
  bool contains(Point p) {
    return p.x >= minX && p.x <= maxX && p.y >= minY && p.y <= maxY;
  }
}

class SegmentIntersection {
  /// Returns true if segment p1–p2 intersects segment q1–q2
  static bool intersects(Point p1, Point p2, Point q1, Point q2) {
    final o1 = _orientation(p1, p2, q1);
    final o2 = _orientation(p1, p2, q2);
    final o3 = _orientation(q1, q2, p1);
    final o4 = _orientation(q1, q2, p2);

    return o1 * o2 < 0 && o3 * o4 < 0;
  }

  /// Orientation helper (cross product sign)
  static double _orientation(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
  }
}

class Segment {
  final Point a;
  final Point b;

  Segment(this.a, this.b);

  bool intersects(Segment other) {
    return SegmentIntersection.intersects(a, b, other.a, other.b);
  }
}

class PigpenCipherProcessor extends CanvasProcessor {
  /// Returns true if ANY segment of [points] intersects the segment [s1]–[s2]
  bool polylineIntersectsSegment(List<Point> points, Point s1, Point s2) {
    if (points.length < 2) return false;

    for (int i = 0; i < points.length - 1; i++) {
      final a = points[i];
      final b = points[i + 1];

      if (Segment(a, b).intersects(Segment(s1, s2))) {
        return true;
      }
    }

    return false;
  }

  bool isH(List<List<Point>> lines) {
    // get bounding box
    // from center to bottom

    // 1. must have exactly one list of points
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    // center of bounding box
    final box = BoundingBox.fromPoints(points);

    // 3. vertical line from center to bottom of bounding box
    final rayStart = box.center;
    final rayEnd = Point(box.center.x, box.maxY);

    // 4. check intersection with any segment
    if (polylineIntersectsSegment(points, rayStart, rayEnd)) {
      // crosses the center-to-bottom line → not la
      return false;
    }

    return true;
  }

  bool isA(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEnd = Point(box.center.x, box.minY);

    if (polylineIntersectsSegment(points, rayStart, rayEnd)) {
      return false;
    }

    return true;
  }

  bool isD(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEnd = Point(box.minX, box.center.y);

    if (polylineIntersectsSegment(points, rayStart, rayEnd)) {
      return false;
    }

    return true;
  }

  bool isF(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEnd = Point(box.maxX, box.center.y);

    if (polylineIntersectsSegment(points, rayStart, rayEnd)) {
      return false;
    }

    return true;
  }

  bool isQ(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();
    final tailPoints = lines.where((line) => line.length == 1).toList();

    if (mainLines.length != 1 || tailPoints.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;
    final tail = tailPoints.first.first; // the single Point

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // 3. vertical line from center to bottom
    final rayStart = box.center;
    final rayEnd = Point(box.center.x, box.maxY);

    // 4. if any segment crosses center-to-bottom line → not Q
    if (polylineIntersectsSegment(mainPoints, rayStart, rayEnd)) {
      return false;
    }

    // 5. check if tail point is inside bounding box
    if (!box.contains(tail)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }

  bool isX(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();
    final tailPoints = lines.where((line) => line.length == 1).toList();

    if (mainLines.length != 1 || tailPoints.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;
    final tail = tailPoints.first.first; // the single Point

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.x >= box.center.x &&
        mainPoints.last.x >= box.center.x) {
      return false;
    }

    // down right
    // down left
    final segments = StrokeCutter.cutByHorizontalDirectionChange(mainPoints);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
      segments[0],
    );

    final secondSegmentIsDirectionLeft = StrokeInspector.isDirectionLeft(
      segments[1],
    );

    if (!(firstSegmentIsDirectionRight && secondSegmentIsDirectionLeft)) {
      return false;
    }

    // 5. check if tail point is inside bounding box
    if (!box.contains(tail)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }
 
  bool isT(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();

    if (mainLines.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.x >= box.center.x &&
        mainPoints.last.x >= box.center.x) {
      return false;
    }

    // down right
    // down left
    final segments = StrokeCutter.cutByHorizontalDirectionChange(mainPoints);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
      segments[0],
    );

    final secondSegmentIsDirectionLeft = StrokeInspector.isDirectionLeft(
      segments[1],
    );

    if (!(firstSegmentIsDirectionRight && secondSegmentIsDirectionLeft)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }

  bool isY(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();
    final tailPoints = lines.where((line) => line.length == 1).toList();

    if (mainLines.length != 1 || tailPoints.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;
    final tail = tailPoints.first.first; // the single Point

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.x <= box.center.x &&
        mainPoints.last.x <= box.center.x) {
      return false;
    }

    // down right
    // down left
    final segments = StrokeCutter.cutByHorizontalDirectionChange(mainPoints);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionLeft = StrokeInspector.isDirectionLeft(
      segments[0],
    );

    final secondSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
      segments[1],
    );

    if (!(firstSegmentIsDirectionLeft && secondSegmentIsDirectionRight)) {
      return false;
    }

    // 5. check if tail point is inside bounding box
    if (!box.contains(tail)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }

  bool isU(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();

    if (mainLines.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.x <= box.center.x &&
        mainPoints.last.x <= box.center.x) {
      return false;
    }

    // down right
    // down left
    final segments = StrokeCutter.cutByHorizontalDirectionChange(mainPoints);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionLeft = StrokeInspector.isDirectionLeft(
      segments[0],
    );

    final secondSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
      segments[1],
    );

    if (!(firstSegmentIsDirectionLeft && secondSegmentIsDirectionRight)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }

  bool isW(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();
    final tailPoints = lines.where((line) => line.length == 1).toList();

    if (mainLines.length != 1 || tailPoints.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;
    final tail = tailPoints.first.first; // the single Point

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.y >= box.center.y &&
        mainPoints.last.y >= box.center.y) {
      return false;
    }

    // down right
    // down left
    final segments = StrokeCutter.cutByVerticalDirectionChange(mainPoints);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
      segments[0],
    );

    final secondSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
      segments[1],
    );

    if (!(firstSegmentIsDirectionDown && secondSegmentIsDirectionUp)) {
      return false;
    }

    // 5. check if tail point is inside bounding box
    if (!box.contains(tail)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }

  bool isS(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();

    if (mainLines.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.y >= box.center.y &&
        mainPoints.last.y >= box.center.y) {
      return false;
    }

    // down right
    // down left
    final segments = StrokeCutter.cutByVerticalDirectionChange(mainPoints);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
      segments[0],
    );

    final secondSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
      segments[1],
    );

    if (!(firstSegmentIsDirectionDown && secondSegmentIsDirectionUp)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }

  bool isZ(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();
    final tailPoints = lines.where((line) => line.length == 1).toList();

    if (mainLines.length != 1 || tailPoints.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;
    final tail = tailPoints.first.first; // the single Point

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.y <= box.center.y &&
        mainPoints.last.y <= box.center.y) {
      return false;
    }

    // down right
    // down left
    final segments = StrokeCutter.cutByVerticalDirectionChange(mainPoints);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
      segments[0],
    );

    final secondSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
      segments[1],
    );

    if (!(firstSegmentIsDirectionUp && secondSegmentIsDirectionDown)) {
      return false;
    }

    // 5. check if tail point is inside bounding box
    if (!box.contains(tail)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }

  bool isV(List<List<Point>> lines) {
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.length > 1).toList();

    if (mainLines.length != 1) {
      return false; // either no main shape or no tail
    }

    final mainPoints = mainLines.first;

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.y <= box.center.y &&
        mainPoints.last.y <= box.center.y) {
      return false;
    }

    // down right
    // down left
    final segments = StrokeCutter.cutByVerticalDirectionChange(mainPoints);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
      segments[0],
    );

    final secondSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
      segments[1],
    );

    if (!(firstSegmentIsDirectionUp && secondSegmentIsDirectionDown)) {
      return false;
    }

    return true; // all conditions met → looks like a Q
  }


  String process(List<List<Point>> lines) {
    return isV(lines) ? "yes" : "no";
  }

  List<Point> reducePoints(List<Point> points, double minDistance) {
    if (points.isEmpty) return [];

    final reduced = <Point>[points.first];

    for (var i = 1; i < points.length; i++) {
      final last = reduced.last;
      final curr = points[i];

      final dx = (curr.x - last.x).abs();
      final dy = (curr.y - last.y).abs();

      if (dx >= minDistance || dy >= minDistance) {
        reduced.add(curr);
      }
    }

    return reduced;
  }

  @override
  String getOutput(PointsManager pointsManager) {
    final List<List<Point>> lines = pointsManager.lines
        .map(
          (line) => reducePoints(line.points, 10),
        ) // 3, increase... or just use end points only
        .toList();

    final entry = process(lines);

    return 'Char: $entry';
  }
}
