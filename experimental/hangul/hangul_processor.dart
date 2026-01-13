import 'package:shorthand_app/ui/widgets/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/processors/pigpen_cipher_processor.dart';

class HangulProcessor extends CanvasProcessor {
  // Vowels
  bool isI(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    bool isVerticalLine = LineUtil().checkVerticalLine(line);

    return isVerticalLine;
  }

  bool isEu(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    bool isHorizontalLine = LineUtil().checkHorizontalLine(line);

    return isHorizontalLine;
  }

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

  bool isNiEun(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEndTop = Point(box.center.x, box.minY);
    final rayEndRight = Point(box.maxX, box.center.y);
    final rayEndBottom = Point(box.center.x, box.maxY);
    final rayEndLeft = Point(box.minX, box.center.y);

    if (polylineIntersectsSegment(points, rayStart, rayEndTop)) {
      return false;
    }
    if (polylineIntersectsSegment(points, rayStart, rayEndRight)) {
      return false;
    }

    if (!polylineIntersectsSegment(points, rayStart, rayEndBottom)) {
      return false;
    }
    if (!polylineIntersectsSegment(points, rayStart, rayEndLeft)) {
      return false;
    }

    return true;
  }

  bool isKiYeok(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEndTop = Point(box.center.x, box.minY);
    final rayEndBottom = Point(box.center.x, box.maxY);
    final rayEndLeft = Point(box.minX, box.center.y);
    final rayEndRight = Point(box.maxX, box.center.y);
    if (!polylineIntersectsSegment(points, rayStart, rayEndTop)) {
      return false;
    }
    if (!polylineIntersectsSegment(points, rayStart, rayEndRight)) {
      return false;
    }
    if (polylineIntersectsSegment(points, rayStart, rayEndBottom)) {
      return false;
    }
    if (polylineIntersectsSegment(points, rayStart, rayEndLeft)) {
      return false;
    }

    return true;
  }

  bool isIEung(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEndTop = Point(box.center.x, box.minY);
    final rayEndBottom = Point(box.center.x, box.maxY);
    final rayEndLeft = Point(box.minX, box.center.y);
    final rayEndRight = Point(box.maxX, box.center.y);
    if (!polylineIntersectsSegment(points, rayStart, rayEndTop)) {
      return false;
    }
    if (!polylineIntersectsSegment(points, rayStart, rayEndRight)) {
      return false;
    }
    if (polylineIntersectsSegment(points, rayStart, rayEndBottom)) {
      return false;
    }
    if (polylineIntersectsSegment(points, rayStart, rayEndLeft)) {
      return false;
    }

    return true;
  }

  String process(List<List<Point>> lines) {
    if (isNiEun(lines)) {
      return "ni-eun";
    } else if (isKiYeok(lines)) {
      return "ki-yeok";
    } else if (isI(lines)) {
      return "i";
    } else if (isEu(lines)) {
      return "eu";
    }
    return "";
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
          (line) => reducePoints(line.points, 3),
        ) // 3, increase... or just use end points only
        .toList();

    final entry = process(lines);
    return 'Char: $entry';
  }
}
