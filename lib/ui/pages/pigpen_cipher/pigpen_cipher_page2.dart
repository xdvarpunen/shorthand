import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/copy/pigpen_cipher_processor%20copy.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class PigpenCipherPage2 extends StatefulWidget {
  const PigpenCipherPage2({super.key});

  @override
  State<PigpenCipherPage2> createState() => _PigpenCipherPage2State();
}

class _PigpenCipherPage2State extends State<PigpenCipherPage2> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = PigpenCipherProcessor2();

  @override
  void initState() {
    super.initState();
    _controller = CanvasController(
      textInterpreter: interpreter,
      processOnPointerUp: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CanvasComplexTemplatePage(
      title: 'Pigpen Cipher Page 2',
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