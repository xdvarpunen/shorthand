import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/toolbox/toolbox.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class FrendsLogoPage extends StatefulWidget {
  const FrendsLogoPage({super.key});

  @override
  State<FrendsLogoPage> createState() => _FrendsLogoPageState();
}

class _FrendsLogoPageState extends State<FrendsLogoPage> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = FrendsLogoLinesInterpreter();

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
      title: 'Frends Logo Page',
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

// 3 lines
// self intersecting
// line
// line
// one left of two bounding boxes
// one top of two bounding boxes

class FrendsLogoLinesInterpreter extends TextLinesInterpreter {
  bool isHorizontal(Line line) {
    return Toolbox().inspectors.lineInspector.checkHorizontalLine(line.points);
  }

  bool isVertical(Line line) {
    return Toolbox().inspectors.lineInspector.checkVerticalLine(line.points);
  }

  bool isFrendsLogo(List<Line> lines) {
    if (lines.length != 3) return false;

    // Compute bounding boxes
    List<Rect> boundingBoxes = lines.map((line) {
      double minX = line.points.map((p) => p.x).reduce((a, b) => a < b ? a : b);
      double maxX = line.points.map((p) => p.x).reduce((a, b) => a > b ? a : b);
      double minY = line.points.map((p) => p.y).reduce((a, b) => a < b ? a : b);
      double maxY = line.points.map((p) => p.y).reduce((a, b) => a > b ? a : b);
      return Rect.fromLTRB(minX, minY, maxX, maxY);
    }).toList();

    // Compute center points for each bounding box
    List<Offset> centers = boundingBoxes
        .map((r) => Offset((r.left + r.right) / 2, (r.top + r.bottom) / 2))
        .toList();

    // Sort by vertical position (y)
    List<int> sortedIndices = [0, 1, 2];
    sortedIndices.sort((a, b) => centers[a].dy.compareTo(centers[b].dy));

    final topIdx = sortedIndices[0];
    final middleIdx = sortedIndices[1];
    final bottomIdx = sortedIndices[2];

    final top = centers[topIdx];
    final middle = centers[middleIdx];
    final bottom = centers[bottomIdx];

    return top.dx > middle.dx && top.dx < bottom.dx;
  }

  @override
  String process(List<Line> lines) {
    if (isFrendsLogo(lines)) {
      return "Yes is logo";
    }
    return 'No is not logo';
  }
}
