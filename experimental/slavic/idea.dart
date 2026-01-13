import 'package:shorthand_app/engine/angle_inspector_final.dart';

class AngleRun {
  final LineDirection direction;
  final List<AngleSegment> segments;

  AngleRun(this.direction, this.segments);

  double get totalAngle =>
      segments.fold(0.0, (s, seg) => s + seg.angle.abs());
}


extension LineAngleSplitX on LineAngle {
  List<AngleRun> splitByAngleChange({
    bool ignoreStraight = true,
  }) {
    final runs = <AngleRun>[];

    AngleRun? current;

    for (final seg in segments) {
      if (ignoreStraight && seg.isStraight) {
        continue;
      }

      if (current == null ||
          current.direction != seg.direction) {
        current = AngleRun(seg.direction, [seg]);
        runs.add(current);
      } else {
        current.segments.add(seg);
      }
    }

    return runs;
  }
}
