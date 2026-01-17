import 'package:flutter/material.dart';
import 'package:shorthand_app/common/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class JustPaintPage extends StatefulWidget {
  const JustPaintPage({super.key});

  @override
  State<JustPaintPage> createState() => _JustPaintPageState();
}

class _JustPaintPageState extends State<JustPaintPage> {
  late final CanvasController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CanvasController();
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
      title: 'Just Paint Page',
      currentTool: _controller.state.tool,
      onClear: _controller.clear,
      onUndo: _controller.undo,
      onRedo: _controller.redo,
      onToggleTool: _controller.toggleTool,
      canvas: PaintTypeNoProcessor(
        backgroundColor: Colors.grey,
        controller: _controller,
      ),
    );
  }
}
