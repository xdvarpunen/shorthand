import 'package:flutter_test/flutter_test.dart';

// Your service class and the PointsManager class
class TallyMarksFiveProcessorService {
  String getOutput(PointsManager pointsManager) {
    return 'Count: ${pointsManager.totalLinesWithMoreThanOne()}';
  }
}

class PointsManager {
  final List<List<int>> points;

  PointsManager(this.points);

  // Method to count lines with more than one point
  int totalLinesWithMoreThanOne() {
    return points.where((line) => line.length > 1).toList().length;
  }
}

void main() {
  group('TallyMarksFiveProcessorService', () {
    test('getOutput should return the correct count', () {
      // Create an instance of PointsManager with test data
      final pointsManager = PointsManager([
        [1, 2], // Line with two points
        [1],    // Line with one point
        [2, 3], // Line with two points
        [4]     // Line with one point
      ]);

      final processor = TallyMarksFiveProcessorService();

      // Call getOutput and check if it matches the expected output
      expect(processor.getOutput(pointsManager), 'Count: 2');
    });

    test('getOutput should return 0 when no lines with more than one point', () {
      final pointsManager = PointsManager([
        [1], // Line with one point
        [2], // Line with one point
        [3], // Line with one point
      ]);

      final processor = TallyMarksFiveProcessorService();

      // Test for 0 lines with more than one point
      expect(processor.getOutput(pointsManager), 'Count: 0');
    });
  });
}
