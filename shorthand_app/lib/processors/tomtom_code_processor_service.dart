import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/common/model/lines.dart';
import 'package:shorthand_app/processors/encoderdecoder/tomtom_code_decoder.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';

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
  String process(Lines2 lines2) {
    final List<List<Point>> lines = lines2.toListOfListOfPoints();
    final symbols = linesToSymbols(lines);
    return "Text: ${_tomtomCodeDecoder.interpret(symbols)}";
  }
}
