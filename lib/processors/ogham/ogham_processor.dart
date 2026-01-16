import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/common/model/lines.dart';
import 'package:shorthand_app/engine/line_intersection_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/segment_intersection_grouper.dart';
import 'package:shorthand_app/engine/stroke_direction.dart';
import 'package:shorthand_app/engine/stroke_util.dart';
import 'package:shorthand_app/processors/ogham/ogham_script_util.dart';



class OghamProcessor extends CanvasProcessor {
  late double locationOfLine;
  late double thicknessOfLine;

  double upperEdge() => locationOfLine - thicknessOfLine / 2;
  double lowerEdge() => locationOfLine + thicknessOfLine / 2;
  bool isPointBetweenEdges(Point p) =>
    p.y >= upperEdge() && p.y <= lowerEdge();

  OghamProcessor(this.locationOfLine, this.thicknessOfLine);

  bool isH(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> line = lines.first;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(line, upperStem);
  }

  bool isD(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem);
  }

  bool isT(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], upperStem);
  }

  bool isC(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[3], upperStem);
  }

  bool isQ(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[3], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[4], upperStem);
  }

  bool isB(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> line = lines.first;
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(line, lowerStem);
  }

  bool isL(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem);
  }

  bool isF(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], lowerStem);
  }

  bool isS(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[3], lowerStem);
  }

  bool isN(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[3], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[4], lowerStem);
  }

  bool isM(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> line = lines.first;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(line, upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(line, lowerStem);
  }

  bool isG(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem);
  }

  bool isNG(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], lowerStem);
  }

  bool isST(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[3], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[3], lowerStem);
  }

  bool isR(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    return OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[2], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[3], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[3], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[4], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[4], lowerStem);
  }

  bool isA(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> line = lines.first;
    if (line.length != 1) return false;
    return line.first.y > upperEdge() && line.first.y < lowerEdge();
  }

  bool isO(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    return lines[0].first.y > upperEdge() &&
        lines[0].first.y < lowerEdge() &&
        lines[1].first.y > upperEdge() &&
        lines[1].first.y < lowerEdge();
  }

  bool isU(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    return lines[0].first.y > upperEdge() &&
        lines[0].first.y < lowerEdge() &&
        lines[1].first.y > upperEdge() &&
        lines[1].first.y < lowerEdge() &&
        lines[2].first.y > upperEdge() &&
        lines[2].first.y < lowerEdge();
  }

  bool isE(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    return lines[0].first.y > upperEdge() &&
        lines[0].first.y < lowerEdge() &&
        lines[1].first.y > upperEdge() &&
        lines[1].first.y < lowerEdge() &&
        lines[2].first.y > upperEdge() &&
        lines[2].first.y < lowerEdge() &&
        lines[3].first.y > upperEdge() &&
        lines[3].first.y < lowerEdge();
  }

  bool isI(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    return lines[0].first.y > upperEdge() &&
        lines[0].first.y < lowerEdge() &&
        lines[1].first.y > upperEdge() &&
        lines[1].first.y < lowerEdge() &&
        lines[2].first.y > upperEdge() &&
        lines[2].first.y < lowerEdge() &&
        lines[3].first.y > upperEdge() &&
        lines[3].first.y < lowerEdge() &&
        lines[4].first.y > upperEdge() &&
        lines[4].first.y < lowerEdge();
  }

  bool isP(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> line = lines.first;
    if (line.length < 2) return false;
    for (final p in line) {
      if (p.y <= lowerEdge()) {
        return false;
      }
    }
    return true;
  }

  bool isSpace(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    List<Point> line = lines.first;
    if (line.length < 2) return false;
    for (final p in line) {
      if (!isPointBetweenEdges(p)) return false;
    }
    return true;
  }

  Point mostLeftXPoint(List<Point> line) {
    Point minXPoint = line.first;
    for (final p in line) {
      if (p.x < minXPoint.x) {
        minXPoint = p;
      }
    }
    return minXPoint;
  }

  Point mostRightXPoint(List<Point> line) {
    Point maxXPoint = line.first;
    for (final p in line) {
      if (p.x > maxXPoint.x) {
        maxXPoint = p;
      }
    }
    return maxXPoint;
  }

  bool isEnd(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final segments = StrokeCutter.cutByHorizontalDirectionChange(line);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionLeft = StrokeInspector.isDirectionLeft(
      segments[0],
    );

    final secondSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
      segments[1],
    );

    Point mostLeftXOfLinePoint = mostLeftXPoint(line);
    bool isMostRightXOfLinePointWithinStems =
        mostLeftXOfLinePoint.y > upperEdge() &&
        mostLeftXOfLinePoint.y <= lowerEdge();

    return isMostRightXOfLinePointWithinStems &&
        firstSegmentIsDirectionLeft &&
        secondSegmentIsDirectionRight;
  }

  bool isStart(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final segments = StrokeCutter.cutByHorizontalDirectionChange(line);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
      segments[0],
    );

    final secondSegmentIsDirectionLeft = StrokeInspector.isDirectionLeft(
      segments[1],
    );

    Point mostRightXOfLinePoint = mostRightXPoint(line);
    bool isMostRightXOfLinePointWithinStems =
        mostRightXOfLinePoint.y > upperEdge() &&
        mostRightXOfLinePoint.y <= lowerEdge();

    return isMostRightXOfLinePointWithinStems &&
        firstSegmentIsDirectionRight &&
        secondSegmentIsDirectionLeft;
  }

  Point mostTopYPoint(List<Point> line) {
    Point minYPoint = line.first;
    for (final p in line) {
      if (p.y < minYPoint.y) {
        minYPoint = p;
      }
    }
    return minYPoint;
  }

  Point mostBottomYPoint(List<Point> line) {
    Point maxYPoint = line.first;
    for (final p in line) {
      if (p.y > maxYPoint.y) {
        maxYPoint = p;
      }
    }
    return maxYPoint;
  }

  bool isOi(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    Point mostLeftXOfLinePoint = mostLeftXPoint(line);
    Point mostRightXOfLinePoint = mostRightXPoint(line);
    Point mostTopYOfLinePoint = mostTopYPoint(line);
    Point mostBottomYOfLinePoint = mostBottomYPoint(line);

    bool leftIsWithinStems =
        mostLeftXOfLinePoint.y > upperEdge() &&
        mostLeftXOfLinePoint.y < lowerEdge();
    bool rightIsWithinStems =
        mostRightXOfLinePoint.y > upperEdge() &&
        mostRightXOfLinePoint.y < lowerEdge();
    bool topIsAboveStems = mostTopYOfLinePoint.y < upperEdge();
    bool bottomIsBelowStems = mostBottomYOfLinePoint.y > lowerEdge();

    return leftIsWithinStems &&
        rightIsWithinStems &&
        topIsAboveStems &&
        bottomIsBelowStems;
  }

  bool hasAllDirections(List<Point> line) {
    bool hasUp = false;
    bool hasDown = false;
    bool hasLeft = false;
    bool hasRight = false;

    for (int i = 0; i < line.length - 1; i++) {
      final p1 = line[i];
      final p2 = line[i + 1];

      final dx = p2.x - p1.x;
      final dy = p2.y - p1.y;

      if (dy < 0) hasUp = true;
      if (dy > 0) hasDown = true;
      if (dx < 0) hasLeft = true;
      if (dx > 0) hasRight = true;

      // Early exit if all found
      if (hasUp && hasDown && hasLeft && hasRight) {
        return true;
      }
    }

    return hasUp && hasDown && hasLeft && hasRight;
  }

  bool isUi(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;
    // line cross upper stem
    // left right
    // up down

    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );

    if (!OghamScriptUtil().lineIntersectWithStem(line, lowerStem)) return false;

    bool hasAllDirectionsFound = hasAllDirections(line);
    return hasAllDirectionsFound;

    // final segmentsVertical = StrokeCutter.cutByVerticalDirectionChange(line);

    // if (segmentsVertical.length < 2) return false;

    // final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
    //   segmentsVertical[0],
    // );

    // final secondSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
    //   segmentsVertical[1],
    // );

    // final segmentsHorizontal = StrokeCutter.cutByHorizontalDirectionChange(
    //   line,
    // );

    // if (segmentsHorizontal.length < 2) return false;

    // final firstSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
    //   segmentsHorizontal[0],
    // );

    // final secondSegmentIsDirectionLeft = StrokeInspector.isDirectionLeft(
    //   segmentsHorizontal[1],
    // );

    // return firstSegmentIsDirectionUp &&
    //     secondSegmentIsDirectionDown &&
    //     firstSegmentIsDirectionRight &&
    //     secondSegmentIsDirectionLeft;
  }

  bool isEa(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    if (lines.length > 2) return false;
    // x
    // two lines that intersect
    // both lines cross upper stem
    // both lines cross lower stem
    final groups = SegmentIntersectionGrouper.groupByIntersectingLineSegments(
      lines,
    );

    if (groups.isEmpty) return false;

    final group = groups[0];

    // Classify strokes by direction
    final upRight = group.where(
      (s) =>
          (StrokeInspector.isDirectionRight(s) &&
              StrokeInspector.isDirectionUp(s)) ||
          (StrokeInspector.isDirectionLeft(s) &&
              StrokeInspector.isDirectionDown(s)),
    );

    final upLeft = group.where(
      (s) =>
          (StrokeInspector.isDirectionLeft(s) &&
              StrokeInspector.isDirectionUp(s)) ||
          (StrokeInspector.isDirectionRight(s) &&
              StrokeInspector.isDirectionDown(s)),
    );

    bool linesCrossEachOther = upRight.length == 1 && upLeft.length == 1;

    if (!linesCrossEachOther) return false;

    List<Point> upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    List<Point> lowerStem = OghamScriptUtil().lowerStemEdge(
      locationOfLine,
      thicknessOfLine,
    );
    bool linesCrossBothUpperAndLowerStem =
        OghamScriptUtil().lineIntersectWithStem(lines[0], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[0], lowerStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], upperStem) &&
        OghamScriptUtil().lineIntersectWithStem(lines[1], lowerStem);

    return linesCrossEachOther && linesCrossBothUpperAndLowerStem;
  }

  bool isAe(List<List<Point>> lines) {
    if (lines.length < 7) return false;

    // First 4 lines must intersect the upper stem
    final upperStem = OghamScriptUtil().upperStemEdge(
      locationOfLine,
      thicknessOfLine,
    );

    for (int i = 0; i < 4; i++) {
      if (!OghamScriptUtil().lineIntersectWithStem(lines[i], upperStem)) {
        return false;
      }
    }

    // Now: 3 lines (4,5,6) must intersect ALL of lines (0–3)
    for (int i = 4; i < 7; i++) {
      for (int j = 0; j < 4; j++) {
        if (!LineIntersectionUtil().linesIntersect(lines[i], lines[j])) {
          return false; // this line does NOT intersect one of 0–3
        }
      }
    }

    return true;
  }

  @override
  String process(Lines2 lines2) {
    final List<List<Point>> lines = lines2.toListOfListOfPoints();
    if (lines.length == 1) {
      if (isUi(lines)) {
        return "Ui ᚗ";
      } else if (isSpace(lines)) {
        return "Space";
      } else if (isOi(lines)) {
        return "Oi ᚖ";
      } else if (isStart(lines)) {
        return "Start ᚛"; // picks M for some reason
      } else if (isEnd(lines)) {
        return "End ᚜";
      } else if (isM(lines)) {
        return "M ᚋ ";
      } else if (isA(lines)) {
        return "A ᚐ";
      } else if (isH(lines)) {
        return "H ᚆ";
      } else if (isB(lines)) {
        return "B ᚁ";
      } else if (isP(lines)) {
        return "P ᚚ";
      }
    } else if (lines.length == 2) {
      if (isEa(lines)) {
        return "Ea ᚕ";
      } else if (isG(lines)) {
        return "G ᚌ";
      } else if (isD(lines)) {
        return "D ᚇ";
      } else if (isL(lines)) {
        return "L ᚂ";
      } else if (isO(lines)) {
        return "O ᚑ";
      }
    } else if (lines.length == 3) {
      if (isNG(lines)) {
        return "NG ᚍ";
      } else if (isT(lines)) {
        return "T ᚈ";
      } else if (isF(lines)) {
        return "F ᚃ";
      } else if (isU(lines)) {
        return "U ᚒ";
      }
    } else if (lines.length == 4) {
      if (isST(lines)) {
        return "S ᚎ";
      } else if (isC(lines)) {
        return "C ᚉ";
      } else if (isS(lines)) {
        return "S ᚄ";
      } else if (isE(lines)) {
        return "E ᚓ";
      }
    } else if (lines.length == 5) {
      if (isR(lines)) {
        return "R ᚏ";
      } else if (isQ(lines)) {
        return "Q ᚊ";
      } else if (isN(lines)) {
        return "N ᚅ";
      } else if (isI(lines)) {
        return "I ᚔ";
      }
    } else if (lines.length == 7) {
      if (isAe(lines)) {
        return "Ae ᚙ";
      }
    }
    return "";
  }
}
