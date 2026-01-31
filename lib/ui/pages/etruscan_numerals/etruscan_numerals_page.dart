import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/core/bounding_box_grouper.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/line_inspector.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/lines/intersecting_x_range_grouper.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class EtruscanNumeralsPage extends StatefulWidget {
  const EtruscanNumeralsPage({super.key});

  @override
  State<EtruscanNumeralsPage> createState() => _EtruscanNumeralsPageState();
}

class _EtruscanNumeralsPageState extends State<EtruscanNumeralsPage> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = EtruscanNumeralsLinesInterpreter();

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
      title: 'Etruscan Numerals Page',
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

class EtruscanNumeralsLinesInterpreter extends TextLinesInterpreter {
  bool isNumberOne(List<Line> lines) {
    if (lines.length != 1) return false;
    return LineInspector.checkVerticalLine(lines.first.points);
  }

  bool isNumberFive(List<Line> lines) {
    if (lines.length != 2) return false;
    return LineInspector.isAscendingLine(lines.first) &&
        LineInspector.isDescendingLine(lines.last);
  }

  bool isNumberTen(List<Line> lines) {
    if (lines.length != 2) return false;

    final ascending = lines.where(LineInspector.isAscendingLine).toList();
    final descending = lines.where(LineInspector.isDescendingLine).toList();

    // Must be exactly one of each
    if (ascending.length != 1 || descending.length != 1) {
      return false;
    }

    return LineInspector.linesIntersect(ascending.first, descending.first);
  }

  Line? findTallVertical(List<Line> lines) {
    double ySpan(Line line) {
      final ys = line.points.map((p) => p.y);
      return ys.reduce((a, b) => a > b ? a : b) -
          ys.reduce((a, b) => a < b ? a : b);
    }

    final verticals = lines.where(LineInspector.isVerticalLine).toList();
    if (verticals.isEmpty) return null;

    // pick the tallest vertical
    verticals.sort((a, b) => ySpan(b).compareTo(ySpan(a)));
    return verticals.first;
  }

  bool isNumberFifty(List<Line> lines) {
    if (lines.length != 3) return false;

    final vertical = findTallVertical(lines);
    if (vertical == null) return false;

    final bounds = BoundingBoxGrouper.boundsFromLines([vertical]);
    final centerY = bounds.center.y;

    // remaining two lines must be above center Y
    final others = lines.where((l) => l != vertical).toList();
    if (others.length != 2) return false;

    for (final line in others) {
      final start = line.points.first.y;
      final end = line.points.last.y;
      if (start > centerY || end > centerY) {
        return false;
      }
    }

    // from remaining lines: one ascending, one descending
    final ascending = others.where(LineInspector.isAscendingLine).length == 1;
    final descending = others.where(LineInspector.isDescendingLine).length == 1;

    return ascending && descending;
  }

  bool isNumberHundred(List<Line> lines) {
    if (lines.length != 3) return false;

    bool isBetween(double v, double a, double b) =>
        (v > a && v < b) || (v > b && v < a);

    for (final middle in lines) {
      final others = lines.where((l) => l != middle).toList();
      if (others.length != 2) continue;

      final midTopX = middle.points.first.x;
      final midBottomX = middle.points.last.x;

      final o1 = others[0];
      final o2 = others[1];

      // centered at both ends
      if (!isBetween(midTopX, o1.points.first.x, o2.points.first.x)) continue;
      if (!isBetween(midBottomX, o1.points.last.x, o2.points.last.x)) continue;

      // all intersect → X + middle
      if (!LineInspector.linesIntersect(middle, o1)) continue;
      if (!LineInspector.linesIntersect(middle, o2)) continue;
      if (!LineInspector.linesIntersect(o1, o2)) continue;

      return true;
    }

    return false;
  }

  String _detectNumber(List<Line> lines) {
    if (isNumberOne(lines)) return '1';
    if (isNumberTen(lines)) return '10';
    if (isNumberFive(lines)) return '5';
    if (isNumberHundred(lines)) return '100';
    if (isNumberFifty(lines)) return '50';

    return '?';
  }

  @override
  String process(List<Line> lines) {
    final groups = IntersectingXRangeGrouper.groupByIntersectingXRange(
      lines.map((l) => l.points).toList(),
    );

    // TODO add this to toolbox, sort by x position groups
    // groups.sort((a, b) {
    //   double minX(List<List<Point>> g) =>
    //       g.expand((l) => l).map((p) => p.x).reduce((a, b) => a < b ? a : b);

    //   return minX(a).compareTo(minX(b));
    // });

    final buffer = StringBuffer();

    for (final group in groups) {
      final groupLines = group.map((pts) => Line(pts)).toList();
      buffer.write(_detectNumber(groupLines));
    }

    return buffer.toString();
  }
}
