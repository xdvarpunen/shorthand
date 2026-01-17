// import 'package:shorthand_app/common/model/line.dart';
// import 'package:shorthand_app/common/model/lines.dart';
// import 'package:shorthand_app/common/canvas_processor.dart';
// import 'package:shorthand_app/common/core/stroke_direction.dart';
// import 'package:shorthand_app/common/core/stroke_util.dart';
// import 'package:shorthand_app/ui/processors/encoderdecoder/morse_code_decoder.dart';

// class EarlyGreekProcessorService extends CanvasProcessor {
//   // bool isUruz(Lines2 lines) {
//   //   final line = lines.getSingleLine();

//   //   if (line != null && line.points.length < 2) return false;

//   //   // Cut the line by vertical direction change
//   //   final segments = StrokeCutter.cutByVerticalDirectionChange(line.points);

//   //   // Uruz requires at least two segments
//   //   if (segments.length < 2) return false;

//   //   final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
//   //     segments[0],
//   //   );

//   //   final firstSegmentIsDirectionUp = StrokeInspector.isDirectionUp(
//   //     segments[0],
//   //   );

//   //   final secondSegmentIsDirectionDown = StrokeInspector.isDirectionDown(
//   //     segments[1],
//   //   );

//   //   final secondSegmentIsDirectionRight = StrokeInspector.isDirectionRight(
//   //     segments[1],
//   //   );

//   //   return firstSegmentIsDirectionUp &&
//   //       secondSegmentIsDirectionDown &&
//   //       secondSegmentIsDirectionRight;
//   // }

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
