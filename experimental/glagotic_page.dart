
import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/processors/experimental/slavic/glagolitic_processor.dart';
import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

class GlagoticPage extends StatefulWidget {
  const GlagoticPage({super.key});

  @override
  State<GlagoticPage> createState() => _GlagoticPageState();
}

class _GlagoticPageState extends State<GlagoticPage> {
  final PointsManager _pointsManager = PointsManager();

  @override
  Widget build(BuildContext context) {
    return CanvasTemplatePage(
      title: 'Glagotic Script',
      onClear: _pointsManager.reset,
      canvas: BasePaintCanvas(
        backgroundColor: Colors.grey,
        processor: GlagoliticProcessor(),
        showSinglePointCircle: true,
        pointsManager: _pointsManager,
      ),
    );
  }
}
