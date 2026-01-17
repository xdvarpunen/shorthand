
import 'package:shorthand_app/common/toolbox/inspectors/line_inspector.dart';
import 'package:shorthand_app/common/core/line_intersection_util.dart';

class Inspectors {
  final LineInspector lineInspector = LineInspector();
  final LineIntersectionUtil lineIntersectionUtil = LineIntersectionUtil();
}



// extension LinesPropertiesExtension on Lines2 {
//   bool hasLines() {
//     return lines.isEmpty == false;
//   }

//   bool hasSingleLine() {
//     return lines.length == 1;
//   }

//   Line2? getSingleLine() {
//     return hasLines() && hasSingleLine()
//         ? lines.first.isLineLengthMoreThanOne()
//         : null;
//   }

//   bool hasMoreThanOneLine() {
//     return lines.length > 1;
//   }

//   bool hasNLines(int count) {
//     return lines.length == count;
//   }

//   bool hasMoreThanNLines(int count) {
//     return lines.length > count;
//   }
// }
// // class Other{
  
// //   int totalPoints() => _lines.lines.fold(0, (sum, line) => sum + line.points.length);
// //   int totalLines() => _lines.lines.length;
// //   int totalLinesWithMoreThanOne() =>
// //       _lines.lines.where((line) => line.points.length > 1).length;
// // }
// //List<Line2> get allLines => List.unmodifiable(lines.lines);
// // int get totalPoints => lines.lines.fold(0, (sum, l) => sum + l.points.length);



// extension IntersectionWithLineExtension on Line2 {
//   bool intersectWith(Line2 line) {
//     return LineIntersectionUtil().linesIntersect(points, line.points);
//   }
// }

// extension LinePropertiesExtension on Line2 {
//   Line2? isLineLengthMoreThanOne() {
//     if (points.length < 2) return null;
//     return this;
//   }

//   Line2? isLineLengthOne() {
//     if (points.length != 1) return null;
//     return this;
//   }
// }

// extension LineTypeExtension on Line2 {
//   bool isDot() {
//     return points.length == 1;
//   }

//   bool isHorizontal() {
//     return Toolbox().inspectors.lineInspector.checkHorizontalLine(points);
//   }

//   bool isVertical() {
//     return Toolbox().inspectors.lineInspector.checkHorizontalLine(points);
//   }

//   // Check if the line is descending (y decreases as x increases)
//   bool isDescending() {
//     return points[0].y < points[points.length - 1].y;
//   }

//   // Check if the line is ascending (y increases as x increases)
//   bool isAscending() {
//     return points[0].y > points[points.length - 1].y;
//   }
// }

// // Define boundary between toolbox and model
// // Remove toolbox ones




// extension PointExtensions on Point {
//   // Vertical comparisons
//   bool isAbovePoint(Point other) => y > other.y;

//   bool isBelowPoint(Point other) => y < other.y;

//   // Horizontal comparisons
//   bool isRightPoint(Point other) => x > other.x;

//   bool isLeftPoint(Point other) => x < other.x;

//   // Diagonal comparisons
//   bool isAboveRightPoint(Point other) =>
//       isAbovePoint(other) && isRightPoint(other);

//   bool isBelowRightPoint(Point other) =>
//       isBelowPoint(other) && isRightPoint(other);

//   bool isAboveLeftPoint(Point other) =>
//       isAbovePoint(other) && isLeftPoint(other);

//   bool isBelowLeftPoint(Point other) =>
//       isBelowPoint(other) && isLeftPoint(other);

//   // -------------------
//   // Distance methods
//   // -------------------

//   /// Euclidean (straight-line) distance
//   double getDistanceToPoint(Point other) {
//     final dx = x - other.x;
//     final dy = y - other.y;
//     return sqrt(dx * dx + dy * dy);
//   }

//   /// True distance comparison
//   bool isDistanceToPoint(Point other, double minDistance) {
//     return getDistanceToPoint(other) >= minDistance;
//   }

//   /// Axis-based distance (matches original dx || dy logic)
//   bool isAxisDistanceToPoint(Point other, double minDistance) {
//     final dx = (x - other.x).abs();
//     final dy = (y - other.y).abs();
//     return dx >= minDistance || dy >= minDistance;
//   }
// }
