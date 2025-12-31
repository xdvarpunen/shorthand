import 'package:shorthand_app/point_manager.dart';

class TallyMarksFiveProcessorService {
  String getOutput(PointsManager pointsManager) {
    return 'Count: ${pointsManager.totalLinesWithMoreThanOne()}';
  }
}
