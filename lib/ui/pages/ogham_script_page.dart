// import 'package:flutter/material.dart';
// import 'package:shorthand_app/common/canvas_controller.dart';
// import 'package:shorthand_app/common/model/canvas_model.dart';
// import 'package:shorthand_app/common/model/immutable/canvas_controller.dart';
// import 'package:shorthand_app/common/model/line.dart';
// import 'package:shorthand_app/common/model/point.dart';
// import 'package:shorthand_app/ui/processors/ogham/ogham_processor.dart';
// import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
// import 'package:shorthand_app/ui/templates/canvas_template_page.dart';
// import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

// /// Modern Ogham Script Page
// class OghamScriptPage extends StatefulWidget {
//   const OghamScriptPage({super.key});

//   @override
//   State<OghamScriptPage> createState() => _OghamScriptPageState();
// }

// class _OghamScriptPageState extends State<OghamScriptPage> {
//   late final CanvasController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CanvasController(
//       textInterpreter: OghamProcessor(locationOfLine: 100, thicknessOfLine: 32),
//       processOnPointerUp: true,
//     );
//   }

//   void _resetCanvas() {
//     _controller.clear();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CanvasComplexTemplatePage(
//       title: 'Ogham Script ᚛ᚑᚌᚐᚋ᚜',
//       onClear: _resetCanvas,
//       onUndo: _controller.undo,
//       onRedo: _controller.redo,
//       canvas: PaintTypeNoProcessor(
//         backgroundColor: Colors.grey,
//         controller: _controller,
//         showSinglePointCircle: true,
//       ),
//     );
//   }
// }
