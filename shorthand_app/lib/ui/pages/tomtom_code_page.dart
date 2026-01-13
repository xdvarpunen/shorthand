import 'package:flutter/material.dart';
import 'package:shorthand_app/processors/tomtom_code_processor_service.dart';
import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

class TomtomCodePage extends StatefulWidget {
  const TomtomCodePage({super.key});

  @override
  State<TomtomCodePage> createState() => _TomtomCodePageState();
}

class _TomtomCodePageState extends State<TomtomCodePage> {
  final PointsManager _pointsManager = PointsManager();

  @override
  Widget build(BuildContext context) {
    return CanvasTemplatePage(
      title: 'Tomtom Code Page',
      onClear: _pointsManager.reset,
      canvas: BasePaintCanvas(
        backgroundColor: Colors.grey,
        processor: TomtomCodeProcessorService(),
        showSinglePointCircle: true,
        pointsManager: _pointsManager,
      ),
    );
  }
}
