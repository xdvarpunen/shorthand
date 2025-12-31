import 'package:shorthand_app/point.dart';
import 'package:shorthand_app/point_manager.dart';

enum LineType {
  ascending,
  descending,
  space,
}

class TomtomCodeProcessorService {
  // Check if the line is vertical
  bool checkVerticalLine(List<Point> line) {
    if (line.isEmpty) {
      throw ArgumentError("Line should not be null or empty");
    }
    if (line.length < 2) {
      throw ArgumentError("Line should have at least two points");
    }
    final startPoint = line[0];
    final endPoint = line[line.length - 1];
    final width = (endPoint.x - startPoint.x).abs();
    final height = (endPoint.y - startPoint.y).abs();
    return width < height;
  }

  // Check if the line is horizontal
  bool checkHorizontalLine(List<Point> line) {
    if (line.isEmpty) {
      throw ArgumentError("Line should not be null or empty");
    }
    if (line.length < 2) {
      throw ArgumentError("Line should have at least two points");
    }
    final startPoint = line[0];
    final endPoint = line[line.length - 1];
    final width = (endPoint.x - startPoint.x).abs();
    final height = (endPoint.y - startPoint.y).abs();
    return width > height;
  }

  // Check if the line is descending (y decreases as x increases)
  bool isDescending(List<Point> line) {
    return line[0].y < line[line.length - 1].y;
  }

  // Check if the line is ascending (y increases as x increases)
  bool isAscending(List<Point> line) {
    return line[0].y > line[line.length - 1].y;
  }

  // Convert lines to symbols (ascending, descending, space)
  List<LineType> linesToSymbols(List<List<Point>> lines) {
    List<LineType> symbols = [];
    for (var line in lines) {
      if (checkHorizontalLine(line)) {
        symbols.add(LineType.space);
      } else if (checkVerticalLine(line)) {
        if (isAscending(line)) {
          symbols.add(LineType.ascending);
        } else if (isDescending(line)) {
          symbols.add(LineType.descending);
        }
      }
    }
    return symbols;
  }

  // Generate the comparison table
  Map<String, List<LineType>> generateComparisonTable() {
    return {
      "A": [LineType.ascending],
      "B": [LineType.ascending, LineType.ascending],
      "C": [LineType.ascending, LineType.ascending, LineType.ascending],
      "D": [LineType.ascending, LineType.ascending, LineType.ascending, LineType.ascending],
      "E": [LineType.ascending, LineType.descending],
      "F": [LineType.ascending, LineType.ascending, LineType.descending],
      "G": [LineType.ascending, LineType.ascending, LineType.ascending, LineType.descending],
      "H": [LineType.ascending, LineType.descending, LineType.descending],
      "I": [LineType.ascending, LineType.descending, LineType.descending, LineType.descending],
      "J": [LineType.descending, LineType.ascending],
      "K": [LineType.descending, LineType.descending, LineType.ascending],
      "L": [LineType.descending, LineType.descending, LineType.descending, LineType.ascending],
      "M": [LineType.descending, LineType.ascending, LineType.ascending],
      "N": [LineType.descending, LineType.ascending, LineType.ascending, LineType.ascending],
      "O": [LineType.ascending, LineType.descending, LineType.ascending],
      "P": [LineType.ascending, LineType.ascending, LineType.descending, LineType.ascending],
      "Q": [LineType.ascending, LineType.descending, LineType.descending, LineType.ascending],
      "R": [LineType.ascending, LineType.descending, LineType.ascending, LineType.ascending],
      "S": [LineType.descending, LineType.ascending, LineType.ascending],
      "T": [LineType.descending, LineType.descending, LineType.ascending, LineType.descending],
      "U": [LineType.descending, LineType.ascending, LineType.ascending, LineType.descending],
      "V": [LineType.descending, LineType.ascending, LineType.descending, LineType.descending],
      "W": [LineType.ascending, LineType.ascending, LineType.descending, LineType.descending],
      "X": [LineType.descending, LineType.descending, LineType.ascending, LineType.ascending],
      "Y": [LineType.descending, LineType.ascending, LineType.descending, LineType.ascending],
      "Z": [LineType.ascending, LineType.descending, LineType.ascending, LineType.descending],
    };
  }

  // Helper method to compare arrays
  bool arraysAreEqual(List<LineType> arr1, List<LineType> arr2) {
    if (arr1.length != arr2.length) return false;
    return List.generate(arr1.length, (i) => arr1[i] == arr2[i]).every((e) => e);
  }

  // Convert symbols to text using the comparison table
  String symbolsToText(List<LineType> symbols, Map<String, List<LineType>> comparisonTable) {
    String interpretedText = "";
    List<LineType> symbolGroup = [];

    for (int i = 0; i < symbols.length; i++) {
      var symbol = symbols[i];
      if (symbol != LineType.space) {
        symbolGroup.add(symbol);
      }

      if (symbol == LineType.space || i == symbols.length - 1) {
        if (symbolGroup.isNotEmpty) {
          comparisonTable.forEach((key, value) {
            if (arraysAreEqual(symbolGroup, value)) {
              interpretedText += key;
              return; // Exit the loop once the match is found
            }
          });
        }
        symbolGroup.clear();

        if (symbol == LineType.space) {
          interpretedText += " ";
        }
      }
    }
    return interpretedText.isNotEmpty ? interpretedText : "no text";
  }

  // Main method to interpret the lines
  String interpret(List<List<Point>> lines) {
    final comparisonTable = generateComparisonTable();
    final symbols = linesToSymbols(lines);
    return symbolsToText(symbols, comparisonTable);
  }

  // Method to get output
  // String getOutput(List<List<Point>> lines) {
  //   return "Text: ${interpret(lines)}";
  // }
  // Get output by accepting PointsManager as a parameter
  String getOutput(PointsManager pointsManager) {
    // Get lines from PointsManager
    List<List<Point>> lines = pointsManager.lines.map((line) {
      return line.points;  // Convert Line objects to Point lists
    }).toList();

    return "Text: ${interpret(lines)}";  // Process lines and return interpreted text
  }
}
