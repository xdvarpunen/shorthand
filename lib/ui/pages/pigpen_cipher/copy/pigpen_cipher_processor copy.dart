import 'package:shorthand_app/toolbox/core/line_intersection_finder.dart';
import 'package:shorthand_app/toolbox/core/stroke_direction.dart';
import 'package:shorthand_app/toolbox/core/stroke_util.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/model/point.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/line_inspector.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/lines/group_intersecting_lines.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/copy/bounding_box.dart';

// https://en.wikipedia.org/wiki/Pigpen_cipher

class PigpenCipherProcessor2 extends TextLinesInterpreter {
  @override
  String process(List<Line> lines) {
    // final List<Line> listOfListOfPoints = lines
    //     .map(
    //       (line) => Line(reducePoints(line.points, 10)),
    //     ) // 3, increase... or just use end points only
    //     .toList();

    final String stuff = PigpenCipherProcessorMain.process(lines);
    // final String v = isV(listOfListOfPoints) ? "yes" : "no";
    // return 'Char: $v';
    return stuff;
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
}

// simplify

// line in rect
// multiline in diamond

class Triangle {
  static bool isW(Line head, Point eye) {
    final mainPoints = head.points;
    final tail = eye; // the single Point

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

  static bool isS(Line line) {
    final mainPoints = line.points;

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

  static bool isZ(Line head, Point eye) {
    final mainPoints = head.points;
    final tail = eye; // the single Point

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

  static bool isV(Line line) {
    final mainPoints = line.points;

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

  // ---

  static bool isT(Line line) {
    final mainPoints = line.points;

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.y <= box.center.y &&
        mainPoints.last.y <= box.center.y) {
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

  static bool isU(Line line) {
    final mainPoints = line.points;

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.y <= box.center.y &&
        mainPoints.last.y <= box.center.y) {
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

  static bool isX(Line head, Point eye) {
    final mainPoints = head.points;
    final tail = eye; // the single Point

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.y <= box.center.y &&
        mainPoints.last.y <= box.center.y) {
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

  static bool isY(Line head, Point eye) {
    final mainPoints = head.points;
    final tail = eye; // the single Point

    // 2. bounding box of main shape
    final box = BoundingBox.fromPoints(mainPoints);

    // center other side start and end points
    if (mainPoints.first.y <= box.center.y &&
        mainPoints.last.y <= box.center.y) {
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

  static MainLineTailPoint? containsTriangleWithDot(List<Line> lines) {
    // contains type of lines
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.points.length > 1).toList();
    final tailPoints = lines.where((line) => line.points.length == 1).toList();

    if (mainLines.length != 1 || tailPoints.length != 1) {
      return null; // either no main shape or no tail
    }
    return MainLineTailPoint(mainLines.first, tailPoints.first.points.first);
  }
}

class MainLineTailPoint {
  late Line mainLine;
  late Point tailPoint;

  MainLineTailPoint(Line main, Point tail) {
    mainLine = main;
    tailPoint = tail;
  }
}

class Rectangle {
  // get intersecting lines
  // get intersecting lines bounding box
  // get bounding boxes that intersect (dots)
  // done

  static List<List<List<Point>>> getIntersectingLines(List<List<Point>> lines) {
    var intersectingLineGrouper = IntersectingLineGrouper();
    var intersectingLines = intersectingLineGrouper.groupIntersectingLines(
      lines,
    );

    return intersectingLines;
  }

  static List<Line> getBoundingBoxIntersectingLines() {
    // Todo
    return [];
  }

  static List<Line> getIntersectingLinesFromBoundingBox() {
    // Todo
    return [];
  }

  static int getHorizontalLinesCount(List<Line> lines) {
    return lines
        .where(
          (line) => LineInspector.checkHorizontalLine(
            line.points,
          ),
        )
        .toList()
        .length;
  }

  static int getVerticalLinesCount(List<Line> lines) {
    return lines
        .where(
          (line) =>
              LineInspector.checkVerticalLine(line.points),
        )
        .toList()
        .length;
  }

  static List<Line> getHorizontalLines(List<Line> lines) {
    return lines
        .where(
          (line) => LineInspector.checkHorizontalLine(
            line.points,
          ),
        )
        .toList();
  }

  static List<Line> getVerticalLines(List<Line> lines) {
    return lines
        .where(
          (line) =>
              LineInspector.checkVerticalLine(line.points),
        )
        .toList();
  }
}

class Dot {
  static List<Line> getDotLines(List<Line> lines) {
    return lines.where((line) => line.points.length == 1).toList();
  }
}

class PigpenCipherProcessorMain {
  static Line? getSingleLineWithMoreThanOnePoints(List<Line> lines) {
    final mainLines = lines.where((line) => line.points.length > 1).toList();

    if (mainLines.length != 1) {
      return null; // either no main shape or no tail
    }
    return mainLines.first;
  }

  static String process(List<Line> lines) {
    // if (lines.length == 1) {
    //   // contains vertical line change
    //   final line = getSingleLineWithMoreThanOnePoints(lines);
    //   if (line != null) {
    //     if (StrokeCutter.cutByVerticalDirectionChange(line.points).length ==
    //         2) {
    //       if (Triangle.isS(line)) {
    //         return "is S";
    //       } else if (Triangle.isV(line)) {
    //         return "is V";
    //       }
    //     } else if (StrokeCutter.cutByHorizontalDirectionChange(
    //           line.points,
    //         ).length ==
    //         2) {
    //       if (Triangle.isT(line)) {
    //         return "is T";
    //       } else if (Triangle.isU(line)) {
    //         return "is U";
    //       }
    //     }
    //   }
    // } else if (lines.length == 2) {
    //   // Cube has never under two lines. check they intersect. Triangle does not intersect. do polyline check.
    //   MainLineTailPoint? mltp = Triangle.containsTriangleWithDot(lines);
    //   if (mltp != null) {
    //     if (StrokeCutter.cutByVerticalDirectionChange(
    //           mltp.mainLine.points,
    //         ).length ==
    //         2) {
    //       if (Triangle.isW(mltp.mainLine, mltp.tailPoint)) {
    //         return "is W";
    //       } else if (Triangle.isZ(mltp.mainLine, mltp.tailPoint)) {
    //         return "is Z";
    //       }
    //     } else if (StrokeCutter.cutByHorizontalDirectionChange(
    //           mltp.mainLine.points,
    //         ).length ==
    //         2) {
    //       if (Triangle.isY(mltp.mainLine, mltp.tailPoint)) {
    //         return "is Y";
    //       } else if (Triangle.isX(mltp.mainLine, mltp.tailPoint)) {
    //         return "is X";
    //       }
    //     }
    //   } else {
    //     // is square
    //     // contains vertical
    //     // contains horizontal
    //     List<Line> hLines = Rectangle.getHorizontalLines(lines);
    //     List<Line> vLines = Rectangle.getVerticalLines(lines);

    //     if (hLines.length == 1 && vLines.length == 1) {
    //       // bounding box center
    //       Line hLine = hLines.first;
    //       Line vLine = vLines.first;

    //       BoundingBox hLineBoundingBox = BoundingBox.fromPoints(hLine.points);
    //       BoundingBox vLineBoundingBox = BoundingBox.fromPoints(vLine.points);

    //       Point? intersectionPoint = LineIntersectionFinder.findIntersection(
    //         hLine.points,
    //         vLine.points,
    //       );

    //       if (intersectionPoint != null) {
    //         // A C G I
    //         Point hCenterPoint = hLineBoundingBox.center;
    //         Point vCenterPoint = vLineBoundingBox.center;

    //         // below vertical center point
    //         // right horizontal center point
    //         // => A
    //         if (vCenterPoint.y > intersectionPoint.y &&
    //             hCenterPoint.x < intersectionPoint.x) {
    //           return "is A";
    //         }

    //         // below vertical center point
    //         // left horizontal center point
    //         // => C
    //         if (vCenterPoint.y > intersectionPoint.y &&
    //             hCenterPoint.x > intersectionPoint.x) {
    //           return "is C";
    //         }

    //         // above vertical center point
    //         // right horizontal center point
    //         // => G
    //         if (vCenterPoint.y < intersectionPoint.y &&
    //             hCenterPoint.x < intersectionPoint.x) {
    //           return "is G";
    //         }

    //         // above vertical center point
    //         // left horizontal center point
    //         // => I
    //         if (vCenterPoint.y < intersectionPoint.y &&
    //             hCenterPoint.x > intersectionPoint.x) {
    //           return "is I";
    //         }
    //       }
    //     }
    //   }
    // } else
    // if (lines.length == 3) {
    //   // is square
    //   // contains vertical (1-2)
    //   // contains horizontal (1-2)

    //   List<Line> dots = Dot.getDotLines(lines);
    //   List<Line> remainingLinesAfterDotLines = lines
    //       .where((line) => !dots.contains(line))
    //       .toList();
    //   List<Line> hLines = Rectangle.getHorizontalLines(
    //     remainingLinesAfterDotLines,
    //   );
    //   List<Line> remainingLinesAfterHLines = remainingLinesAfterDotLines
    //       .where((line) => !hLines.contains(line))
    //       .toList();
    //   List<Line> vLines = Rectangle.getVerticalLines(remainingLinesAfterHLines);
    //   // List<Line> restOfLines = remainingLinesAfterHLines
    //   //     .where((line) => !vLines.contains(line))
    //   //     .toList();

    //   // List<Line> hLines = Rectangle.getHorizontalLines(lines);
    //   // List<Line> vLines = Rectangle.getVerticalLines(lines);
    //   // List<Line> dots = Dot.getDotLines(lines);
    //   if (hLines.length == 2 && vLines.length == 1 ||
    //       hLines.length == 1 && vLines.length == 2) {
    //     // B D F H
    //     if (hLines.length == 2 && vLines.length == 1) {
    //       //
    //       // -|-----
    //       //  | F
    //       // -|-----
    //       //
    //       // -----|-
    //       //   D  |
    //       // -----|-
    //       //
    //       Line vLine = vLines.first;
    //       Point? intersectionPointFirst =
    //           LineIntersectionFinder.findIntersection(
    //             hLines.first.points,
    //             vLine.points,
    //           );
    //       Point? intersectionPointSecond =
    //           LineIntersectionFinder.findIntersection(
    //             hLines.last.points,
    //             vLine.points,
    //           );

    //       // bounding box centers
    //       BoundingBox vLineBoundingBox = BoundingBox.fromPoints(vLine.points);
    //       BoundingBox hLineBoundingBox = BoundingBox.fromPoints(
    //         hLines.first.points,
    //       );
    //       BoundingBox hLineBoundingBox2 = BoundingBox.fromPoints(
    //         hLines.last.points,
    //       );

    //       if (intersectionPointFirst != null &&
    //           intersectionPointSecond != null) {
    //         // What i want here?
    //         bool isRight =
    //             (vLineBoundingBox.center.x > hLineBoundingBox.center.x &&
    //             vLineBoundingBox.center.x > hLineBoundingBox2.center.x);
    //         bool isLeft =
    //             (vLineBoundingBox.center.x < hLineBoundingBox.center.x &&
    //             vLineBoundingBox.center.x < hLineBoundingBox2.center.x);
    //         bool horizontalLinesAroundVertical =
    //             (intersectionPointFirst.y < vLineBoundingBox.center.y &&
    //                 intersectionPointSecond.y > vLineBoundingBox.center.y) ||
    //             (intersectionPointFirst.y > vLineBoundingBox.center.y &&
    //                 intersectionPointSecond.y < vLineBoundingBox.center.y);

    //         // DO CHECK
    //         if (horizontalLinesAroundVertical) {
    //           if (isRight) {
    //             return "is D";
    //           } else if (isLeft) {
    //             return "is F";
    //           }
    //         }
    //       }
    //     } else if (hLines.length == 1 && vLines.length == 2) {
    //       //
    //       // -|----|-
    //       //  |    |
    //       //  |    |
    //       //
    //       //  |    |
    //       //  |    |
    //       // -|----|-
    //       //

    //       Line hLine = hLines.first;
    //       Point? intersectionPointFirst =
    //           LineIntersectionFinder.findIntersection(
    //             hLine.points,
    //             vLines.first.points,
    //           );
    //       Point? intersectionPointSecond =
    //           LineIntersectionFinder.findIntersection(
    //             hLine.points,
    //             vLines.last.points,
    //           );

    //       // bounding box centers
    //       BoundingBox hLineBoundingBox = BoundingBox.fromPoints(hLine.points);
    //       BoundingBox vLineBoundingBox = BoundingBox.fromPoints(
    //         vLines.first.points,
    //       );
    //       BoundingBox vLineBoundingBox2 = BoundingBox.fromPoints(
    //         vLines.last.points,
    //       );

    //       if (intersectionPointFirst != null &&
    //           intersectionPointSecond != null) {
    //         bool isAbove =
    //             (hLineBoundingBox.center.y < vLineBoundingBox.center.y &&
    //             hLineBoundingBox.center.y < vLineBoundingBox2.center.y);
    //         bool isBelow =
    //             (hLineBoundingBox.center.y > vLineBoundingBox.center.y &&
    //             hLineBoundingBox.center.y > vLineBoundingBox2.center.y);
    //         // What i need? around
    //         bool horizontalLinesAroundHorizontal =
    //             (hLineBoundingBox.center.x > vLineBoundingBox.center.x &&
    //                 hLineBoundingBox.center.x < vLineBoundingBox2.center.x) ||
    //             (hLineBoundingBox.center.x < vLineBoundingBox.center.x &&
    //                 hLineBoundingBox.center.x > vLineBoundingBox2.center.x);

    //         // DO CHECK
    //         if (horizontalLinesAroundHorizontal) {
    //           if (isAbove) {
    //             return "is H";
    //           } else if (isBelow) {
    //             return "is B";
    //           }
    //         }
    //       }
    //     }
    //   } else if (hLines.length == 1 && vLines.length == 1 && dots.length == 1) {
    //     // is square
    //     // contains vertical
    //     // contains horizontal
    //     // contains dot
    //     // J L P R
    //     // has dot inside

    //     // bounding box center
    //     Line hLine = hLines.first;
    //     Line vLine = vLines.first;

    //     BoundingBox hLineBoundingBox = BoundingBox.fromPoints(hLine.points);
    //     BoundingBox vLineBoundingBox = BoundingBox.fromPoints(vLine.points);

    //     Point? intersectionPoint = LineIntersectionFinder.findIntersection(
    //       hLine.points,
    //       vLine.points,
    //     );

    //     if (intersectionPoint != null) {
    //       bool isR =
    //           intersectionPoint.y < vLineBoundingBox.center.y &&
    //           intersectionPoint.x < hLineBoundingBox.center.x;

    //       bool isL =
    //           intersectionPoint.y > vLineBoundingBox.center.y &&
    //           intersectionPoint.x < hLineBoundingBox.center.x;

    //       bool isJ =
    //           intersectionPoint.y > vLineBoundingBox.center.y &&
    //           intersectionPoint.x > hLineBoundingBox.center.x;

    //       bool isP =
    //           intersectionPoint.y < vLineBoundingBox.center.y &&
    //           intersectionPoint.x > hLineBoundingBox.center.x;

    //       if (isJ) {
    //         return "is J";
    //       } else if (isL) {
    //         return "is L";
    //       } else if (isP) {
    //         return "is P";
    //       } else if (isR) {
    //         return "is R";
    //       }
    //     }
    //   }
    // } else
    if (lines.length == 4) {
      // List<Line> hLines = Rectangle.getHorizontalLines(lines);
      // List<Line> vLines = Rectangle.getVerticalLines(lines);
      // if (hLines.length == 2 && vLines.length == 2) {
      //   return "is E";
      // }

      // is square
      // contains vertical (1-2)
      // contains horizontal (1-2)
      // contains dot
      // O K M Q
      String res = check4WithDots(lines);
      if(res != ""){
        return res;
      }
      // List<Line> dots = Dot.getDotLines(lines);
      // List<Line> remainingLinesAfterDotLines = lines
      //     .where((line) => !dots.contains(line))
      //     .toList();
      // List<Line> hLines = Rectangle.getHorizontalLines(
      //   remainingLinesAfterDotLines,
      // );
      // List<Line> remainingLinesAfterHLines = remainingLinesAfterDotLines
      //     .where((line) => !hLines.contains(line))
      //     .toList();
      // List<Line> vLines = Rectangle.getVerticalLines(remainingLinesAfterHLines);
      // // List<Line> restOfLines = remainingLinesAfterHLines
      // //     .where((line) => !vLines.contains(line))
      // //     .toList();
      // if ((hLines.length == 1 && vLines.length == 2 && dots.length == 1) ||
      //     (hLines.length == 2 && vLines.length == 1 && dots.length == 1)) {
      //   if (hLines.length == 1 && vLines.length == 2 && dots.length == 1) {
      //     // K Q
      //   } else if (hLines.length == 2 &&
      //       vLines.length == 1 &&
      //       dots.length == 1) {
      //     // O M
      //   }
      // }
    }
    // else if (lines.length == 5) {
    //   List<Line> dotLines = Dot.getDotLines(lines);
    //   List<Line> remainingLinesAfterDotLines = lines
    //       .where((line) => !dotLines.contains(line))
    //       .toList();
    //   List<Line> hLines = Rectangle.getHorizontalLines(
    //     remainingLinesAfterDotLines,
    //   );
    //   List<Line> remainingLinesAfterHLines = remainingLinesAfterDotLines
    //       .where((line) => !hLines.contains(line))
    //       .toList();
    //   List<Line> vLines = Rectangle.getVerticalLines(remainingLinesAfterHLines);
    //   List<Line> restOfLines = remainingLinesAfterHLines
    //       .where((line) => !vLines.contains(line))
    //       .toList();
    //   // N
    //   if (hLines.length == 2 &&
    //       vLines.length == 2 &&
    //       dotLines.length == 1 &&
    //       restOfLines.isEmpty) {
    //     return "is N";
    //   }
    // }

    return "";
  }

  static String check4WithDots(List<Line> lines) {
    List<Line> dots = Dot.getDotLines(lines);
    List<Line> remainingLinesAfterDotLines = lines
        .where((line) => !dots.contains(line))
        .toList();
    List<Line> hLines = Rectangle.getHorizontalLines(
      remainingLinesAfterDotLines,
    );
    List<Line> remainingLinesAfterHLines = remainingLinesAfterDotLines
        .where((line) => !hLines.contains(line))
        .toList();
    List<Line> vLines = Rectangle.getVerticalLines(remainingLinesAfterHLines);

    if ((hLines.length == 1 && vLines.length == 2 && dots.length == 1) ||
        (hLines.length == 2 && vLines.length == 1 && dots.length == 1)) {
      // B D F H
      if (hLines.length == 2 && vLines.length == 1 && dots.length == 1) {
        //
        // -|-----
        //  | F
        // -|-----
        //
        // -----|-
        //   D  |
        // -----|-
        //
        Line vLine = vLines.first;
        Point? intersectionPointFirst = LineIntersectionFinder.findIntersection(
          hLines.first.points,
          vLine.points,
        );
        Point? intersectionPointSecond =
            LineIntersectionFinder.findIntersection(
              hLines.last.points,
              vLine.points,
            );

        // bounding box centers
        BoundingBox vLineBoundingBox = BoundingBox.fromPoints(vLine.points);
        BoundingBox hLineBoundingBox = BoundingBox.fromPoints(
          hLines.first.points,
        );
        BoundingBox hLineBoundingBox2 = BoundingBox.fromPoints(
          hLines.last.points,
        );

        if (intersectionPointFirst != null && intersectionPointSecond != null) {
          // What i want here?
          bool isRight =
              (vLineBoundingBox.center.x > hLineBoundingBox.center.x &&
              vLineBoundingBox.center.x > hLineBoundingBox2.center.x);
          bool isLeft =
              (vLineBoundingBox.center.x < hLineBoundingBox.center.x &&
              vLineBoundingBox.center.x < hLineBoundingBox2.center.x);
          bool horizontalLinesAroundVertical =
              (intersectionPointFirst.y < vLineBoundingBox.center.y &&
                  intersectionPointSecond.y > vLineBoundingBox.center.y) ||
              (intersectionPointFirst.y > vLineBoundingBox.center.y &&
                  intersectionPointSecond.y < vLineBoundingBox.center.y);

          // DO CHECK
          if (horizontalLinesAroundVertical) {
            if (isRight) {
              return "is M";
            } else if (isLeft) {
              return "is O";
            }
          }
        }
      } else if (hLines.length == 1 && vLines.length == 2 && dots.length == 1) {
        //
        // -|----|-
        //  |    |
        //  |    |
        //
        //  |    |
        //  |    |
        // -|----|-
        //

        Line hLine = hLines.first;
        Point? intersectionPointFirst = LineIntersectionFinder.findIntersection(
          hLine.points,
          vLines.first.points,
        );
        Point? intersectionPointSecond =
            LineIntersectionFinder.findIntersection(
              hLine.points,
              vLines.last.points,
            );

        // bounding box centers
        BoundingBox hLineBoundingBox = BoundingBox.fromPoints(hLine.points);
        BoundingBox vLineBoundingBox = BoundingBox.fromPoints(
          vLines.first.points,
        );
        BoundingBox vLineBoundingBox2 = BoundingBox.fromPoints(
          vLines.last.points,
        );

        if (intersectionPointFirst != null && intersectionPointSecond != null) {
          bool isAbove =
              (hLineBoundingBox.center.y < vLineBoundingBox.center.y &&
              hLineBoundingBox.center.y < vLineBoundingBox2.center.y);
          bool isBelow =
              (hLineBoundingBox.center.y > vLineBoundingBox.center.y &&
              hLineBoundingBox.center.y > vLineBoundingBox2.center.y);
          // What i need? around
          bool horizontalLinesAroundHorizontal =
              (hLineBoundingBox.center.x > vLineBoundingBox.center.x &&
                  hLineBoundingBox.center.x < vLineBoundingBox2.center.x) ||
              (hLineBoundingBox.center.x < vLineBoundingBox.center.x &&
                  hLineBoundingBox.center.x > vLineBoundingBox2.center.x);

          // DO CHECK
          if (horizontalLinesAroundHorizontal) {
            if (isAbove) {
              return "is Q";
            } else if (isBelow) {
              return "is K";
            }
          }
        }
      }
    }
    return "";
  }
}
