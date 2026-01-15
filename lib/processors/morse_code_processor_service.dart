import 'package:shorthand_app/common/model/line.dart';
import 'package:shorthand_app/common/model/lines.dart';
import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/processors/encoderdecoder/morse_code_decoder.dart';

class MorseCodeProcessorService extends CanvasProcessor {
  List<LineType> linesToSymbols(Lines2 lines) {
    List<LineType> symbols = [];

    for (var line in lines.lines) {
      if (line.isDot()) {
        symbols.add(LineType.dot);
      } else if (line.isHorizontal()) {
        symbols.add(LineType.horizontal);
      } else if (line.isVertical()) {
        symbols.add(LineType.vertical);
      }
    }

    return symbols;
  }

  @override
  String process(Lines2 lines2) {
    MorseCodeDecoder morseCodeDecoder = MorseCodeDecoder();
    String entry = morseCodeDecoder.decode(linesToSymbols(lines2));
    return 'Count: $entry';
  }
}
