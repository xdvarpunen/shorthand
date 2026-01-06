import 'package:shorthand_app/engine/point.dart';
import 'dart:math';

enum LineDirection { none, left, right }

class AngleSegment {
  /// Index of point B in the original polyline
  final int index;

  /// Signed angle in radians (left +, right -)
  final double angle;

  final LineDirection direction;

  AngleSegment({
    required this.index,
    required this.angle,
    required this.direction,
  });
}

extension AngleSegmentX on AngleSegment {
  double get absAngle => angle.abs();
  bool get isLeft => direction == LineDirection.left;
  bool get isRight => direction == LineDirection.right;
  bool get isStraight => direction == LineDirection.none;
}

class LineAngle {
  final List<Point> points;
  final List<AngleSegment> segments;

  LineAngle({required this.points, required this.segments});

  /// Build from a polyline
  factory LineAngle.fromPoints(List<Point> points) {
    final segments = <AngleSegment>[];

    if (points.length < 3) {
      return LineAngle(points: points, segments: segments);
    }

    for (var i = 1; i < points.length - 1; i++) {
      final a = points[i - 1];
      final b = points[i];
      final c = points[i + 1];

      final angle = _signedAngle(a, b, c);

      final direction = angle == 0.0
          ? LineDirection.none
          : angle > 0
          ? LineDirection.left
          : LineDirection.right;

      segments.add(AngleSegment(index: i, angle: angle, direction: direction));
    }

    return LineAngle(points: points, segments: segments);
  }

  double get totalAngleChange => segments.fold(0.0, (s, seg) => s + seg.angle);

  double totalFor(LineDirection dir) => segments
      .where((s) => s.direction == dir)
      .fold(0.0, (sum, s) => sum + s.angle.abs());
}

/// Signed angle at B between BA and BC
double _signedAngle(Point a, Point b, Point c) {
  final bax = a.x - b.x;
  final bay = a.y - b.y;
  final bcx = c.x - b.x;
  final bcy = c.y - b.y;

  final dot = bax * bcx + bay * bcy;
  final cross = bax * bcy - bay * bcx;

  return atan2(cross, dot);
}
