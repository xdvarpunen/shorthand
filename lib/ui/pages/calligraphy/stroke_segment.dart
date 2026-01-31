import 'dart:math';

import 'package:shorthand_app/ui/pages/calligraphy/angle.dart';
import 'package:shorthand_app/ui/pages/calligraphy/vec2.dart';

class StrokeSegment {
  Vec2 start;
  Vec2 end;
  double nibAngleDeg; // degrees, relative to canvas
  double nibWidth;

  StrokeSegment({
    required this.start,
    required this.end,
    required this.nibAngleDeg,
    required this.nibWidth,
  });

  /// Returns the 4 corners of the nib polygon
  List<Vec2> getCorners() {
    double halfWidth = nibWidth / 2.0;

    // Convert nib angle to radians
    double angleRad = Angle.degToRad(nibAngleDeg);

    // Perpendicular vector based on fixed nib angle
    Vec2 offset = Vec2(
      cos(angleRad + pi / 2) * halfWidth,
      sin(angleRad + pi / 2) * halfWidth,
    );

    // 4 corners
    Vec2 p1 = start + offset;
    Vec2 p2 = start - offset;
    Vec2 p3 = end - offset;
    Vec2 p4 = end + offset;

    return [p1, p2, p3, p4];
  }

  /// Convert this segment into a 4-point polygon
  List<Vec2> toPolygon() {
    final half = nibWidth / 2.0;
    final rad = Angle.degToRad(nibAngleDeg + 90);

    final offset = Vec2(cos(rad) * half, sin(rad) * half);

    return [start + offset, start - offset, end - offset, end + offset];
  }

  // void debug() {
  //   List<Vec2> corners = getCorners();
  //   for (var i = 0; i < corners.length; i++) {
  //     print('Corner $i: (${corners[i].x}, ${corners[i].y})');
  //   }
  // }
}
// import 'dart:math';

// class StrokeSegment {
//   final Vec2 start;
//   final Vec2 end;
//   final double nibAngleDeg;
//   final double nibWidth;

//   StrokeSegment({
//     required this.start,
//     required this.end,
//     required this.nibAngleDeg,
//     required this.nibWidth,
//   });

//   /// Convert this segment into a 4-point polygon
//   List<Vec2> toPolygon() {
//     final half = nibWidth / 2.0;
//     final rad = Angle.degToRad(nibAngleDeg + 90);

//     final offset = Vec2(
//       cos(rad) * half,
//       sin(rad) * half,
//     );

//     return [
//       start + offset,
//       start - offset,
//       end - offset,
//       end + offset,
//     ];
//   }
// }

// need factory from point to StrokeSegment
//
// Vec2 start = Vec2(0, 0);
// Vec2 end = Vec2(50, 30);
// double nibAngle = pi / 6; // 30 degrees
// double nibWidth = 10;
//
// StrokeSegment segment = StrokeSegment(start, end, nibAngle, nibWidth);
