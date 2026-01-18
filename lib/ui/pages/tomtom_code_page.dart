import 'package:flutter/material.dart';
import 'package:shorthand_app/common/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/ui/processors/tomtom_code_processor_service.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class TomtomCodePage extends StatefulWidget {
  const TomtomCodePage({super.key});

  @override
  State<TomtomCodePage> createState() => _TomtomCodePageState();
}

class _TomtomCodePageState extends State<TomtomCodePage> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = TomtomCodeLinesInterpreter();

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
      title: 'Tomtom Page',
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

// import 'package:flutter/material.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/point_manager.dart';
// import 'package:shorthand_app/ui/processors/tomtom_code_processor_service.dart';
// import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
// import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

// class TomtomCodePage extends StatefulWidget {
//   const TomtomCodePage({super.key});

//   @override
//   State<TomtomCodePage> createState() => _TomtomCodePageState();
// }

// class _TomtomCodePageState extends State<TomtomCodePage> {
//   final PointsManager _pointsManager = PointsManager(Lines2([]));

//   @override
//   Widget build(BuildContext context) {
//     return CanvasTemplatePage(
//       title: 'Tomtom Code Page',
//       onClear: _pointsManager.reset,
//       canvas: BasePaintCanvas(
//         backgroundColor: Colors.grey,
//         processor: TomtomCodeProcessorService(),
//         showSinglePointCircle: true,
//         pointsManager: _pointsManager,
//       ),
//     );
//   }
// }
