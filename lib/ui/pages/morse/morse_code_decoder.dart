// enum LineType { dot, horizontal, vertical }
enum LineType { dot, horizontal, vertical, ignored }

class MorseCodeDecoder {
  static const Map<String, String> _morseDictionary = {
    "A": ".-",
    "B": "-...",
    "C": "-.-.",
    "D": "-..",
    "E": ".",
    "F": "..-.",
    "G": "--.",
    "H": "....",
    "I": "..",
    "J": ".---",
    "K": "-.-",
    "L": ".-..",
    "M": "--",
    "N": "-.",
    "O": "---",
    "P": ".--.",
    "Q": "--.-",
    "R": ".-.",
    "S": "...",
    "T": "-",
    "U": "..-",
    "V": "...-",
    "W": ".--",
    "X": "-..-",
    "Y": "-.--",
    "Z": "--..",
    "1": ".----",
    "2": "..---",
    "3": "...--",
    "4": "....-",
    "5": ".....",
    "6": "-....",
    "7": "--...",
    "8": "---..",
    "9": "----.",
    "0": "-----"
  };

  /// Decode canvas symbols into text
  ///
  /// useVerticalSeparation: true → vertical lines = letter/word separators
  /// useVerticalSeparation: false → interpret double vertical or gaps as letters/words
  String decode(List<LineType> symbols, {bool useVerticalSeparation = true}) {
    String text = "";
    List<LineType> currentLetter = [];

    for (int i = 0; i < symbols.length; i++) {
      final symbol = symbols[i];

      if (useVerticalSeparation) {
        // --- Vertical Mode ---
        if (symbol == LineType.vertical) {
          if (currentLetter.isNotEmpty) {
            text += _decodeLetter(currentLetter);
            currentLetter.clear();
          }

          // double vertical = word separation
          if (i + 1 < symbols.length && symbols[i + 1] == LineType.vertical) {
            text += " ";
            i++; // skip second vertical
          }
        } else {
          currentLetter.add(symbol);
        }
      } else {
        // --- Gap Mode ---
        if (symbol == LineType.vertical) {
          // treat single vertical as letter separator
          if (currentLetter.isNotEmpty) {
            text += _decodeLetter(currentLetter);
            currentLetter.clear();
          }

          // check next symbol for double vertical (word separator)
          if (i + 1 < symbols.length && symbols[i + 1] == LineType.vertical) {
            text += " ";
            i++;
          }
        } else {
          currentLetter.add(symbol);
        }
      }
    }

    // Decode any leftover letter at the end
    if (currentLetter.isNotEmpty) {
      text += _decodeLetter(currentLetter);
    }

    return text.isEmpty ? "no text" : text;
  }

  /// Convert a list of LineType (dot/horizontal) into a letter
  String _decodeLetter(List<LineType> letterSymbols) {
    String morse = letterSymbols
        .map((s) => s == LineType.dot ? "." : "-")
        .join();

    final entry = _morseDictionary.entries
        .firstWhere(
          (e) => e.value == morse,
          orElse: () => const MapEntry("?", "?"),
        )
        .key;

    return entry;
  }
}
