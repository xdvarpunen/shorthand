import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/line_inspector.dart';
import 'package:shorthand_app/toolbox/toolbox/inspectors/lines_intersection_check.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class CuneiformPage extends StatefulWidget {
  const CuneiformPage({super.key});

  @override
  State<CuneiformPage> createState() => _CuneiformPageState();
}

class _CuneiformPageState extends State<CuneiformPage> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = CuneiformLinesInterpreter();

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
      title: 'Cuneiform Page',
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
// world first recorded handwriting

// big dot ish is simply |_

// bounding box
// along line create rotated bounding box
// intersecting together
// form letter by center location

// ME horizontal left vertical right

// PA
// AN
// MA
// UD
// IZ

// bool isDiagonal(Line line) {
//   return Toolbox().inspectors.lineInspector.checkVerticalLine(line.points);
// }

// bool isTriangle(Line line){
//   //
// }
class CuneiformLinesInterpreter extends TextLinesInterpreter {
  bool isHorizontal(Line line) {
    return LineInspector.checkHorizontalLine(line.points);
  }

  bool isVertical(Line line) {
    return LineInspector.checkVerticalLine(line.points);
  }

  bool isEz(List<Line> lines) {
    // Find horizontal and vertical candidates
    final horizontals = lines.where(isHorizontal).toList();
    final verticals = lines.where(isVertical).toList();

    if (horizontals.length < 2 || verticals.isEmpty) return false;

    // Check if any vertical intersects with at least two horizontals
    for (final v in verticals) {
      int intersectCount = 0;
      for (final h in horizontals) {
        if (LineIntersectionUtil().linesIntersect(v.points, h.points)) {
          intersectCount++;
        }
      }
      if (intersectCount >= 2) {
        return true;
      }
    }
    return false;
  }

  @override
  String process(List<Line> lines) {
    if (isEz(lines)) {
      return "EZ";
    }
    return '';
  }
}
