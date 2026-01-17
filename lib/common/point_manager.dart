// import 'package:shorthand_app/common/model/line.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/model/point.dart';

// class PointsManager {
//   final Lines2 lines;

//   PointsManager(Lines2? lines) : lines = lines ?? Lines2([]);

//   PointsManager addLine(Line2 line) {
//     return PointsManager(Lines2([...lines.lines, line]));
//   }

//   PointsManager addPoint(Line2 line, Point point) {
//     final updatedLines = lines.lines.map((l) {
//       if (l == line) return Line2([...l.points, point]);
//       return l;
//     }).toList();
//     return PointsManager(Lines2(updatedLines));
//   }

//   PointsManager reset() => PointsManager(Lines2([]));
// }
