// import 'package:flutter/material.dart';
// import 'package:shorthand_app/common/canvas_processor.dart';
// import 'package:shorthand_app/common/model/line.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/point_manager.dart';
// import 'package:shorthand_app/common/toolbox/toolbox.dart';
// import 'package:shorthand_app/common/model/point.dart';
// import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';
// import 'package:shorthand_app/ui/templates/canvas_template_page.dart';

// // https://www.moma.org/collection/works/188563

// // bash, zsh, powershell... invocation shell!
// // I mean you know those codes that are shaped into things...
// // yea...

// class PowerSymbolPage extends StatefulWidget {
//   const PowerSymbolPage({super.key});

//   @override
//   State<PowerSymbolPage> createState() => _PowerSymbolPageState();
// }

// class _PowerSymbolPageState extends State<PowerSymbolPage> {
//   final PointsManager _pointsManager = PointsManager(Lines2([]));
//   late final PowerSymbolProcessorService _processor;

//   bool isPowerOn = false;

//   @override
//   void initState() {
//     super.initState();

//     _processor = PowerSymbolProcessorService(
//       turnOnOff: turnOnOff,
//       resetPoints: resetPoints,
//     );
//   }

//   void callSnackbar(String message) {
//     if (!mounted) return;

//     final messenger = ScaffoldMessenger.of(context);
//     messenger
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
//       );
//   }

//   void turnOnOff() {
//     if (!mounted) return;

//     setState(() {
//       isPowerOn = !isPowerOn;
//     });

//     callSnackbar(isPowerOn ? 'Power On!' : 'Power Off!');
//   }

//   void resetPoints() {
//     _pointsManager.reset();
//     _processor.resetTrigger();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CanvasTemplatePage(
//       title: 'Power Symbol Page',
//       onClear: _pointsManager.reset,
//       canvas: BasePaintCanvas(
//         backgroundColor: Colors.grey,
//         processor: PowerSymbolProcessorService(
//           turnOnOff: turnOnOff,
//           resetPoints: _pointsManager.reset,
//         ),
//         showSinglePointCircle: true,
//         pointsManager: _pointsManager,
//       ),
//     );
//   }
// }

// class PowerSymbolProcessorService extends CanvasProcessor {
//   final void Function() turnOnOff;
//   final VoidCallback resetPoints;

//   bool _alreadyTriggered = false;

//   PowerSymbolProcessorService({
//     required this.turnOnOff,
//     required this.resetPoints,
//   });

//   @override
//   String process(Lines2 lines2) {
//     if (_alreadyTriggered) return '';
//     if (!lines2.hasNLines(2)) return "";

//     final Line2 line1 = lines2.lines.first;
//     final Line2 line2 = lines2.lines.last;

//     final Toolbox toolbox = Toolbox();

//     final bool linesDontIntersect = toolbox.inspectors.lineIntersectionUtil
//         .linesIntersect(line1.points, line2.points);
//     final bool endLinesDoIntersect = toolbox.inspectors.lineIntersectionUtil
//         .linesIntersect(
//           <Point>[line1.points.first, line1.points.last],
//           <Point>[line2.points.first, line2.points.last],
//         );

//     if (linesDontIntersect && endLinesDoIntersect) {
//       _alreadyTriggered = true;
//       turnOnOff();
//       resetPoints();
//     }
//     return '';
//   }

//   void resetTrigger() {
//     _alreadyTriggered = false;
//   }
// }
