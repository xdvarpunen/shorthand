import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class CalligraphyPage extends StatefulWidget {
  const CalligraphyPage({super.key});

  @override
  State<CalligraphyPage> createState() => _CalligraphyPageState();
}

class _CalligraphyPageState extends State<CalligraphyPage> {
  late final CanvasController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CanvasController(useCalligraphyPen: true);
    _controller.addListener(() {
      setState(() {}); // rebuild to update switch and other UI
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CanvasComplexTemplatePage(
      title: 'Calligraphy Page',
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
