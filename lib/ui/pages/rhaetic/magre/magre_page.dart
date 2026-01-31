
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/line_inspector.dart';
import 'package:shorthand_app/ui/pages/rhaetic/line_box.dart';
import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class MagrePage extends StatefulWidget {
  const MagrePage({super.key});

  @override
  State<MagrePage> createState() => _MagrePageState();
}

class _MagrePageState extends State<MagrePage> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = MagreLinesInterpreter();

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
      title: 'Magre Page',
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

class MagreLinesInterpreter extends TextLinesInterpreter {
  @override
  String process(List<Line> lines) {
    // TODO: implement process
    throw UnimplementedError();
  }

  // Alpha
  // Ascending
  // 2x Descending
  // Descending ones intersecting

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
  // Vertical
  // 2x lines ascending intersecting vertical
  void zeta(List<Line> lines) {}

  // Heta
  // 2x vertical
  // 3x lines ascending and intersecting both vertical

  // Theta
  // Ascending
  // Descending
  // Both intersecting making X

  // Iota
  // Vertical

  // Kappa
  // Vertical
  // Descending Left
  // Descending Right

  // Lambda
  // Ascending
  // Vertical, longer than ascending and bottom point above start point
  // Ascending line not below center of bounding box

  // Mu

  // Nu

  // Pi

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

  // Ts

  // Upsilon
  // Descending
  // Ascending
  // Both lines above center of bounding box

  // Phi
  // Descending Right
  // Descending Left
  // Ascending Left
  // Ascending Right
  // vertical in middle long, other lines above center of bounding box

  // Chi
  // Vertical
  // Descending right
  // Ascending right
  // Descending and ascending abover center of bounding box
}
