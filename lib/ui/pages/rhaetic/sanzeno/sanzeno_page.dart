import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/core/bounding_box_grouper.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/model/point.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/line_inspector.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/copy/bounding_box.dart';
import 'package:shorthand_app/ui/pages/rhaetic/line_box.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class SanzenoPage extends StatefulWidget {
  const SanzenoPage({super.key});

  @override
  State<SanzenoPage> createState() => _SanzenoPageState();
}

class _SanzenoPageState extends State<SanzenoPage> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = SanzenoLinesInterpreter();

  @override
  void initState() {
    super.initState();
    _controller = CanvasController(
      textInterpreter: interpreter,
      processOnPointerUp: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CanvasComplexTemplatePage(
      title: 'Rhaetic Page',
      controller: _controller,
      onClear: _controller.clear,
      onUndo: _controller.undo,
      onRedo: _controller.redo,
      canvas: PaintTypeNoProcessor(
        backgroundColor: Colors.grey,
        controller: _controller,
      ),
    );
  }
}

class SanzenoLinesInterpreter extends TextLinesInterpreter {
  @override
  String process(List<Line> lines) {
    if (isPhi2(lines)) {
      return "Is Phi2";
    }
    if (isPhi(lines)) {
      return "Is Phi";
    }
    if (isUpsilon(lines)) {
      return "Is Upsilon";
    }
    if (isUpsilon2(lines)) {
      return "Is Upsilon2";
    }
    if (isTs(lines)) {
      return "Is Ts";
    }
    if (isTau(lines)) {
      return "Is Tau";
    }
    if (isSigma(lines)) {
      return "Is Sigma";
    }
    if (isRho(lines)) {
      return "Is Rho";
    }
    if (isSan(lines)) {
      return "Is San";
    }
    if (isNu(lines)) {
      return "Is Nu";
    }
    if (isAlpha(lines)) {
      return "Is Alpha";
    }
    if (isEpsilon(lines)) {
      return "Is Epsilon";
    }
    if (isWau(lines)) {
      return "Is Wau";
    }
    if (isHeta(lines)) {
      return "Is Heta";
    }
    if (isLambda(lines)) {
      return "Is Lambda";
    }
    if (isTheta(lines)) {
      return "Is Theta";
    }
    if (isIota(lines)) {
      return "Is Iota";
    }
    if (isKappa(lines)) {
      return "Is Kappa";
    }
    if (isMu(lines)) {
      return "Is Mu";
    }
    return '';
  }

  // Alpha
  // Ascending
  // 2x Descending
  // Descending ones are intersecting the ascending one
  bool isAlpha(List<Line> lines) {
    if (lines.length != 3) return false;
    // Separate lines by direction
    final ascending = lines.where(LineInspector.isAscendingLine).toList();
    final descending = lines.where(LineInspector.isDescendingLine).toList();
    // Must be exactly 1 ascending and 2 descending
    if (ascending.length != 1 || descending.length != 2) {
      return false;
    }
    final ascLine = ascending.first;

    // Both descending lines must intersect the ascending line
    for (final descLine in descending) {
      if (!LineInspector.linesIntersect(ascLine, descLine)) {
        return false;
      }
    }
    return true;
  }

  // Epsilon
  // vertical
  // 3x lines ascending intersecting vertical
  bool isEpsilon(List<Line> lines) {
    if (lines.length != 4) return false;

    // Separate lines by direction
    final vertical = lines.where(LineInspector.isVerticalLine).toList();
    final ascending = lines.where(LineInspector.isAscendingLine).toList();

    // Must be exactly 1 vertical and 3 ascending
    if (vertical.length != 1 || ascending.length != 3) {
      return false;
    }

    final verticalLine = vertical.first;

    // All ascending lines must intersect the vertical line
    for (final ascLine in ascending) {
      if (!LineInspector.linesIntersect(verticalLine, ascLine)) {
        return false;
      }
    }

    return true;
  }

  // Wau
  // vertical
  // 2x lines ascending intersecting vertical
  bool isWau(List<Line> lines) {
    if (lines.length != 3) return false;

    // Separate lines by direction
    final vertical = lines.where(LineInspector.isVerticalLine).toList();
    final ascending = lines.where(LineInspector.isAscendingLine).toList();

    // Must be exactly 1 vertical and 3 ascending
    if (vertical.length != 1 || ascending.length != 2) {
      return false;
    }

    final verticalLine = vertical.first;

    // All ascending lines must intersect the vertical line
    for (final ascLine in ascending) {
      if (!LineInspector.linesIntersect(verticalLine, ascLine)) {
        return false;
      }
    }

    return true;
  }

  // Zeta
  // none
  void zeta(List<Line> lines) {}

  // Heta
  // 2x vertical
  // 2x lines ascending and intersecting both vertical
  // TODO: need to think further... sort of for loop is only requirement + right and left most is at end of bounding box
  bool isHeta(List<Line> lines) {
    if (lines.length != 4) return false;

    // Separate lines by direction
    final vertical = lines.where(LineInspector.isVerticalLine).toList();
    final ascending = lines.where(LineInspector.isAscendingLine).toList();

    // Must be exactly 2 vertical and 2 ascending
    if (vertical.length != 2 || ascending.length != 2) {
      return false;
    }

    // Each ascending line must intersect both vertical lines
    for (final ascLine in ascending) {
      for (final vertLine in vertical) {
        if (!LineInspector.linesIntersect(ascLine, vertLine)) {
          return false;
        }
      }
    }

    return true;
  }

  // Theta
  // Ascending
  // Descending
  // Both intersecting making X
  // bool isTheta(List<Line> lines) {
  //   if (lines.length != 2) return false;

  //   final ascending = lines.where(LineInspector.isAscendingLine).toList();
  //   final descending = lines.where(LineInspector.isDescendingLine).toList();

  //   // Must be exactly one of each
  //   if (ascending.length != 1 || descending.length != 1) {
  //     return false;
  //   }

  //   final intersects = LineInspector.linesIntersect(
  //     ascending.first,
  //     descending.first,
  //   );
  //   if (!intersects) return false;

  //   final descMaxY = descending.first.points
  //       .map((p) => p.y)
  //       .reduce((a, b) => a > b ? a : b);

  //   final bounds = BoundingBoxGrouper.boundsFromLines(lines);

  //   if (descMaxY < bounds.center.y) return false;
  //   return true;
  // }
  Point topPoint(Line l) {
    return l.points[0].y < l.points[l.points.length - 1].y
        ? l.points[0]
        : l.points[l.points.length - 1];
  }

  Point bottomPoint(Line l) {
    return l.points[0].y > l.points[l.points.length - 1].y
        ? l.points[0]
        : l.points[l.points.length - 1];
  }

  bool isTheta(List<Line> lines) {
    if (lines.length != 2) return false;

    final bounds = BoundingBoxGrouper.boundsFromLines(lines);
    final centerY = bounds.center.y;

    final l1 = lines[0];
    final l2 = lines[1];

    final l1Top = topPoint(l1);
    final l1Bottom = bottomPoint(l1);
    final l2Top = topPoint(l2);
    final l2Bottom = bottomPoint(l2);

    // Both top points above center, both bottom points below center
    if (!(l1Top.y < centerY && l2Top.y < centerY)) return false;
    if (!(l1Bottom.y > centerY && l2Bottom.y > centerY)) return false;

    // They must intersect
    return LineInspector.linesIntersect(l1, l2);
  }

  // Lambda
  // Descending
  // Vertical, longer than descending and top point above start point
  // Descending line not above center of bounding box to separate from upsilon
  bool isLambda(List<Line> lines) {
    if (lines.length != 2) return false;

    final bounds = BoundingBoxGrouper.boundsFromLines(lines);
    final centerY = bounds.center.y;

    bool isBelowCenter(Line l) =>
        l.points.first.y > centerY && l.points.last.y > centerY;

    final below = lines.where(isBelowCenter).toList();
    final aboveOrCrossing = lines.where((l) => !isBelowCenter(l)).toList();

    // Must be exactly one below and one not-below
    if (below.length != 1 || aboveOrCrossing.length != 1) {
      return false;
    }

    // They must intersect
    return LineInspector.linesIntersect(below.first, aboveOrCrossing.first);
  }

  // Iota
  // Vertical
  bool isIota(List<Line> lines) {
    if (lines.length != 1) return false;

    final vertical = lines.where(LineInspector.isVerticalLine).toList();

    // Must be exactly one
    if (vertical.length != 1) {
      return false;
    }

    return true;
  }

  // Kappa
  // Vertical
  // Descending Left
  // Descending Right
  // Descending Left and Descending Right intersect Vertical once
  // Kappa
  // 1x Vertical
  // 2x Descending (left & right)
  // Descending lines intersect the vertical once
  bool isVerticalAndRightSideOfBoundingBox(Line line, Bounds bounds) {
    return LineInspector.isVerticalLine(line) &&
        line.points.first.x > bounds.center.x &&
        line.points.last.x > bounds.center.x;
  }

  bool descendingAndRight(Line line, Bounds bounds) {
    return LineInspector.isDirectionRight(line.points) &&
        LineInspector.isDescendingLine(line) &&
        !(line.points.first.x > bounds.center.x &&
            line.points.last.x > bounds.center.x);
  }

  bool descendingAndLeft(Line line, Bounds bounds) {
    return LineInspector.isDirectionLeft(line.points) &&
        LineInspector.isDescendingLine(line) &&
        !(line.points.first.x > bounds.center.x &&
            line.points.last.x > bounds.center.x);
  }

  bool isKappa(List<Line> lines) {
    if (lines.length != 3) return false;

    // get bounding box, find line that is on right of bounding box center completely (start and end point)

    var bb = BoundingBoxGrouper.boundsFromLines(lines);

    final vertical = lines
        .where((line) => isVerticalAndRightSideOfBoundingBox(line, bb))
        .toList();
    final descendingAndRightLine = lines
        .where((line) => descendingAndRight(line, bb))
        .toList();
    final descendingAndLeftLine = lines
        .where((line) => descendingAndLeft(line, bb))
        .toList();

    // Must be exactly 1 vertical and 2 descending
    if (vertical.length != 1 ||
        descendingAndRightLine.length != 1 ||
        descendingAndLeftLine.length != 1) {
      return false;
    }

    final verticalLine = vertical.first;

    // Both descending lines must intersect the vertical
    if (!LineInspector.linesIntersect(
      descendingAndRightLine.first,
      verticalLine,
    )) {
      return false;
    }
    if (!LineInspector.linesIntersect(
      descendingAndLeftLine.first,
      verticalLine,
    )) {
      return false;
    }

    return true;
  }

  // Mu
  // up, down, up, long down
  // Ascending
  // Descending
  // Ascending
  // Vertical, others above center bounding box
  bool isMu(List<Line> lines) {
    if (lines.length < 4) return false;

    // Find the longest line (vertical)
    Line vertical = lines.reduce((a, b) {
      final aSpan = (bottomPoint(a).y - topPoint(a).y).abs();
      final bSpan = (bottomPoint(b).y - topPoint(b).y).abs();
      return aSpan > bSpan ? a : b;
    });

    final centerY = BoundingBoxGrouper.boundsFromLines([vertical]).center.y;

    // Other lines above vertical center
    final others = lines
        .where((l) => l != vertical)
        .where((l) => bottomPoint(l).y < centerY)
        .toList();

    if (others.length < 3) return false;

    // Count ascending and descending
    final ascendingCount = others.where(LineInspector.isAscendingLine).length;
    final descendingCount = others.where(LineInspector.isDescendingLine).length;

    return ascendingCount >= 2 && descendingCount >= 1;
  }

  // Nu
  // down, up, long down
  // Descending
  // Ascending
  // Vertical, others above center bounding box
  bool isNu(List<Line> lines) {
    if (lines.length != 3) return false;

    // Find the longest line (vertical)
    Line vertical = lines.reduce((a, b) {
      final aSpan = (bottomPoint(a).y - topPoint(a).y).abs();
      final bSpan = (bottomPoint(b).y - topPoint(b).y).abs();
      return aSpan > bSpan ? a : b;
    });

    final centerY = BoundingBoxGrouper.boundsFromLines([vertical]).center.y;

    // Other lines above vertical center
    final others = lines
        .where((l) => l != vertical)
        .where((l) => bottomPoint(l).y < centerY)
        .toList();

    if (others.length < 2) return false;
    return true;
  }

  // Pi
  // up, down
  // Ascending
  // Vertical, others above center bounding box
  bool isPi(List<Line> lines) {
    if (lines.length != 2) return false;

    final bounds = BoundingBoxGrouper.boundsFromLines(lines);
    final centerY = bounds.center.y;

    bool isAboveCenter(Line l) =>
        l.points.first.y < centerY && l.points.last.y < centerY;

    final below = lines.where(isAboveCenter).toList();
    final aboveOrCrossing = lines.where((l) => !isAboveCenter(l)).toList();

    // Must be exactly one below and one not-below
    if (below.length != 1 || aboveOrCrossing.length != 1) {
      return false;
    }

    // They must intersect
    final doIntersect = LineInspector.linesIntersect(
      below.first,
      aboveOrCrossing.first,
    );
    if (!doIntersect) return false;

    final firstBB = BoundingBox.fromPoints(below.first.points);
    final secondBB = BoundingBox.fromPoints(aboveOrCrossing.first.points);

    final firstIsLeftSide = firstBB.center.x < secondBB.center.x;
    if (!firstIsLeftSide) return false;

    return true;
  }

  // San
  // long up, down, up, long down
  // Ascending, Vertical, others above center bounding box
  // Descending
  // Ascending
  // Descending, Vertical, others above center bounding box
  // bool isSan(List<Line> lines) {
  //   if (lines.length == 4) return false;
  //   final boundingBoxes = lines
  //       .map((line) => BoundingBox.fromPoints(line.points))
  //       .toList();

  //   // Sort in-place by center.x
  //   boundingBoxes.sort((a, b) => a.center.x.compareTo(b.center.x));

  //   // 2 is descending
  //   // 3 is ascending

  //   // 2 and 3 center y are above 1 and 4 center y

  //   // Find the two longest lines (verticals)
  //   final sortedBySpan = lines.toList()
  //     ..sort((a, b) {
  //       final aSpan = (bottomPoint(a).y - topPoint(a).y).abs();
  //       final bSpan = (bottomPoint(b).y - topPoint(b).y).abs();
  //       return bSpan.compareTo(aSpan); // descending
  //     });

  //   final verticals = sortedBySpan.take(2).toList();
  //   final others = lines.where((l) => !verticals.contains(l)).toList();

  //   if (verticals.length != 2) return false;

  //   final bounds1 = BoundingBoxGrouper.boundsFromLines([verticals[0]]);
  //   final bounds2 = BoundingBoxGrouper.boundsFromLines([verticals[1]]);

  //   // Separate "above verticals" lines
  //   final aboveVerticals = others.where((l) {
  //     final bottom = bottomPoint(l).y;
  //     // line should be above **at least one** vertical's center
  //     return bottom < bounds1.center.y || bottom < bounds2.center.y;
  //   }).toList();

  //   if (aboveVerticals.length < 4) return false; // we expect 4 short strokes

  //   // Count ascending and descending lines
  //   final ascendingCount = aboveVerticals
  //       .where(LineInspector.isAscendingLine)
  //       .length;
  //   final descendingCount = aboveVerticals
  //       .where(LineInspector.isDescendingLine)
  //       .length;

  //   // At least 2 ascending and 2 descending in the middle strokes
  //   if (ascendingCount < 2 || descendingCount < 2) return false;

  //   return true;
  // }
  bool isSan(List<Line> lines) {
    if (lines.length != 4) return false;

    // Create LineBox bag
    final lineBoxes = lines.map((line) => LineBox(line)).toList();

    // Sort by center.x
    lineBoxes.sort((a, b) => a.box.center.x.compareTo(b.box.center.x));

    // Pick strokes by index
    final left = lineBoxes[0];
    final middle1 = lineBoxes[1];
    final middle2 = lineBoxes[2];
    final right = lineBoxes[3];

    final middleAboveLeftAndRightCenterY =
        middle1.box.center.y < left.box.center.y &&
        middle2.box.center.y < left.box.center.y &&
        middle1.box.center.y < right.box.center.y &&
        middle2.box.center.y < right.box.center.y;

    if (!middleAboveLeftAndRightCenterY) return false;

    return LineInspector.isDescendingLine(middle1.line) &&
        LineInspector.isAscendingLine(middle2.line);
  }

  // Rho
  // Ascending, right
  // Descending, Vertical, others above center bounding box
  // Ascending, left
  // intersection of ascending between vertical one
  // two intersection of vertical on bounding box right side
  bool isRho(List<Line> lines) {
    if (lines.length != 3) return false;

    // Create LineBox bag
    final lineBoxes = lines.map((line) => LineBox(line)).toList();

    // Sort by center.x (left → right)
    lineBoxes.sort((a, b) => a.box.center.x.compareTo(b.box.center.x));

    // Rightmost is vertical
    final vertical = lineBoxes.last;
    final others = lineBoxes.sublist(0, 2);

    // Both other lines must intersect the vertical line
    if (!LineInspector.linesIntersect(others[0].line, vertical.line)) {
      return false;
    }
    if (!LineInspector.linesIntersect(others[1].line, vertical.line)) {
      return false;
    }
    if (!LineInspector.linesIntersect(others[0].line, others[1].line)) {
      return false;
    }

    // final verticalHeight = vertical.box.maxY - vertical.box.minY;
    // final others1 = others[0].box.maxY - others[0].box.minY;
    // final others2 = others[1].box.maxY - others[1].box.minY;
    // if (!(verticalHeight > others1 && verticalHeight > others2)) return false;

    return true;
  }

  // Sigma
  // ascending all
  // right, left, right
  bool isSigma(List<Line> lines) {
    if (lines.length != 3) return false;

    // Create LineBox bag
    final lineBoxes = lines.map((line) => LineBox(line)).toList();

    lineBoxes.sort((a, b) => a.box.center.y.compareTo(b.box.center.y));

    final top = lineBoxes[0].line;
    final middle = lineBoxes[1].line;
    final bottom = lineBoxes[2].line;

    final directionsCorrectAscending =
        LineInspector.isDirectionRight(top.points) &&
        LineInspector.isDirectionLeft(middle.points) &&
        LineInspector.isDirectionRight(bottom.points);

    final directionsCorrectDescending =
        LineInspector.isDirectionLeft(top.points) &&
        LineInspector.isDirectionRight(middle.points) &&
        LineInspector.isDirectionLeft(bottom.points);

    if (directionsCorrectDescending) {
      // All lines must be descending
      if (!LineInspector.isDescendingLine(top) ||
          !LineInspector.isDescendingLine(middle) ||
          !LineInspector.isDescendingLine(bottom)) {
        return false;
      }
    } else if (directionsCorrectAscending) {
      // All lines must be ascending
      if (!LineInspector.isAscendingLine(top) ||
          !LineInspector.isAscendingLine(middle) ||
          !LineInspector.isAscendingLine(bottom)) {
        return false;
      }
    }
    return true;
  }

  // Tau
  // Ascending vertical
  // Descending, above ascending bounding box center
  bool isTau(List<Line> lines) {
    if (lines.length != 2) return false;

    final bounds = BoundingBoxGrouper.boundsFromLines(lines);
    final centerY = bounds.center.y;

    bool isAboveCenter(Line l) =>
        l.points.first.y < centerY && l.points.last.y < centerY;

    final below = lines.where(isAboveCenter).toList();
    final aboveOrCrossing = lines.where((l) => !isAboveCenter(l)).toList();

    // Must be exactly one below and one not-below
    if (below.length != 1 || aboveOrCrossing.length != 1) {
      return false;
    }

    // They must intersect
    final doIntersect = LineInspector.linesIntersect(
      below.first,
      aboveOrCrossing.first,
    );
    if (!doIntersect) return false;

    final firstBB = BoundingBox.fromPoints(below.first.points);
    final secondBB = BoundingBox.fromPoints(aboveOrCrossing.first.points);

    final firstIsRightSide = firstBB.center.x > secondBB.center.x;
    if (!firstIsRightSide) return false;

    return true;
  }

  // Ts
  // Ascending
  // Descending
  // Vertical start and end between bounding box of ascending and descending
  bool isTs(List<Line> lines) {
    if (lines.length != 3) return false;

    // Find tallest line (vertical stem)
    final vertical = lines.reduce((a, b) {
      final aHeight = (bottomPoint(a).y - topPoint(a).y).abs();
      final bHeight = (bottomPoint(b).y - topPoint(b).y).abs();
      return aHeight > bHeight ? a : b;
    });

    final centerY = BoundingBoxGrouper.boundsFromLines([vertical]).center.y;

    // Other two lines must be above vertical center
    final others = lines
        .where((l) => l != vertical)
        .where((l) => bottomPoint(l).y < centerY)
        .toList();

    if (others.length != 2) return false;

    final hasAscending = others.any(LineInspector.isAscendingLine);
    final hasDescending = others.any(LineInspector.isDescendingLine);

    return hasAscending && hasDescending;
  }

  // Upsilon
  // Descending
  // Ascending
  // Both lines top starting/ending point is above center of bounding box
  bool isUpsilon(List<Line> lines) {
    if (lines.length != 2) return false;

    final ascending = lines.where(LineInspector.isAscendingLine).toList();
    final descending = lines.where(LineInspector.isDescendingLine).toList();

    // Must be exactly one of each
    if (ascending.length != 1 || descending.length != 1) {
      return false;
    }

    final bounds = BoundingBoxGrouper.boundsFromLines(lines);
    final centerY = bounds.center.y;

    final ascTopY = topPoint(ascending.first).y;
    final descTopY = topPoint(descending.first).y;

    // Both start (top) above center
    if (ascTopY > centerY) return false;
    if (descTopY > centerY) return false;

    // descending left, ascending right
    if (BoundingBoxGrouper.boundsFromLines([ascending.first]).center.x <
        BoundingBoxGrouper.boundsFromLines([descending.first]).center.x) {
      return false;
    }

    return true;
  }

  bool isUpsilon2(List<Line> lines) {
    if (lines.length != 2) return false;

    final ascending = lines.where(LineInspector.isAscendingLine).toList();
    final descending = lines.where(LineInspector.isDescendingLine).toList();

    // Must be exactly one of each
    if (ascending.length != 1 || descending.length != 1) {
      return false;
    }

    final bounds = BoundingBoxGrouper.boundsFromLines(lines);
    final centerY = bounds.center.y;

    final ascBottomY = bottomPoint(ascending.first).y;
    final descBottomY = bottomPoint(descending.first).y;

    // Both start (bottom) below center
    if (ascBottomY < centerY) return false;
    if (descBottomY < centerY) return false;

    // descending right, ascending left
    if (BoundingBoxGrouper.boundsFromLines([ascending.first]).center.x >
        BoundingBoxGrouper.boundsFromLines([descending.first]).center.x) {
      return false;
    }
    return true;
  }

  // Phi
  // Descending Right
  // Descending Left
  // Ascending Left
  // Ascending Right
  // vertical in middle
  bool isPhi(List<Line> lines) {
    if (lines.length != 5) return false;

    final boxes = lines.map((l) => LineBox(l)).toList();

    // Sort by X
    boxes.sort((a, b) => a.box.center.x.compareTo(b.box.center.x));

    // Middle is vertical
    final center = boxes[2];
    if (!LineInspector.isVerticalLine(center.line)) return false;

    // final cx = center.box.center.x;
    // final cy = center.box.center.y;

    // bool check(LineBox b, bool shouldAscend) {
    //   return shouldAscend
    //       ? LineInspector.isAscendingLine(b.line)
    //       : LineInspector.isDescendingLine(b.line);
    // }

    // for (final b in boxes.where((b) => b != center)) {
    //   final isLeft = b.box.center.x < cx;
    //   final isTop = b.box.center.y < cy;

    //   if (isLeft && isTop) {
    //     if (!check(b, true)) return false; // top-left → ascending
    //   } else if (isLeft && !isTop) {
    //     if (!check(b, false)) return false; // bottom-left → descending
    //   } else if (!isLeft && isTop) {
    //     if (!check(b, false)) return false; // top-right → descending
    //   } else {
    //     if (!check(b, true)) return false; // bottom-right → ascending
    //   }
    // }

    return true;
  }

  bool isPhi2(List<Line> lines) {
    if (lines.length != 5) return false;

    final boxes = lines.map((l) => LineBox(l)).toList();

    // Sort by X (left → right)
    boxes.sort((a, b) => a.box.center.x.compareTo(b.box.center.x));

    // Middle is vertical
    final center = boxes[2];
    if (!LineInspector.isVerticalLine(center.line)) return false;

    final cy = center.box.center.y;

    // Find max Y from the other four lines
    final maxOtherY = boxes
        .where((b) => b != center)
        .map((b) => bottomPoint(b.line).y)
        .reduce((a, b) => a > b ? a : b);

    // Vertical center must be below others
    if (cy <= maxOtherY) return false;

    return true;
  }

  // Chi
  // Vertical
  // Descending right
  // Ascending right
  // Descending and ascending abover center of bounding box
  bool isChi(List<Line> lines) {
    if (lines.length != 3) return false;

    // Find tallest line (vertical)
    final vertical = lines.reduce((a, b) {
      final aHeight = (bottomPoint(a).y - topPoint(a).y).abs();
      final bHeight = (bottomPoint(b).y - topPoint(b).y).abs();
      return aHeight > bHeight ? a : b;
    });

    final vertBox = BoundingBox.fromPoints(vertical.points);
    final centerY = vertBox.center.y;

    // Other two lines
    final others = lines.where((l) => l != vertical).toList();
    if (others.length != 2) return false;

    // Both must be above vertical center
    if (others.any((l) => bottomPoint(l).y > centerY)) return false;

    // Must have one ascending and one descending
    final hasAscending = others.any(LineInspector.isAscendingLine);
    final hasDescending = others.any(LineInspector.isDescendingLine);
    if (!hasAscending || !hasDescending) return false;

    return true;
  }
}
