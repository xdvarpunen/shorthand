// import 'package:shorthand_app/engine/line.dart';
// import 'package:shorthand_app/engine/point.dart';

// class PointsManager {
//   final List<Line> _lines = [];
//   int _nextLineId = 1;

//   Line startLine(Point point) {
//     final line = Line(id: _nextLineId++, points: [point]);
//     _lines.add(line);
//     return line;
//   }

//   void addPoint(Line line, Point point) {
//     line.addPoint(point);
//   }

//   void reset() {
//     _lines.clear();
//     _nextLineId = 1;
//   }

//   int totalPoints() => _lines.fold(0, (sum, line) => sum + line.points.length);
//   int totalLines() => _lines.length;
//   int totalLinesWithMoreThanOne() =>
//       _lines.where((line) => line.points.length > 1).length;

//   List<Line> get lines => List.unmodifiable(_lines);

//   List<List<Point>> toListOfListOfPoints() {
//     return _lines
//         .map((line) => line.points)
//         .toList();
//   }
// }
