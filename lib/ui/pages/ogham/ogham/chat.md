@override
String process(Lines2 lines2) {
  final List<List<Point>> allLines = lines2.toListOfListOfPoints();

  final List<List<List<Point>>> letters = [];
  List<List<Point>> current = [];

  for (final line in allLines) {
    current.add(line);

    // Treat these as separators / terminators
    if (isSpace(current) || isEnd(current)) {
      letters.add(List.from(current));
      current.clear();
    } else if (isStart(current)) {
      // start marker begins a new letter
      current = [line];
    }
  }

  // Catch any remaining lines
  if (current.isNotEmpty) {
    letters.add(current);
  }

  final buffer = StringBuffer();

  for (final letterLines in letters) {
    final result = processSingleLetter(
      Lines2.fromListOfListOfPoints(letterLines),
    );

    if (result.isNotEmpty) {
      buffer.write(result);
      buffer.write(' ');
    }
  }

  return buffer.toString().trim();
}
