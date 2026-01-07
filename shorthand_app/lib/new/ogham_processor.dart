import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/line_intersection_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/stroke_direction.dart';
import 'package:shorthand_app/new/stroke_util.dart';

class OghamScriptUtil {
  List<Point> upperStemEdge(
    double stemY,
    double thickness, {
    double width = 9999,
  }) {
    final y = stemY - thickness / 2;
    return [Point(0, y), Point(width, y)];
  }

  List<Point> lowerStemEdge(
    double stemY,
    double thickness, {
    double width = 9999,
  }) {
    final y = stemY + thickness / 2;
    return [Point(0, y), Point(width, y)];
  }

  bool lineIntersectWithStem(List<Point> line, List<Point> stem) {
    return LineIntersectionUtil().linesIntersect(line, stem);
  }
}

class OghamProcessor extends CanvasProcessor {
  late double locationOfLine;
  late double thicknessOfLine;

  double upperEdge() => locationOfLine - thicknessOfLine / 2;
  double lowerEdge() => locationOfLine + thicknessOfLine / 2;

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
      if (p.y > upperEdge() && p.y <= lowerEdge()) {
        return false;
      }
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
      if (p.x < maxXPoint.x) {
        maxXPoint = p;
      }
    }
    return maxXPoint;
  }

  bool isStart(List<List<Point>> lines) {
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

    Point mostRightXOfLinePoint = mostRightXPoint(line);
    bool isMostRightXOfLinePointWithinStems =
        mostRightXOfLinePoint.y > upperEdge() &&
        mostRightXOfLinePoint.y <= lowerEdge();

    return isMostRightXOfLinePointWithinStems &&
        firstSegmentIsDirectionLeft &&
        secondSegmentIsDirectionRight;
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

  bool isOi(List<List<Point>> lines) {
    // max y outside stems
    // min y outside stems
    // most left x inside stems
    // most right x inside stems
    return false;
  }

  bool isUi(List<List<Point>> lines) {
    // line cross upper stem
    // left right
    // up down
    return false;
  }

  bool isEa(List<List<Point>> lines) {
    // x
    // two lines that intersect
    // both lines cross upper stem
    // both lines cross lower stem
    return false;
  }

  bool isAe() {
    // 3 lines intersect 4 lines
    return false;
  }

  String process(List<List<Point>> lines) {
    if (lines.length == 1) {
      if (isStart(lines)) {
        return "Start ᚛";
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
      if (isG(lines)) {
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
          (line) => reducePoints(line.points, 10),
        ) // 3, increase... or just use end points only
        .toList();

    final entry = process(lines);
    return 'Char: $entry';
  }
}
