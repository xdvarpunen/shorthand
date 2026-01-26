import 'package:shorthand_app/toolbox/core/stroke_direction.dart';
import 'package:shorthand_app/toolbox/core/stroke_util.dart';
import 'package:shorthand_app/toolbox/model/point.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/copy/bounding_box.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/copy/segment_intersection.dart';


class PolylineIntersectsSegmentApproach {
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
}
    // final String v = isV(listOfListOfPoints) ? "yes" : "no";