// https://en.wikipedia.org/wiki/Carolingian_minuscule

import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/core/bounding_box_grouper.dart';
import 'package:shorthand_app/toolbox/core/stroke_direction.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/line_inspector.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/lines/intersecting_x_range_grouper.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class CarolingianMinisculePage extends StatefulWidget {
  const CarolingianMinisculePage({super.key});

  @override
  State<CarolingianMinisculePage> createState() =>
      _CarolingianMinisculePageState();
}

class _CarolingianMinisculePageState extends State<CarolingianMinisculePage> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = CarolingianMinisculeInterpreter();

  @override
  void initState() {
    super.initState();
    _controller = CanvasController(
      textInterpreter: interpreter,
      processOnPointerUp: true,
      useCalligraphyPen: true,
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
      title: 'Carolingian Miniscule Page',
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

class CarolingianMinisculeInterpreter extends TextLinesInterpreter {
  // length: 2
  // contains horizontal
  // contains up down, left right
  bool isT(List<Line> lines) {
    if (lines.length != 2) return false;

    // sort by bounding box center
    final bounds1 = BoundingBoxGrouper.boundsFromLines([lines[0]]);
    final bounds2 = BoundingBoxGrouper.boundsFromLines([lines[1]]);

    Line upper = lines[0];
    Line lower = lines[1];
    if (bounds1.center.y > bounds2.center.y) {
      upper = lines[1];
      lower = lines[0];
    }

    // upper is horizontal
    if (!LineInspector.isHorizontalLine(upper)) return false;
    // lower contains up down, left right
    final strokes = StrokeCutter.cutByVerticalDirectionChange(lower.points);
    if (strokes.length != 2) return false;

    return LineInspector.isDescendingLine(Line(strokes[0])) &&
        LineInspector.isDirectionLeft(strokes[0]) &&
        LineInspector.isAscendingLine(Line(strokes[1])) &&
        LineInspector.isDirectionRight(strokes[1]);

    // return true;
  }

  // length: 2
  // contains horizontal
  // contains down left, right (split by horizontal direction)
  bool isZ(List<Line> lines) {
    if (lines.length != 2) return false;

    // sort by bounding box center
    // upper is horizontal
    // lower contains up down, left right
    
    // sort by bounding box center
    final bounds1 = BoundingBoxGrouper.boundsFromLines([lines[0]]);
    final bounds2 = BoundingBoxGrouper.boundsFromLines([lines[1]]);

    Line upper = lines[0];
    Line lower = lines[1];
    if (bounds1.center.y > bounds2.center.y) {
      upper = lines[1];
      lower = lines[0];
    }

    // upper is horizontal
    if (!LineInspector.isHorizontalLine(upper)) return false;
    // lower contains up down, left right
    final strokes = StrokeCutter.cutByHorizontalDirectionChange(lower.points);
    if (strokes.length != 2) return false;

    return LineInspector.isDescendingLine(Line(strokes[0])) &&
        LineInspector.isDirectionLeft(strokes[0]) &&
        LineInspector.isDirectionRight(strokes[1]);

    // return true;
    // return true;
  }

  String _detectCarolingianMinisculeLetter(List<Line> lines) {
    if (isT(lines)) return 'T';
    if (isZ(lines)) return 'Z';

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
      buffer.write(_detectCarolingianMinisculeLetter(groupLines));
    }

    return buffer.toString();
  }
}
