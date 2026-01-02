

import 'package:shorthand_app/canvas/canvas.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class TallyMarksFiveProcessorService extends CanvasProcessor {
  @override
  String getOutput(PointsManager pointsManager) {
    return 'Count: ${pointsManager.totalLinesWithMoreThanOne()}';
  }
}
