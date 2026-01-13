import 'package:shorthand_app/ui/widgets/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/PointsManagerToLinesList.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/processors/experimental/math/arithmetics.dart';
import 'package:shorthand_app/processors/experimental/math/constants.dart';
import 'package:shorthand_app/processors/experimental/math/numbers.dart';

class MathProcessor extends CanvasProcessor {
  String linesToSymbols(List<List<Point>> lines) {
    String symbols = "";

    for (var line in lines) {
      if (line.length < 2) return "";
      final constant = CheckConstant().isNeperConstant(line);
      if (constant != null) {
        symbols += constant;
      } else {
        final number = CheckNumber().isNumber(line);
        if (number != null) {
          symbols += number;
        } else {
          final arithmetic = CheckArithmetic().isMinusSign(line);
          if (arithmetic != null) {
            symbols += arithmetic;
          }
        }
      }
    }
    return symbols;
  }

  String process(List<List<Point>> lines) {
    return linesToSymbols(lines);
  }

  @override
  String getOutput(PointsManager pointsManager) {
    final List<List<Point>> lines = Pointsmanagertolineslist()
        .convertWithReducePointsByMinimumDistanceFilter(pointsManager);

    final entry = process(lines);
    final calc = computeStringExpression(entry);
    return 'Math: $entry\nResult:$calc';
  }
}

String computeStringExpression(String expression) {
  try {
    // Handle empty or single-number input
    if (expression.trim().isEmpty) return "";
    if (RegExp(r'^\s*[+-]?\d+(\.\d+)?\s*$').hasMatch(expression)) {
      return expression.trim();
    }

    // Remove all whitespace
    expression = expression.replaceAll(' ', '');

    // Tokenize: split into numbers and operators
    List<dynamic> tokens = [];
    String numBuffer = '';
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      if (RegExp(r'[0-9.]').hasMatch(char)) {
        numBuffer += char;
      } else {
        if (numBuffer.isNotEmpty) {
          tokens.add(double.parse(numBuffer));
          numBuffer = '';
        }
        tokens.add(char);
      }
    }
    if (numBuffer.isNotEmpty) {
      tokens.add(double.parse(numBuffer));
    }

    // First pass: process * and /
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == '*' || tokens[i] == '/') {
        final operator = tokens[i];
        final left = tokens[i - 1] as double;
        final right = tokens[i + 1] as double;
        double result;
        if (operator == '*') {
          result = left * right;
        } else {
          if (right == 0) return ""; // Division by zero
          result = left / right;
        }
        tokens.replaceRange(i - 1, i + 2, [result]);
        i--; // Adjust index after replacement
      }
    }

    // Second pass: process + and -
    double result = tokens[0] as double;
    for (int i = 1; i < tokens.length; i += 2) {
      final operator = tokens[i] as String;
      final nextValue = tokens[i + 1] as double;
      switch (operator) {
        case '+':
          result += nextValue;
          break;
        case '-':
          result -= nextValue;
          break;
        default:
          return ""; // Invalid operator
      }
    }

    // Return result as string, or empty if result is NaN or Infinity
    return result.isFinite ? result.toString() : "";
  } catch (e) {
    return "";
  }
}
