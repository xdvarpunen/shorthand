import 'dart:math';

import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/angle_inspector_final.dart';
import 'package:shorthand_app/new/slavic/idea.dart';
import 'package:shorthand_app/new/stroke_direction.dart';
import 'package:shorthand_app/new/stroke_util.dart';
import 'package:shorthand_app/processors/kahakalamahou_processor.dart';

class Constants extends CanvasProcessor {
  // neper
  // sounds like number 9 but reverse

  bool isRightLeftRight(List<AngleRun> runs) {
    if (runs.length < 3) return false;

    for (var i = 0; i <= runs.length - 3; i++) {
      if (runs[i].direction == LineDirection.right &&
          runs[i + 1].direction == LineDirection.left &&
          runs[i + 2].direction == LineDirection.right) {
        return true;
      }
    }

    return false;
  }

  bool isD(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final lineAngle = LineAngle.fromPoints(line);

    final runs = lineAngle.splitByAngleChange();

    return isRightLeftRight(runs);
  }

  bool isNeperConstant(List<List<Point>> lines) {
    // angle left only
    // there top line is above start and end
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final lineAngle = LineAngle.fromPoints(line);

    final runs = lineAngle.splitByAngleChange();

    return runs.length == 1 && runs[0].direction == LineDirection.right;
  }

  bool isPiConstant(List<List<Point>> lines) {
    // 3 lines
    // one horizontal
    // two vertical intersecting
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    return LineUtil().checkHorizontalLine(line);
  }

  bool isPhiConstant(List<List<Point>> lines) {
    // circle
    // vertical crossing twice
    // could make alternative where
    // right angle only
    // intersection between start and end y and x
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    return LineUtil().checkHorizontalLine(line);
  }

  String process(List<List<Point>> lines) {
    if (isNeperConstant(lines)) {
      // euler number
      return "N";
    } else if (isPiConstant(lines)) {
      return "Z2";
    } else if (isPhiConstant(lines)) {
      // golden ratio
      return "Z2";
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

class CheckConstant {
  String? isNeperConstant(List<Point> line) {
    // angle left only
    // there top line is above start and end
    // bounding box left is left from start and end
    if (line.length < 2) return null;

    // final lineAngle = LineAngle.fromPoints(line);

    // final runs = lineAngle.splitByAngleChange();

    // if(runs[0].direction == LineDirection.left){
    //   // return e.toString();
    //   return "2.718281828459045";
    // }
    // final bb = BoundingBox.fromPoints(line);
    // if (bb.minX <= line.first.x && bb.minX < line.last.x) {
    //   return "2.718281828459045";
    // }

    final verticalSegments = StrokeCutter.cutByHorizontalDirectionChange(line);
    if (verticalSegments.length < 3) return null;

    final firstRight = StrokeInspector.isDirectionRight(verticalSegments[0]);
    final secondLeft = StrokeInspector.isDirectionLeft(verticalSegments[1]);
    final thirdRight = StrokeInspector.isDirectionRight(verticalSegments[2]);
    if (firstRight && secondLeft && thirdRight) {
      return "2.718281828459045";
    }
    return null;
  }
}
