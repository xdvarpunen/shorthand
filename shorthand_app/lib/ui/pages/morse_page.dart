import 'package:flutter/material.dart';
import 'package:shorthand_app/processors/morse_code_processor_service.dart';
import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

class MorsePage extends StatefulWidget {
  const MorsePage({super.key});

  @override
  State<MorsePage> createState() => _MorsePageState();
}

class _MorsePageState extends State<MorsePage> {
  final PointsManager _pointsManager = PointsManager();

  @override
  Widget build(BuildContext context) {
    return CanvasTemplatePage(
      title: 'Morse Page',
      onClear: _pointsManager.reset,
      canvas: BasePaintCanvas(
        backgroundColor: Colors.grey,
        processor: MorseCodeProcessorService(),
        showSinglePointCircle: true,
        pointsManager: _pointsManager,
      ),
    );
  }
}
