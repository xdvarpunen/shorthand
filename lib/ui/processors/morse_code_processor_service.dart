import 'package:shorthand_app/common/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/common/model/line.dart';
import 'package:shorthand_app/common/toolbox/toolbox.dart';
import 'package:shorthand_app/ui/processors/encoderdecoder/morse_code_decoder.dart';

class MorseLinesInterpreter implements TextLinesInterpreter {
  final MorseCodeDecoder _decoder;

  MorseLinesInterpreter({MorseCodeDecoder? decoder})
    : _decoder = decoder ?? MorseCodeDecoder();

  bool isDot(Line line) {
    return line.points.length == 1;
  }

  bool isHorizontal(Line line) {
    return Toolbox().inspectors.lineInspector.checkHorizontalLine(line.points);
  }

  bool isVertical(Line line) {
    return Toolbox().inspectors.lineInspector.checkVerticalLine(line.points);
  }

  LineType _classify(Line line) {
    if (isDot(line)) return LineType.dot;
    if (isHorizontal(line)) return LineType.horizontal;
    if (isVertical(line)) return LineType.vertical;
    return LineType.ignored;
  }

  List<LineType> _linesToSymbols(List<Line> lines) =>
      lines.map(_classify).where((t) => t != LineType.ignored).toList();

  @override
  String process(List<Line> lines) {
    final symbols = _linesToSymbols(lines);
    return _decoder.decode(symbols);
  }
}
