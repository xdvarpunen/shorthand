import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class TallyMarksFiveProcessorService extends CanvasProcessor {
  @override
  String getOutput(PointsManager pointsManager) {
    return 'Count: ${pointsManager.totalLinesWithMoreThanOne()}';
  }
}
