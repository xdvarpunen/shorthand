import 'package:shorthand_app/common/model/line.dart';
import 'package:shorthand_app/common/toolbox/toolbox.dart';
import 'package:shorthand_app/engine/point.dart';

class Lines2 {
  final List<Line2> lines;

  Lines2(this.lines);

  Lines2.fromListOfPoints(List<List<Point>> pointsList)
      : lines = pointsList.map((points) => Line2(points)).toList();

  List<List<Point>> toListOfListOfPoints() {
    return Toolbox().transformers.toListOfListOfPoints(lines);
  }
}

extension LinesPropertiesExtension on Lines2 {
  bool hasLines() {
    return lines.isEmpty;
  }

  bool hasSingleLine() {
    return lines.length == 1;
  }

  Line2? getSingleLine() {
    return hasLines() && hasSingleLine()
        ? lines.first.isLineLengthMoreThanOne()
        : null;
  }

  bool hasMoreThanOneLine() {
    return lines.length > 1;
  }

  bool hasNLines(int count) {
    return lines.length == count;
  }

  bool hasMoreThanNLines(int count) {
    return lines.length > count;
  }
}
