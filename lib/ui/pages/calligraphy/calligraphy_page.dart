import 'dart:math';

import 'package:shorthand_app/ui/pages/calligraphy/angle.dart';
import 'package:shorthand_app/ui/pages/calligraphy/vec2.dart';

class StrokeSegment {
  Vec2 start;
  Vec2 end;
  double nibAngleDeg; // degrees, relative to canvas
  double nibWidth;

  StrokeSegment(this.start, this.end, this.nibAngleDeg, this.nibWidth);

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

  // void debug() {
  //   List<Vec2> corners = getCorners();
  //   for (var i = 0; i < corners.length; i++) {
  //     print('Corner $i: (${corners[i].x}, ${corners[i].y})');
  //   }
  // }
}

// need factory from point to StrokeSegment
//
// Vec2 start = Vec2(0, 0);
// Vec2 end = Vec2(50, 30);
// double nibAngle = pi / 6; // 30 degrees
// double nibWidth = 10;
//
// StrokeSegment segment = StrokeSegment(start, end, nibAngle, nibWidth);
