import 'package:flutter/material.dart';
import 'package:shorthand_app/common/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/ui/processors/morse_code_processor_service.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

// import 'package:flutter/material.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/point_manager.dart';
// import 'package:shorthand_app/ui/processors/morse_code_processor_service.dart';
// import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
// import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

// class MorsePage extends StatefulWidget {
//   const MorsePage({super.key});

//   @override
//   State<MorsePage> createState() => _MorsePageState();
// }

// class _MorsePageState extends State<MorsePage> {
//   final PointsManager _pointsManager = PointsManager(Lines2([]));

//   @override
//   Widget build(BuildContext context) {
//     return CanvasTemplatePage(
//       title: 'Morse Page',
//       onClear: _pointsManager.reset,
//       canvas: BasePaintCanvas(
//         backgroundColor: Colors.grey,
//         processor: MorseCodeProcessorService(),
//         showSinglePointCircle: true,
//         pointsManager: _pointsManager,
//       ),
//     );
//   }
// }

class MorsePage extends StatefulWidget {
  const MorsePage({super.key});

  @override
  State<MorsePage> createState() => _MorsePageState();
}

class _MorsePageState extends State<MorsePage> {
  late final CanvasController _controller;
  final LinesInterpreter<String> interpreter = MorseLinesInterpreter();

  @override
  void initState() {
    super.initState();
    _controller = CanvasController(
      interpreter: interpreter,
      processOnPointerUp: true, // process after each line
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
      title: 'Morse Page',
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
