
import 'package:flutter/material.dart';
import 'package:shorthand_app/canvas/base_paint_canvas.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/slavic/glagolitic_processor.dart';
import 'package:shorthand_app/pages/templates/canvas_template_page.dart';

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
