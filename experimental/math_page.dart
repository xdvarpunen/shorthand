
import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/processors/experimental/math/math_processor.dart';
import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

class MathPage extends StatefulWidget {
  const MathPage({super.key});

  @override
  State<MathPage> createState() => _MathPageState();
}

class _MathPageState extends State<MathPage> {
  final PointsManager _pointsManager = PointsManager();

  @override
  Widget build(BuildContext context) {
    return CanvasTemplatePage(
      title: 'Math',
      onClear: _pointsManager.reset,
      canvas: BasePaintCanvas(
        backgroundColor: Colors.grey,
        processor: MathProcessor(),
        showSinglePointCircle: false,
        pointsManager: _pointsManager,
      ),
    );
  }
}
