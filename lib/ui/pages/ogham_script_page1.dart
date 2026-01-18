// import 'package:flutter/material.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/point_manager.dart';
// import 'package:shorthand_app/ui/processors/ogham/ogham_processor.dart';
// import 'package:shorthand_app/ui/widgets/ogham_script_painter.dart';
// import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

// class OghamScriptPage extends StatefulWidget {
//   const OghamScriptPage({super.key});

//   @override
//   State<OghamScriptPage> createState() => _OghamScriptPageState();
// }

// class _OghamScriptPageState extends State<OghamScriptPage> {
//   final PointsManager _pointsManager = PointsManager(Lines2([]));

//   @override
//   Widget build(BuildContext context) {
//     return CanvasTemplatePage(
//       title: 'Ogham Script ᚛ᚑᚌᚐᚋ᚜',
//       onClear: _pointsManager.reset,
//       canvas: OghamScriptPaintCanvas(
//         backgroundColor: Colors.grey,
//         processor: OghamProcessor(100, 32),
//         showSinglePointCircle: true,
//         pointsManager: _pointsManager,
//       ),
//     );
//   }
// }
