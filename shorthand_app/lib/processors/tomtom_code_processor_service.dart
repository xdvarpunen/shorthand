import 'package:shorthand_app/canvas/canvas.dart';
import 'package:shorthand_app/encoderdecoder/tomtom_code_decoder.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class TomtomCodeProcessorService extends CanvasProcessor {
  final LineUtil _lineUtil = LineUtil();
  final TomtomCodeDecoder _tomtomCodeDecoder = TomtomCodeDecoder();

  // Convert lines to symbols (ascending, descending, space)
  List<LineType> linesToSymbols(List<List<Point>> lines) {
    List<LineType> symbols = [];
    for (var line in lines) {
      if (_lineUtil.checkHorizontalLine(line)) {
        symbols.add(LineType.space);
      } else if (_lineUtil.checkVerticalLine(line)) {
        if (_lineUtil.isAscending(line)) {
          symbols.add(LineType.ascending);
        } else if (_lineUtil.isDescending(line)) {
          symbols.add(LineType.descending);
        }
      }
    }
    return symbols;
  }

  @override
  String getOutput(PointsManager pointsManager) {
    final List<List<Point>> lines = pointsManager.lines
        .map<List<Point>>((line) => line.points)
        .toList();
    final symbols = linesToSymbols(lines);
    return "Text: ${_tomtomCodeDecoder.interpret(symbols)}";
  }
}
