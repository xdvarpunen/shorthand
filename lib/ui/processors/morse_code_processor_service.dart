import 'package:shorthand_app/common/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/common/model/line.dart';
import 'package:shorthand_app/common/toolbox/toolbox.dart';
import 'package:shorthand_app/ui/processors/encoderdecoder/morse_code_decoder.dart';

// import 'package:shorthand_app/common/model/line.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/canvas_processor.dart';
// import 'package:shorthand_app/ui/processors/encoderdecoder/morse_code_decoder.dart';

// class MorseCodeProcessorService extends CanvasProcessor {
//   List<LineType> linesToSymbols(Lines2 lines) {
//     List<LineType> symbols = [];

//     for (var line in lines.lines) {
//       if (line.isDot()) {
//         symbols.add(LineType.dot);
//       } else if (line.isHorizontal()) {
//         symbols.add(LineType.horizontal);
//       } else if (line.isVertical()) {
//         symbols.add(LineType.vertical);
//       }
//     }

//     return symbols;
//   }

//   @override
//   String process(Lines2 lines2) {
//     MorseCodeDecoder morseCodeDecoder = MorseCodeDecoder();
//     String entry = morseCodeDecoder.decode(linesToSymbols(lines2));
//     return 'Count: $entry';
//   }
// }
// import 'package:shorthand_app/common/model/line.dart';
// import 'package:shorthand_app/ui/processors/encoderdecoder/morse_code_decoder.dart';

// /// Domain-specific template for Morse code
// class MorseCodeTemplate {
//   /// Classify a line as dot, dash, or ignore
//   LineType classifyLine(Line line) {
//     if (line.isDot()) return LineType.dot;
//     if (line.isHorizontal()) return LineType.horizontal;
//     if (line.isVertical()) return LineType.vertical;
//     return LineType.ignored;
//   }

//   /// Convert raw lines into a sequence of symbols
//   List<LineType> linesToSymbols(List<Line> lines) {
//     return lines.map(classifyLine).where((t) => t != LineType.ignored).toList();
//   }
// }

// enum LineType { dot, horizontal, vertical, ignored }

// class MorseCodeInterpreter {
//   final MorseCodeTemplate template;

//   MorseCodeInterpreter({MorseCodeTemplate? template})
//       : template = template ?? MorseCodeTemplate();

//   /// Convert lines into a decoded Morse string
//   String interpret(List<Line> lines) {
//     final decoder = MorseCodeDecoder();
//     final symbols = template.linesToSymbols(lines);
//     return decoder.decode(symbols);
//   }
// }


// class MorseCodeLinesInterpreter extends LinesInterpreter<String> {
//   final MorseCodeInterpreter _interpreter;

//   MorseCodeLinesInterpreter({MorseCodeTemplate? template})
//       : _interpreter = MorseCodeInterpreter(template: template);

//   @override
//   String process(List<Line> lines) {

//     final decoder = MorseCodeDecoder();
//     final symbols = template.linesToSymbols(lines);
//     return decoder.decode(symbols);
//     return _interpreter.interpret(lines);
//   }
// }
// enum LineType { dot, horizontal, vertical, ignored }

/// Simplified Morse interpreter implementing LinesInterpreter
class MorseLinesInterpreter implements LinesInterpreter<String> {
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
    return Toolbox().inspectors.lineInspector.checkHorizontalLine(line.points);
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
