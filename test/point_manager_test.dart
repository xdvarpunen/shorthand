import 'package:flutter_test/flutter_test.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

void main() {
  group('PointsManager', () {
    test('startLine should create a new line and add a point', () {
      // Arrange
      final pointsManager = PointsManager();
      final point = Point(1, 1);

      // Act
      final line = pointsManager.startLine(point);

      // Assert
      expect(line.id, 1); // The first line should have id 1
      expect(line.points.length, 1); // Line should have 1 point
      expect(line.points[0], point); // The point added should be the one we passed
    });

    test('addPoint should add a point to an existing line', () {
      // Arrange
      final pointsManager = PointsManager();
      final line = pointsManager.startLine(Point(1, 1)); // Start with one point
      final newPoint = Point(2, 2);

      // Act
      pointsManager.addPoint(line, newPoint);

      // Assert
      expect(line.points.length, 2); // Line should have 2 points
      expect(line.points[1], newPoint); // The new point should be added
    });

    test('reset should clear all lines and reset nextLineId', () {
      // Arrange
      final pointsManager = PointsManager();
      pointsManager.startLine(Point(1, 1));
      pointsManager.startLine(Point(2, 2));

      // Act
      pointsManager.reset();

      // Assert
      expect(pointsManager.totalLines(), 0); // No lines should exist
      expect(pointsManager.totalPoints(), 0); // No points should exist
      expect(pointsManager.lines.isEmpty, true); // List of lines should be empty
    });

    test('totalPoints should return the correct total number of points', () {
      // Arrange
      final pointsManager = PointsManager();
      final line1 = pointsManager.startLine(Point(1, 1));
      pointsManager.addPoint(line1, Point(2, 2));

      // Act
      final totalPoints = pointsManager.totalPoints();

      // Assert
      expect(totalPoints, 2);
    });

    test('totalLines should return the correct total number of lines', () {
      // Arrange
      final pointsManager = PointsManager();
      pointsManager.startLine(Point(1, 1));
      pointsManager.startLine(Point(2, 2));

      // Act
      final totalLines = pointsManager.totalLines();

      // Assert
      expect(totalLines, 2); // There should be 2 lines
    });

    test('totalLinesWithMoreThanOne should return the correct number of lines', () {
      // Arrange
      final pointsManager = PointsManager();
      final line1 = pointsManager.startLine(Point(1, 1));
      pointsManager.addPoint(line1, Point(2, 2)); // Line with 2 points

      // Act
      final totalLinesWithMoreThanOne = pointsManager.totalLinesWithMoreThanOne();

      // Assert
      expect(totalLinesWithMoreThanOne, 1); // Only line1 has more than 1 point
    });

    test('lines should return an unmodifiable list of lines', () {
      // Arrange
      final pointsManager = PointsManager();
      final line = pointsManager.startLine(Point(1, 1));

      // Act & Assert
      expect(() => pointsManager.lines.add(line), throwsUnsupportedError); // Should throw an error since it's unmodifiable
    });
  });
}
