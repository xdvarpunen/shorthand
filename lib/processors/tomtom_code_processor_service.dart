import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/common/model/line.dart';
import 'package:shorthand_app/common/model/lines.dart';
import 'package:shorthand_app/processors/encoderdecoder/tomtom_code_decoder.dart';

class TomtomCodeProcessorService extends CanvasProcessor {
  List<LineType> linesToSymbols(Lines2 lines2) {
    List<LineType> symbols = [];
    for (var line in lines2.lines) {
      if (line.isHorizontal()) {
        symbols.add(LineType.space);
      } else if (line.isVertical()) {
        if (line.isAscending()) {
          symbols.add(LineType.ascending);
        } else if (line.isDescending()) {
          symbols.add(LineType.descending);
        }
      }
    }
    return symbols;
  }

  @override
  String process(Lines2 lines2) => "Text: ${TomtomCodeDecoder().interpret(linesToSymbols(lines2))}";
}
