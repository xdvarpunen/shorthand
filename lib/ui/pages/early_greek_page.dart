// import 'package:flutter/material.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/point_manager.dart';
// import 'package:shorthand_app/ui/processors/ogham/ogham_processor.dart';
// import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
// import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

// class EarlyGreekPage extends StatefulWidget {
//   const EarlyGreekPage({super.key});

//   @override
//   State<EarlyGreekPage> createState() => _EarlyGreekPageState();
// }

// class _EarlyGreekPageState extends State<EarlyGreekPage> {
//   final PointsManager _pointsManager = PointsManager(Lines2([]));

//   @override
//   Widget build(BuildContext context) {
//     return CanvasTemplatePage(
//       title: 'Early Greek',
//       onClear: _pointsManager.reset,
//       canvas: BasePaintCanvas(
//         backgroundColor: Colors.grey,
//         processor: OghamProcessor(100, 32),
//         showSinglePointCircle: true
//       ),
//     );
//   }
// }
