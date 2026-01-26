import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/toolbox/toolbox.dart';
import 'package:shorthand_app/ui/pages/tomtom_code/tomtom_code_decoder.dart';

class TomtomCodeLinesInterpreter implements TextLinesInterpreter {
  final TomtomCodeDecoder _decoder;

  TomtomCodeLinesInterpreter({TomtomCodeDecoder? decoder})
    : _decoder = decoder ?? TomtomCodeDecoder();
  bool isHorizontal(Line line) {
    return Toolbox().inspectors.lineInspector.checkHorizontalLine(line.points);
  }

  bool isVertical(Line line) {
    return Toolbox().inspectors.lineInspector.checkVerticalLine(line.points);
  }

  bool isDescending(Line line) {
    return line.points[0].y < line.points[line.points.length - 1].y;
  }

  bool isAscending(Line line) {
    return line.points[0].y > line.points[line.points.length - 1].y;
  }

  List<LineType> linesToSymbols(List<Line> lines) {
    List<LineType> symbols = [];
    for (var line in lines) {
      if (isHorizontal(line)) {
        symbols.add(LineType.space);
      } else if (isVertical(line)) {
        if (isAscending(line)) {
          symbols.add(LineType.ascending);
        } else if (isDescending(line)) {
          symbols.add(LineType.descending);
        }
      }
    }
    return symbols;
  }

  @override
  String process(List<Line> lines) =>
      "Text: ${_decoder.interpret(linesToSymbols(lines))}";
}
