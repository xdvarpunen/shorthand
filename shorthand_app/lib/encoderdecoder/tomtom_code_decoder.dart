enum LineType { ascending, descending, space }

class TomtomCodeDecoder {
  static const Map<String, List<LineType>> _tomtomComparisonTable = {
    "A": [LineType.ascending],
    "B": [LineType.ascending, LineType.ascending],
    "C": [LineType.ascending, LineType.ascending, LineType.ascending],
    "D": [
      LineType.ascending,
      LineType.ascending,
      LineType.ascending,
      LineType.ascending,
    ],
    "E": [LineType.ascending, LineType.descending],
    "F": [LineType.ascending, LineType.ascending, LineType.descending],
    "G": [
      LineType.ascending,
      LineType.ascending,
      LineType.ascending,
      LineType.descending,
    ],
    "H": [LineType.ascending, LineType.descending, LineType.descending],
    "I": [
      LineType.ascending,
      LineType.descending,
      LineType.descending,
      LineType.descending,
    ],
    "J": [LineType.descending, LineType.ascending],
    "K": [LineType.descending, LineType.descending, LineType.ascending],
    "L": [
      LineType.descending,
      LineType.descending,
      LineType.descending,
      LineType.ascending,
    ],
    "M": [LineType.descending, LineType.ascending, LineType.ascending],
    "N": [
      LineType.descending,
      LineType.ascending,
      LineType.ascending,
      LineType.ascending,
    ],
    "O": [LineType.ascending, LineType.descending, LineType.ascending],
    "P": [
      LineType.ascending,
      LineType.ascending,
      LineType.descending,
      LineType.ascending,
    ],
    "Q": [
      LineType.ascending,
      LineType.descending,
      LineType.descending,
      LineType.ascending,
    ],
    "R": [
      LineType.ascending,
      LineType.descending,
      LineType.ascending,
      LineType.ascending,
    ],
    "S": [LineType.descending, LineType.ascending, LineType.ascending],
    "T": [
      LineType.descending,
      LineType.descending,
      LineType.ascending,
      LineType.descending,
    ],
    "U": [
      LineType.descending,
      LineType.ascending,
      LineType.ascending,
      LineType.descending,
    ],
    "V": [
      LineType.descending,
      LineType.ascending,
      LineType.descending,
      LineType.descending,
    ],
    "W": [
      LineType.ascending,
      LineType.ascending,
      LineType.descending,
      LineType.descending,
    ],
    "X": [
      LineType.descending,
      LineType.descending,
      LineType.ascending,
      LineType.ascending,
    ],
    "Y": [
      LineType.descending,
      LineType.ascending,
      LineType.descending,
      LineType.ascending,
    ],
    "Z": [
      LineType.ascending,
      LineType.descending,
      LineType.ascending,
      LineType.descending,
    ],
  };

  // Helper method to compare arrays
  bool arraysAreEqual(List<LineType> arr1, List<LineType> arr2) {
    if (arr1.length != arr2.length) return false;
    return List.generate(
      arr1.length,
      (i) => arr1[i] == arr2[i],
    ).every((e) => e);
  }

  // Convert symbols to text using the comparison table
  String interpret(List<LineType> symbols) {
    String interpretedText = "";
    List<LineType> symbolGroup = [];

    for (int i = 0; i < symbols.length; i++) {
      var symbol = symbols[i];
      if (symbol != LineType.space) {
        symbolGroup.add(symbol);
      }

      if (symbol == LineType.space || i == symbols.length - 1) {
        if (symbolGroup.isNotEmpty) {
          _tomtomComparisonTable.forEach((key, value) {
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
}
