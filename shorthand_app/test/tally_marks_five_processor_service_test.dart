import 'package:flutter_test/flutter_test.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/processors/tally_marks_five_processor_service.dart';

void main() {
  group('TallyMarksFiveProcessorService', () {
    test('getOutput should return the correct count', () {
      final pointsManager = PointsManager();

      // Line with more than one point
      final line1 = pointsManager.startLine(Point(0, 0));
      pointsManager.addPoint(line1, Point(1, 1));

      // Another line with more than one point
      final line2 = pointsManager.startLine(Point(2, 2));
      pointsManager.addPoint(line2, Point(3, 3));

      // Line with only one point
      pointsManager.startLine(Point(4, 4));

      final processor = TallyMarksFiveProcessorService();

      expect(processor.getOutput(pointsManager), 'Count: 2');
    });

    test('getOutput should return 0 when no lines with more than one point', () {
      final pointsManager = PointsManager();

      // Lines with only one point each
      pointsManager.startLine(Point(0, 0));
      pointsManager.startLine(Point(1, 1));

      final processor = TallyMarksFiveProcessorService();

      expect(processor.getOutput(pointsManager), 'Count: 0');
    });
  });
}
