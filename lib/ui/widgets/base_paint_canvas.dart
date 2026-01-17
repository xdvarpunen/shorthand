// import 'package:flutter/material.dart';
// import 'package:shorthand_app/common/model/line.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/point_manager.dart';
// import 'package:shorthand_app/ui/widgets/canvas/canvas_painter.dart';
// import 'package:shorthand_app/common/canvas_processor.dart';
// import 'package:shorthand_app/common/model/point.dart';
// import 'package:shorthand_app/ui/widgets/canvas/canvas_state.dart';

// class BasePaintCanvas extends StatefulWidget {
//   final Color backgroundColor;
//   final CanvasProcessor? processor;
//   final bool showSinglePointCircle;
//   final PointsManager? pointsManager;

//   final bool processOnPointerUp;

//   /// The external canvas state (optional)
//   /// use for background or placeholder
//   final CanvasState? initialState;

//   const BasePaintCanvas({
//     super.key,
//     required this.backgroundColor,
//     this.processor,
//     this.showSinglePointCircle = false,
//     this.pointsManager,
//     this.processOnPointerUp = false,
//     this.initialState,
//   });

//   @override
//   BasePaintCanvasState createState() => BasePaintCanvasState();
// }

// class BasePaintCanvasState extends State<BasePaintCanvas> {
//   late PointsManager _pointsManager;
//   // int? _currentLineIndex;
//   Line2? _currentLine;
//   late CanvasState _canvasState;

//   @override
//   void initState() {
//     super.initState();
//     _pointsManager = widget.pointsManager ?? PointsManager(Lines2([]));
//     _canvasState =
//         widget.initialState ??
//         CanvasState(pointsManager: _pointsManager, outputText: '');
//   }

//   void _startDrawing(Offset pos) {
//     setState(() {      
//       final newLine = Line2([Point(pos.dx, pos.dy)]);
//       _pointsManager = _pointsManager.addLine(newLine);
//       _currentLine = newLine;

//       if (!widget.processOnPointerUp && widget.processor != null) {
//         _updateOutput();
//       }
//     });
//   }

//   void _updateOutput() {
//     final output = widget.processor!.process(_pointsManager.lines);
//     _canvasState = CanvasState(
//       pointsManager: _pointsManager,
//       outputText: output,
//     );
//   }

//   void _draw(Offset pos) {
//     if (_currentLine == null) return;
//     setState(() {
//       _pointsManager = _pointsManager.addPoint(_currentLine!, Point(pos.dx, pos.dy));

//       if (!widget.processOnPointerUp && widget.processor != null) {
//         _updateOutput();
//       }
//     });
//   }

//    void _stopDrawing() {
//     setState(() {
//       _currentLine = null;

//       if (widget.processOnPointerUp && widget.processor != null) {
//         _updateOutput();
//       }
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: widget.backgroundColor,
//       child: GestureDetector(
//         onPanStart: (details) => _startDrawing(details.localPosition),
//         onPanUpdate: (details) => _draw(details.localPosition),
//         onPanEnd: (_) => _stopDrawing(),
//         child: CustomPaint(
//           painter: CanvasPainter(
//             drawState: _canvasState,
//             showSinglePointCircle: widget.showSinglePointCircle,
//           ),
//           size: Size.infinite,
//         ),
//       ),
//     );
//   }
// }
