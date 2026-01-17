import 'package:shorthand_app/common/model/point.dart';

class IntersectingLineGrouper {
  // Helper method to check if two lines intersect
  bool linesIntersect(List<Point> line1, List<Point> line2) {
    final p1 = line1[0], p2 = line1[line1.length - 1];
    final p3 = line2[0], p4 = line2[line2.length - 1];

    final d1 = direction(p3, p4, p1);
    final d2 = direction(p3, p4, p2);
    final d3 = direction(p1, p2, p3);
    final d4 = direction(p1, p2, p4);

    if (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
        ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))) {
      return true;
    }

    if (d1 == 0 && onSegment(p3, p4, p1)) return true;
    if (d2 == 0 && onSegment(p3, p4, p2)) return true;
    if (d3 == 0 && onSegment(p1, p2, p3)) return true;
    if (d4 == 0 && onSegment(p1, p2, p4)) return true;

    return false;
  }

  // Direction calculation for line intersection
  double direction(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
  }

  // Check if point C lies on the segment AB
  bool onSegment(Point a, Point b, Point c) {
    return (c.x >= a.x && c.x <= b.x || c.x >= b.x && c.x <= a.x) &&
        (c.y >= a.y && c.y <= b.y || c.y >= b.y && c.y <= a.y);
  }

  List<List<List<Point>>> groupIntersectingLines(List<List<Point>> lines) {
    List<List<List<Point>>> groups = <List<List<Point>>>[];
    Set<List<Point>> visited = <List<Point>>{};

    // Helper function for DFS to group lines
    void dfs(List<Point> line, List<List<Point>> group) {
      visited.add(line);
      group.add(line);

      for (var currentLine in lines) {
        if (!visited.contains(currentLine) &&
            linesIntersect(line, currentLine)) {
          dfs(currentLine, group);
        }
      }
    }

    // Iterate over each line to find groups
    for (var currentLine in lines) {
      if (!visited.contains(currentLine)) {
        List<List<Point>> group = <List<Point>>[];
        dfs(currentLine, group);
        groups.add(group);
      }
    }

    return groups;
  }
}
