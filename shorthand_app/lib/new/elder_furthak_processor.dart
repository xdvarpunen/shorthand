import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/bounding_box_grouper.dart';
import 'package:shorthand_app/new/segment_intersection_grouper.dart';
import 'package:shorthand_app/new/stroke_direction.dart';
import 'package:shorthand_app/new/stroke_util.dart';

class ElderFurthakProcessor extends CanvasProcessor {
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

  bool isUruz(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    if (line.length < 2) return false;

    // Cut the line by vertical direction change
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    // Uruz requires at least two segments
    if (segments.length < 2) return false;

    final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
      segments[0],
    );

    final secondSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
      segments[1],
    );

    final secondSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
      segments[1],
    );

    return firstSegmentIsDirectionUp &&
        secondSegmentIsDirectionDown &&
        secondSegmentIsDirectionRight;
  }

  bool isFehu(List<List<Point>> lines) {
    // --- Group strokes by intersecting line segments ---
    final groups = SegmentIntersectionGrouper.groupByIntersectingLineSegments(
      lines,
    );

    if (groups.length == 1 && groups[0].length == 3) {
      final firstSegmentIsVertical =
          StrokeInspector.getOrientation(groups[0][0]) ==
          StrokeOrientation.vertical;

      final secondSegmentIsUp = StrokeInspector.isDirectionUp(groups[0][1]);
      final secondSegmentIsRight = StrokeInspector.isDirectionRight(
        groups[0][1],
      );

      final thirdSegmentIsUp = StrokeInspector.isDirectionUp(groups[0][2]);
      final thirdSegmentIsRight = StrokeInspector.isDirectionRight(
        groups[0][2],
      );

      return firstSegmentIsVertical &&
          secondSegmentIsUp &&
          secondSegmentIsRight &&
          thirdSegmentIsUp &&
          thirdSegmentIsRight;
    }

    return false;
  }

  bool isThurisaz(List<List<Point>> lines) {
    if (lines.length != 2) return false;

    final groups = SegmentIntersectionGrouper.groupByIntersectingLineSegments(
      lines,
    );

    if (groups.length != 1 || groups[0].length != 2) return false;

    final strokes = groups[0];

    // Find the vertical stroke
    final verticalStrokes = strokes
        .where(
          (s) =>
              StrokeInspector.getOrientation(s) == StrokeOrientation.vertical,
        )
        .toList();

    if (verticalStrokes.isEmpty) return false;

    // now we have at least one vertical stroke

    final hookStrokes = strokes.where((s) => isHookStroke(s)).toList();

    if (hookStrokes.isEmpty) return false;

    return true;
  }

  bool isKaunan(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
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

    return firstSegmentIsDirectionLeft && secondSegmentIsDirectionRight;
  }

  bool isHookStroke(List<Point> hookStroke) {
    final segments = StrokeCutter.cutByHorizontalDirectionChange(hookStroke);

    if (segments.length < 2) return false;

    final firstRight = StrokeInspector.isDirectionRight(segments[0]);
    final secondLeft = StrokeInspector.isDirectionLeft(segments[1]);

    return firstRight && secondLeft;
  }

  String sayUruz(List<List<Point>> lines) {
    final uruzMaybe = isUruz(lines);

    if (uruzMaybe) {
      return 'uruz';
    }

    return 'no uruz';
  }

  String sayFehu(List<List<Point>> lines) {
    final fehuMaybe = isFehu(lines);

    if (fehuMaybe) {
      return 'fehu';
    }

    return 'no fehu';
  }

  String sayThurisaz(List<List<Point>> lines) {
    final thurisazMaybe = isThurisaz(lines);

    if (thurisazMaybe) {
      return 'thurisaz';
    }

    return 'no thurisaz';
  }

  String sayAnsuz(List<List<Point>> lines) {
    final ansuzMaybe = isAnsuz(lines);

    if (ansuzMaybe) {
      return 'ansuz';
    }

    return 'no ansuz';
  }

  String sayRaido(List<List<Point>> lines) {
    final raidoMaybe = isRaido(lines);

    if (raidoMaybe) {
      return 'raido';
    }

    return 'no raido';
  }

  String sayKaunan(List<List<Point>> lines) {
    final kaunanMaybe = isKaunan(lines);

    if (kaunanMaybe) {
      return 'kaunan';
    }

    return 'no kaunan';
  }

  bool isAnsuz(List<List<Point>> lines) {
    final groups = SegmentIntersectionGrouper.groupByIntersectingLineSegments(
      lines,
    );

    for (final group in groups) {
      if (group.length < 3) continue;

      final verticals = group.where(
        (s) => StrokeInspector.getOrientation(s) == StrokeOrientation.vertical,
      );

      final rightDown = group.where(
        (s) =>
            StrokeInspector.isDirectionRight(s) &&
            StrokeInspector.isDirectionDown(s),
      );

      if (verticals.isNotEmpty && rightDown.length >= 2) {
        return true;
      }
    }

    return false;
  }

  bool isRaido(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;
    // Cut by vertical direction change
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
      segments[0],
    );

    final secondSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
      segments[1],
    );

    // Further cut the second segment by horizontal direction change
    final secondSegmentSegments = StrokeCutter.cutByHorizontalDirectionChange(
      segments[1],
    );

    if (secondSegmentSegments.length < 3) return false;

    final secondFirstIsRight = StrokeInspector.isDirectionRight(
      secondSegmentSegments[0],
    );

    final secondSecondIsLeft = StrokeInspector.isDirectionLeft(
      secondSegmentSegments[1],
    );

    final secondThirdIsRight = StrokeInspector.isDirectionRight(
      secondSegmentSegments[2],
    );

    return firstSegmentIsDirectionUp &&
        secondSegmentIsDirectionDown &&
        secondFirstIsRight &&
        secondSecondIsLeft &&
        secondThirdIsRight;
  }

  bool isGebo(List<List<Point>> lines) {
    final groups = SegmentIntersectionGrouper.groupByIntersectingLineSegments(
      lines,
    );

    if (groups.isEmpty) return false;

    final group = groups[0];

    // Classify strokes by direction
    final upRight = group.where(
      (s) =>
          StrokeInspector.isDirectionRight(s) &&
              StrokeInspector.isDirectionUp(s) ||
          StrokeInspector.isDirectionLeft(s) &&
              StrokeInspector.isDirectionDown(s),
    );

    final upLeft = group.where(
      (s) =>
          StrokeInspector.isDirectionLeft(s) &&
              StrokeInspector.isDirectionUp(s) ||
          StrokeInspector.isDirectionRight(s) &&
              StrokeInspector.isDirectionDown(s),
    );

    return upRight.length == 1 && upLeft.length == 1;
  }

  String sayGebo(List<List<Point>> lines) {
    final geboMaybe = isGebo(lines);

    if (geboMaybe) {
      return 'gebo';
    }

    return 'no gebo';
  }

  bool isWunjo(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;
    // Cut by vertical direction change
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    if (segments.length < 2) return false;

    final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
      segments[0],
    );

    final secondSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
      segments[1],
    );

    // Cut the second segment by horizontal direction change
    final secondSegmentSegments = StrokeCutter.cutByHorizontalDirectionChange(
      segments[1],
    );

    if (secondSegmentSegments.length < 2) return false;

    final secondFirstIsRight = StrokeInspector.isDirectionRight(
      secondSegmentSegments[0],
    );

    final secondSecondIsLeft = StrokeInspector.isDirectionLeft(
      secondSegmentSegments[1],
    );

    return firstSegmentIsDirectionUp &&
        secondSegmentIsDirectionDown &&
        secondFirstIsRight &&
        secondSecondIsLeft;
  }

  String sayWunjo(List<List<Point>> lines) {
    final wunjoMaybe = isWunjo(lines);

    if (wunjoMaybe) {
      return 'wunjo';
    }

    return 'no wunjo';
  }

  bool isHagalaz(List<List<Point>> lines) {
    final groups = SegmentIntersectionGrouper.groupByIntersectingLineSegments(
      lines,
    );

    if (groups.length != 1 || groups[0].length != 3) return false;

    final group = groups[0];

    // Find vertical down strokes
    final verticalDown = group.where(
      (s) =>
          StrokeInspector.getOrientation(s) == StrokeOrientation.vertical &&
          StrokeInspector.isDirectionDown(s),
    );

    // Find diagonal stroke going right & down
    final diagonalRightDown = group.where(
      (s) =>
          StrokeInspector.isDirectionRight(s) &&
          StrokeInspector.isDirectionDown(s) &&
          StrokeInspector.getOrientation(s) != StrokeOrientation.vertical,
    );

    return verticalDown.length == 2 && diagonalRightDown.length == 1;
  }

  String sayHagalaz(List<List<Point>> lines) {
    final hagalazMaybe = isHagalaz(lines);

    if (hagalazMaybe) {
      return 'hagalaz';
    }

    return 'no hagalaz';
  }

  bool isNaudiz(List<List<Point>> lines) {
    // Group intersecting strokes
    final groups = SegmentIntersectionGrouper.groupByIntersectingLineSegments(
      lines,
    );

    if (groups.length != 1 || groups[0].length != 2) return false;

    final group = groups[0];

    // Find vertical downward stroke
    final verticalDown = group.where(
      (s) =>
          StrokeInspector.getOrientation(s) == StrokeOrientation.vertical &&
          StrokeInspector.isDirectionDown(s),
    );

    // Find diagonal stroke going right & down
    final diagonalRightDown = group.where(
      (s) =>
          StrokeInspector.isDirectionRight(s) &&
          StrokeInspector.isDirectionDown(s) &&
          StrokeInspector.getOrientation(s) != StrokeOrientation.vertical,
    );

    return verticalDown.length == 1 && diagonalRightDown.length == 1;
  }

  bool isIsa(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;
    // Get orientation
    final strokeOrientation = StrokeInspector.getOrientation(line);

    // Isa is just a vertical stroke
    return strokeOrientation == StrokeOrientation.vertical;
  }

  bool isJera(List<List<Point>> lines) {
    // Group strokes by intersecting bounding boxes
    final groups = BoundingBoxGrouper.groupByIntersectingBoundingBoxes(lines);

    if (groups.length != 1 || groups[0].length != 2) return false;

    final group = groups[0];

    // Cut first stroke by horizontal direction change
    final firstSegments = StrokeCutter.cutByHorizontalDirectionChange(group[0]);
    final firstLeft = StrokeInspector.isDirectionLeft(firstSegments[0]);
    final firstRight = StrokeInspector.isDirectionRight(firstSegments[1]);

    // Cut second stroke by horizontal direction change
    final secondSegments = StrokeCutter.cutByHorizontalDirectionChange(
      group[1],
    );
    final secondRight = StrokeInspector.isDirectionRight(secondSegments[0]);
    final secondLeft = StrokeInspector.isDirectionLeft(secondSegments[1]);

    return firstLeft && firstRight && secondRight && secondLeft;
  }

  bool isEihwaz(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // Cut the stroke by vertical direction changes
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    // Eihwaz pattern: down → up → down
    final firstDown = StrokeInspector.isDirectionDown(segments[0]);
    final secondUp = StrokeInspector.isDirectionUp(segments[1]);
    final thirdDown = StrokeInspector.isDirectionDown(segments[2]);

    return firstDown && secondUp && thirdDown;
  }

  bool isPerthro(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // Cut the stroke by vertical direction changes
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    if (segments.length < 5) return false; // Safety check

    // Perthro pattern: down → up → down → up → down
    final firstDown = StrokeInspector.isDirectionDown(segments[0]);
    final secondUp = StrokeInspector.isDirectionUp(segments[1]);
    final thirdDown = StrokeInspector.isDirectionDown(segments[2]);
    final fourthUp = StrokeInspector.isDirectionUp(segments[3]);
    final fifthDown = StrokeInspector.isDirectionDown(segments[4]);

    return firstDown && secondUp && thirdDown && fourthUp && fifthDown;
  }

  bool isAlgiz(List<List<Point>> lines) {
    // Group strokes by intersecting bounding boxes
    final groups = BoundingBoxGrouper.groupByIntersectingBoundingBoxes(lines);

    if (groups.length != 1 || groups[0].length != 2) return false;

    final group = groups[0];

    // First stroke must be vertical
    final firstIsVertical =
        StrokeInspector.getOrientation(group[0]) == StrokeOrientation.vertical;

    // Second stroke cut by vertical direction changes (down/up)
    final secondSegments = StrokeCutter.cutByVerticalDirectionChange(group[1]);

    if (secondSegments.length < 2) return false;

    final secondFirstDown = StrokeInspector.isDirectionDown(secondSegments[0]);
    final secondSecondUp = StrokeInspector.isDirectionUp(secondSegments[1]);

    return firstIsVertical && secondFirstDown && secondSecondUp;
  }

  bool isSowilo(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // Cut the stroke by horizontal direction changes (left ↔ right)
    final segments = StrokeCutter.cutByHorizontalDirectionChange(line);

    if (segments.length < 4) return false;

    final firstLeft = StrokeInspector.isDirectionLeft(segments[0]);
    final secondRight = StrokeInspector.isDirectionRight(segments[1]);
    final thirdLeft = StrokeInspector.isDirectionLeft(segments[2]);
    final fourthRight = StrokeInspector.isDirectionRight(segments[3]);

    return firstLeft && secondRight && thirdLeft && fourthRight;
  }

  bool isTiwaz(List<List<Point>> lines) {
    // Group strokes by intersecting bounding boxes
    final groups = BoundingBoxGrouper.groupByIntersectingBoundingBoxes(lines);

    if (groups.length == 1 && groups[0].length == 2) {
      // First stroke must be vertical
      final firstIsVertical =
          StrokeInspector.getOrientation(groups[0][0]) ==
          StrokeOrientation.vertical;

      // Second stroke cut by vertical direction changes
      final secondSegments = StrokeCutter.cutByVerticalDirectionChange(
        groups[0][1],
      );
      if (secondSegments.length < 2) return false;

      final secondFirstUp = StrokeInspector.isDirectionUp(secondSegments[0]);
      final secondSecondDown = StrokeInspector.isDirectionDown(
        secondSegments[1],
      );

      return firstIsVertical && secondFirstUp && secondSecondDown;
    }

    return false;
  }

  bool isBerkano(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // Cut the stroke by vertical direction changes
    final verticalSegments = StrokeCutter.cutByVerticalDirectionChange(line);
    if (verticalSegments.length < 2) return false;

    final firstSegmentIsUp = StrokeInspector.isDirectionUp(verticalSegments[0]);
    final secondSegmentIsDown = StrokeInspector.isDirectionDown(
      verticalSegments[1],
    );

    // Cut the second vertical segment by horizontal direction changes
    final horizontalSegments = StrokeCutter.cutByHorizontalDirectionChange(
      verticalSegments[1],
    );
    if (horizontalSegments.length < 4) return false;

    final firstRight = StrokeInspector.isDirectionRight(horizontalSegments[0]);
    final secondLeft = StrokeInspector.isDirectionLeft(horizontalSegments[1]);
    final thirdRight = StrokeInspector.isDirectionRight(horizontalSegments[2]);
    final fourthLeft = StrokeInspector.isDirectionLeft(horizontalSegments[3]);

    // Check the full Berkano pattern
    return firstSegmentIsUp &&
        secondSegmentIsDown &&
        firstRight &&
        secondLeft &&
        thirdRight &&
        fourthLeft;
  }

  bool isEhwaz(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // Cut the stroke by vertical direction changes
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);
    if (segments.length < 4) return false;

    final firstSegmentIsUp = StrokeInspector.isDirectionUp(segments[0]);
    final secondSegmentIsDown = StrokeInspector.isDirectionDown(segments[1]);
    final thirdSegmentIsUp = StrokeInspector.isDirectionUp(segments[2]);
    final fourthSegmentIsDown = StrokeInspector.isDirectionDown(segments[3]);

    // Check the Ehwaz pattern
    return firstSegmentIsUp &&
        secondSegmentIsDown &&
        thirdSegmentIsUp &&
        fourthSegmentIsDown;
  }

  bool isMannaz(List<List<Point>> lines) {
    // Group by intersecting line segments
    final groups = SegmentIntersectionGrouper.groupByIntersectingLineSegments(
      lines,
    );

    if (groups.length != 1 || groups[0].length != 2) return false;

    final group = groups[0];

    // Cut first stroke by vertical direction change
    final firstSegments = StrokeCutter.cutByVerticalDirectionChange(group[0]);
    if (firstSegments.length < 2) return false;
    final firstUp = StrokeInspector.isDirectionUp(firstSegments[0]);
    final firstDown = StrokeInspector.isDirectionDown(firstSegments[1]);

    // Cut second stroke by vertical direction change
    final secondSegments = StrokeCutter.cutByVerticalDirectionChange(group[1]);
    if (secondSegments.length < 2) return false;
    final secondUp = StrokeInspector.isDirectionUp(secondSegments[0]);
    final secondDown = StrokeInspector.isDirectionDown(secondSegments[1]);

    return firstUp && firstDown && secondUp && secondDown;
  }

  bool isLaguz(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // --- Cut the stroke by vertical direction change ---
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    if (segments.length < 2) return false;

    final firstSegmentUp = StrokeInspector.isDirectionUp(segments[0]);
    final secondSegmentDown = StrokeInspector.isDirectionDown(segments[1]);

    // --- Return true if the pattern matches Laguz ---
    return firstSegmentUp && secondSegmentDown;
  }

  bool isIngwaz(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // --- Cut the stroke by vertical direction change ---
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    if (segments.length < 2) return false;

    final firstSegmentDown = StrokeInspector.isDirectionDown(segments[0]);
    final secondSegmentUp = StrokeInspector.isDirectionUp(segments[1]);

    // --- Further cut each vertical segment horizontally ---
    final downSegments = StrokeCutter.cutByHorizontalDirectionChange(
      segments[0],
    );
    if (downSegments.length < 2) return false;
    final downLeft = StrokeInspector.isDirectionLeft(downSegments[0]);
    final downRight = StrokeInspector.isDirectionRight(downSegments[1]);

    final upSegments = StrokeCutter.cutByHorizontalDirectionChange(segments[1]);
    if (upSegments.length < 2) return false;
    final upRight = StrokeInspector.isDirectionRight(upSegments[0]);
    final upLeft = StrokeInspector.isDirectionLeft(upSegments[1]);

    // --- Return true if pattern matches Ingwaz ---
    return firstSegmentDown &&
        secondSegmentUp &&
        downLeft &&
        downRight &&
        upRight &&
        upLeft;
  }

  bool isDagaz(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // --- Cut the stroke by vertical direction change ---
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    if (segments.length < 4) return false; // Need at least 4 segments

    final firstUp = StrokeInspector.isDirectionUp(segments[0]);
    final secondDown = StrokeInspector.isDirectionDown(segments[1]);
    final secondRight = StrokeInspector.isDirectionRight(segments[1]);
    final thirdUp = StrokeInspector.isDirectionUp(segments[2]);
    final fourthDown = StrokeInspector.isDirectionDown(segments[3]);
    final fourthLeft = StrokeInspector.isDirectionLeft(segments[3]);

    return firstUp &&
        secondDown &&
        secondRight &&
        thirdUp &&
        fourthDown &&
        fourthLeft;
  }

  bool isOthala(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // --- Cut by vertical direction change ---
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    if (segments.length < 2) return false; // Need at least 2 segments

    final firstSegmentIsUp = StrokeInspector.isDirectionUp(segments[0]);
    final secondSegmentIsDown = StrokeInspector.isDirectionDown(segments[1]);

    // --- Cut first segment (up) by horizontal changes ---
    final upSegmentSegments = StrokeCutter.cutByHorizontalDirectionChange(
      segments[0],
    );
    if (upSegmentSegments.length < 2) return false;

    final upFirstRight = StrokeInspector.isDirectionRight(upSegmentSegments[0]);
    final upSecondLeft = StrokeInspector.isDirectionLeft(upSegmentSegments[1]);

    // --- Cut second segment (down) by horizontal changes ---
    final downSegmentSegments = StrokeCutter.cutByHorizontalDirectionChange(
      segments[1],
    );
    if (downSegmentSegments.length < 2) return false;

    final downFirstLeft = StrokeInspector.isDirectionLeft(
      downSegmentSegments[0],
    );
    final downSecondRight = StrokeInspector.isDirectionRight(
      downSegmentSegments[1],
    );

    return firstSegmentIsUp &&
        secondSegmentIsDown &&
        upFirstRight &&
        upSecondLeft &&
        downFirstLeft &&
        downSecondRight;
  }

  String process(List<List<Point>> lines) {
    return isOthala(lines) ? "yes" : "no";
  }

  String getSegmentCount(List<List<Point>> lines) {
    if (lines.isEmpty) return 'Count: 0';

    // Use the first line for now
    final line = reducePoints(lines.first, 3);

    if (line.length < 2) return 'Count: 0';

    // Cut the line by vertical direction change
    final segments = StrokeCutter.cutByVerticalDirectionChange(line);

    return 'Count: ${segments.length}';
  }

  @override
  String getOutput(PointsManager pointsManager) {
    final List<List<Point>> lines = pointsManager.lines
        .map(
          (line) => reducePoints(line.points, 10),
        ) // 3, increase... or just use end points only
        .toList();

    final entry = process(lines);
    // final entry = getSegmentCount(lines);

    return 'Char: $entry';
  }
}
