import 'package:flutter/material.dart';
import 'package:shorthand_app/processors/ogham/ogham_multi_letter_processor.dart';
import 'package:shorthand_app/ui/widgets/ogham_script_painter.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

class OghamScriptMultiLetterPage extends StatefulWidget {
  const OghamScriptMultiLetterPage({super.key});

  @override
  State<OghamScriptMultiLetterPage> createState() => _OghamScriptMultiLetterPageState();
}

class _OghamScriptMultiLetterPageState extends State<OghamScriptMultiLetterPage> {
  final PointsManager _pointsManager = PointsManager();

  @override
  Widget build(BuildContext context) {
    return CanvasTemplatePage(
      title: 'Ogham Script ᚛ᚑᚌᚐᚋ᚜',
      onClear: _pointsManager.reset,
      canvas: OghamScriptPaintCanvas(
        backgroundColor: Colors.grey,
        processor: OghamMultiLetterProcessor(100, 32),
        showSinglePointCircle: true,
        pointsManager: _pointsManager,
      ),
    );
  }
}
