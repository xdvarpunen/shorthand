// import 'package:shorthand_app/engine/point.dart';
// import 'package:shorthand_app/engine/point_manager.dart';
// import 'package:shorthand_app/new/stroke_direction.dart';
// import 'package:shorthand_app/new/stroke_util.dart';

// class ElderFurthakProcessor {
//   bool isUruz() {
//     final pointsManager = PointsManager();

//     // Start a new line (stroke)
//     final line = pointsManager.startLine(Point(100, 400));
//     pointsManager.addPoint(line, Point(100, 100));
//     pointsManager.addPoint(line, Point(300, 400));

//     // Cut the line by vertical direction change
//     final segments = StrokeCutter.cutByVerticalDirectionChange(line.points);

//     final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
//       segments[0],
//     );

//     final secondSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
//       segments[1],
//     );

//     final secondSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
//       segments[1],
//     );

//     // print('This is Uruz (ᚢ)');

//     return firstSegmentIsDirectionUp &&
//         secondSegmentIsDirectionDown &&
//         secondSegmentIsDirectionRight;
//   }
  
//   @override
//   String getOutput(PointsManager pointsManager) {
//     final List<List<Point>> lines = pointsManager.lines
//         .map<List<Point>>((line) => line.points)
//         .toList();
//     List<LineType> symbols = linesToSymbols(lines);
//     String entry = _morseCodeDecoder.decode(symbols);
//     return 'Count: $entry';
//   }
// }
