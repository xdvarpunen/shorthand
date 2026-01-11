import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/stroke_direction.dart';
import 'package:shorthand_app/new/stroke_util.dart';

class Numbers extends CanvasProcessor {
  // bool is0(List<List<Point>> lines) {
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkVerticalLine(line);
  // }

  // up down (line below)
  bool is1(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final verticalSegments = StrokeCutter.cutByVerticalDirectionChange(line);
    if (verticalSegments.length < 2) return false;

    final firstUp = StrokeInspector.isDirectionUp(verticalSegments[0]);
    final secondDown = StrokeInspector.isDirectionDown(verticalSegments[1]);

    return firstUp && secondDown;
  }

  bool is2(List<List<Point>> lines) {
    // right
    // left
    // right
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final verticalSegments = StrokeCutter.cutByHorizontalDirectionChange(line);
    if (verticalSegments.length < 3) return false;

    final firstRight = StrokeInspector.isDirectionUp(verticalSegments[0]);
    final secondLeft = StrokeInspector.isDirectionDown(verticalSegments[1]);
    final thirdRight = StrokeInspector.isDirectionUp(verticalSegments[2]);
    return firstRight && secondLeft && thirdRight;
  }

  bool is3(List<List<Point>> lines) {
    // right
    // left
    // right
    // left
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final verticalSegments = StrokeCutter.cutByHorizontalDirectionChange(line);
    if (verticalSegments.length < 4) return false;

    final firstRight = StrokeInspector.isDirectionUp(verticalSegments[0]);
    final secondLeft = StrokeInspector.isDirectionDown(verticalSegments[1]);
    final thirdRight = StrokeInspector.isDirectionUp(verticalSegments[2]);
    final fourthLeft = StrokeInspector.isDirectionDown(verticalSegments[3]);
    return firstRight && secondLeft && thirdRight && fourthLeft;
  }

  // bool is4(List<List<Point>> lines) {
  //   // left right
  //   // vertical
  //   // intersects
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  // bool is5(List<List<Point>> lines) {
  //   // horizontal crosses on above top center
  //   // start above end
  //   // two intersection on center y
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  // bool is6(List<List<Point>> lines) {
  //   // start and end are above bottom
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  // bool is7(List<List<Point>> lines) {
  //   // left right
  //   // crossing line
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  // bool is8(List<List<Point>> lines) {
  //   // crosses twice
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  // bool is9(List<List<Point>> lines) {
  //   // there top line is above start and end
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  String process(List<List<Point>> lines) {
    // if (is0(lines)) {
    //   return "0";
    // } else if (is1(lines)) {
    //   return "1";
    // } else if (is2(lines)) {
    //   return "2";
    // } else if (is3(lines)) {
    //   return "3";
    // } else if (is4(lines)) {
    //   return "4";
    // } else if (is5(lines)) {
    //   return "5";
    // } else if (is6(lines)) {
    //   return "6";
    // } else if (is7(lines)) {
    //   return "7";
    // } else if (is8(lines)) {
    //   return "8";
    // } else if (is9(lines)) {
    //   return "9";
    // }
    if (is1(lines)) {
      return "1";
    } else if (is2(lines)) {
      return "2";
    } else if (is3(lines)) {
      return "3";
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

class CheckNumber {
  String? isNumber(List<Point> line) {
    if (line.length < 2) return null;
    if (is1(line)) {
      return "1";
    }
    // if (is3(line)) {
    //   return "3";
    // } else 
    //  else if (is2(line)) {
    //   return "2";
    // }
    return null;
  }

  bool is1(List<Point> line) {
    final verticalSegments = StrokeCutter.cutByVerticalDirectionChange(line);
    if (verticalSegments.length < 2) return false;

    final firstUp = StrokeInspector.isDirectionUp(verticalSegments[0]);
    final secondDown = StrokeInspector.isDirectionDown(verticalSegments[1]);

    return firstUp && secondDown;
  }

  bool is2(List<Point> line) {
    // right
    // left
    // right
    final verticalSegments = StrokeCutter.cutByHorizontalDirectionChange(line);
    if (verticalSegments.length < 3) return false;

    final firstRight = StrokeInspector.isDirectionRight(verticalSegments[0]);
    final secondLeft = StrokeInspector.isDirectionLeft(verticalSegments[1]);
    final thirdRight = StrokeInspector.isDirectionRight(verticalSegments[2]);
    return firstRight && secondLeft && thirdRight;
  }

  bool is3(List<Point> line) {
    // right
    // left
    // right
    // left
    final verticalSegments = StrokeCutter.cutByHorizontalDirectionChange(line);
    if (verticalSegments.length < 4) return false;

    final firstRight = StrokeInspector.isDirectionRight(verticalSegments[0]);
    final secondLeft = StrokeInspector.isDirectionLeft(verticalSegments[1]);
    final thirdRight = StrokeInspector.isDirectionRight(verticalSegments[2]);
    final fourthLeft = StrokeInspector.isDirectionLeft(verticalSegments[3]);
    return firstRight && secondLeft && thirdRight && fourthLeft;
  }
}
