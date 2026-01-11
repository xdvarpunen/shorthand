import 'package:shorthand_app/engine/point.dart';

class IsSingleLine {
  bool hasLines(List<List<Point>> lines) {
    return lines.isEmpty;
  }

  bool hasSingleLine(List<List<Point>> lines) {
    return lines.length == 1;
  }

  List<Point>? getSingleLine(List<List<Point>> lines) {
    if (hasLines(lines) && hasSingleLine(lines)) {
      final line = lines.first;
      if (line.length < 2) return null;
      return lines.first;
    }

    return null;
  }

  List<Point>? isLineLengthMoreThanOne(List<Point> line) {
    if (line.length < 2) return null;
    return line;
  }

  List<Point>? isLineLengthOne(List<Point> line) {
    if (line.length != 1) return null;
    return line;
  }

  bool hasMoreThanOneLine(List<List<Point>> lines) {
    return lines.length > 1;
  }

  bool hasNLines(List<List<Point>> lines, int count) {
    return lines.length == count;
  }

  bool hasMoreThanNLines(List<List<Point>> lines, int count) {
    return lines.length > count;
  }
}
