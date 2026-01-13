
import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/processors/experimental/hangul/hangul_processor.dart';
import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

class HangulPage extends StatefulWidget {
  const HangulPage({super.key});

  @override
  State<HangulPage> createState() => _HangulPageState();
}

class _HangulPageState extends State<HangulPage> {
  final PointsManager _pointsManager = PointsManager();

  @override
  Widget build(BuildContext context) {
    return CanvasTemplatePage(
      title: 'Hangul Script',
      onClear: _pointsManager.reset,
      canvas: BasePaintCanvas(
        backgroundColor: Colors.grey,
        processor: HangulProcessor(),
        showSinglePointCircle: false,
        pointsManager: _pointsManager,
      ),
    );
  }
}
