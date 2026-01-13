import 'package:flutter/material.dart';
import 'package:shorthand_app/processors/lao_maori_processor.dart';
import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

class ToolboxBasedPage extends StatefulWidget {
  const ToolboxBasedPage({super.key});

  @override
  State<ToolboxBasedPage> createState() => _ToolboxBasedPageState();
}

class _ToolboxBasedPageState extends State<ToolboxBasedPage> {
  final PointsManager _pointsManager = PointsManager();

  @override
  Widget build(BuildContext context) {
    return CanvasTemplatePage(
      title: 'Toolbox Based Page',
      onClear: _pointsManager.reset,
      canvas: BasePaintCanvas(
        backgroundColor: Colors.grey,
        processor: LaoMaoriProcessor(),
        showSinglePointCircle: false,
        pointsManager: _pointsManager,
      ),
    );
  }
}
