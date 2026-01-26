import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/core/line_intersection_util.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/toolbox/filters/minimum_distance_filter.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

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

// class PowerSymbolInterpreter extends ActionLinesInterpreter {
//   final VoidCallback turnOnOff;
//   final VoidCallback resetCanvas;

//   bool _alreadyTriggered = false;

//   PowerSymbolInterpreter({required this.turnOnOff, required this.resetCanvas});
//   final VoidCallback onTrigger;
//   bool _alreadyTriggered = false;

//   PowerSymbolInterpreter({required this.onTrigger});

//   @override
//   void process(List<Line> lines) {
//     if (_alreadyTriggered || lines.length != 2) return;

//     if (_matchesPowerSymbol(lines)) {
//       _alreadyTriggered = true;
//       onTrigger();
//     }
//   }

//   void resetTrigger() => _alreadyTriggered = false;
//   @override
//   void process(List<Line> lines) {
//     if (_alreadyTriggered) return;
//     if (lines.length != 2) return;

//     final line1 = lines[0];
//     final line2 = lines[1];

//     final bool linesDontIntersect = !LineIntersectionUtil.linesIntersect(
//       line1.points,
//       line2.points,
//     );

//     final bool endLinesIntersect = LineIntersectionUtil.linesIntersect(
//       [line1.points.first, line1.points.last],
//       [line2.points.first, line2.points.last],
//     );

//     if (linesDontIntersect && endLinesIntersect) {
//       _alreadyTriggered = true;
//       turnOnOff();
//       resetCanvas();
//     }
//   }

//   void resetTrigger() {
//     _alreadyTriggered = false;
//   }
// }
class PowerSymbolInterpreter extends ActionLinesInterpreter {
  final VoidCallback onTrigger;
  bool _alreadyTriggered = false;

  PowerSymbolInterpreter({required this.onTrigger});

  @override
  void process(List<Line> lines) {
    // print('PowerSymbol process called: ${lines.length} lines');
    if (_alreadyTriggered || lines.length != 2) return;

    final line1 = MinimumDistanceFilter.reducePoints(lines[0].points, 10);
    final line2 = MinimumDistanceFilter.reducePoints(lines[1].points, 10);

    // final bool linesDontIntersect = !LineIntersectionUtil.linesIntersect(
    //   line1,
    //   line2,
    // );

    final bool endLinesIntersect = LineIntersectionUtil.linesIntersect(
      [line1.first, line1.last],
      [line2.first, line2.last],
    );

    // if (linesDontIntersect && endLinesIntersect) {
    //   _alreadyTriggered = true;
    //   onTrigger();
    // }
    if (endLinesIntersect) {
      _alreadyTriggered = true;
      onTrigger();
    }
  }

  void resetTrigger() {
    _alreadyTriggered = false;
  }
}

class PowerSymbolPage extends StatefulWidget {
  const PowerSymbolPage({super.key});

  @override
  State<PowerSymbolPage> createState() => _PowerSymbolPageState();
}

// class _PowerSymbolPageState extends State<PowerSymbolPage> {
//   late final CanvasController _controller;
//   late final PowerSymbolInterpreter _interpreter;

//   bool isPowerOn = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller = CanvasController(processOnPointerUp: true);

//     _interpreter = PowerSymbolInterpreter(
//       turnOnOff: _togglePower,
//       resetCanvas: _resetCanvas,
//     );

//     _controller.setActionInterpreter(_interpreter);
//   }

//   void _togglePower() {
//     setState(() => isPowerOn = !isPowerOn);

//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(
//           content: Text(isPowerOn ? 'Power On!' : 'Power Off!'),
//           duration: const Duration(seconds: 1),
//         ),
//       );
//   }

//   void _resetCanvas() {
//     _controller.clear();
//     _interpreter.resetTrigger();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CanvasComplexTemplatePage(
//       title: 'Power Symbol Page',
//       onClear: _resetCanvas,
//       canvas: PaintTypeNoProcessor(
//         backgroundColor: Colors.grey,
//         controller: _controller,
//       ),
//     );
//   }
// }
class _PowerSymbolPageState extends State<PowerSymbolPage> {
  late final CanvasController _controller;
  late final PowerSymbolInterpreter _interpreter;

  bool isPowerOn = false;

  @override
  void initState() {
    super.initState();

    _interpreter = PowerSymbolInterpreter(onTrigger: _onPowerSymbolDetected);
    _controller = CanvasController(
      processOnPointerUp: true,
      actionInterpreter: _interpreter,
    );

    _controller.setActionInterpreter(_interpreter);
  }

  void _onPowerSymbolDetected() {
    setState(() => isPowerOn = !isPowerOn);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(isPowerOn ? 'Power On!' : 'Power Off!'),
          duration: const Duration(seconds: 1),
        ),
      );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.clear();
      _interpreter.resetTrigger();
    });
  }

  void _resetCanvas() {
    _controller.clear();
    _interpreter.resetTrigger();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CanvasComplexTemplatePage(
      title: 'Power Symbol Page',
      onClear: _resetCanvas,
      canvas: PaintTypeNoProcessor(
        backgroundColor: Colors.grey,
        controller: _controller,
      ),
    );
  }
}
