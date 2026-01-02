import 'package:shorthand_app/canvas/canvas.dart';
import 'package:shorthand_app/encoderdecoder/morse_code_decoder.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class MorseCodeProcessorService extends CanvasProcessor {
  final LineUtil _lineUtil = LineUtil();
  final MorseCodeDecoder _morseCodeDecoder = MorseCodeDecoder();

  List<LineType> linesToSymbols(List<List<Point>> lines) {
    List<LineType> symbols = [];

    for (var line in lines) {
      if (line.length == 1) {
        symbols.add(LineType.dot);
      } else if (_lineUtil.checkHorizontalLine(line)) {
        symbols.add(LineType.horizontal);
      } else if (_lineUtil.checkVerticalLine(line)) {
        symbols.add(LineType.vertical);
      }
    }
    return symbols;
  }

  @override
  String getOutput(PointsManager pointsManager) {
    final List<List<Point>> lines = pointsManager.lines
        .map<List<Point>>((line) => line.points)
        .toList();
    List<LineType> symbols = linesToSymbols(lines);
    String entry = _morseCodeDecoder.decode(symbols);
    return 'Count: $entry';
  }
}
