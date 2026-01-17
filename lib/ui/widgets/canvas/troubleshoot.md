class Line2 {
  final List<Point> points;

  Line2(List<Point>? points) : points = points ?? [];
}

class Lines2 {
  final List<Line2> lines;

  Lines2(this.lines);

  Lines2.fromListOfPoints(List<List<Point>> pointsList)
      : lines = pointsList.map((points) => Line2(points)).toList();

  List<List<Point>> toListOfListOfPoints() {
    return Toolbox().transformers.toListOfListOfPoints(lines);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}


class CanvasTemplatePage extends StatelessWidget {
  final String title;
  final VoidCallback? onClear;
  final List<Widget>? actions;
  final Widget canvas;

  const CanvasTemplatePage({
    super.key,
    required this.title,
    required this.canvas,
    this.onClear,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (onClear != null)
              ElevatedButton(
                onPressed: onClear,
                child: const Text('Clear'),
              ),
            if (onClear != null) const SizedBox(height: 20),
            Expanded(child: canvas),
          ],
        ),
      ),
    );
  }
}


// Think of this as whiteboard/chalkboard
class JustPaintPage extends StatefulWidget {
  const JustPaintPage({super.key});

  @override
  State<JustPaintPage> createState() => _JustPaintPageState();
}

class _JustPaintPageState extends State<JustPaintPage> {
  final PointsManager _pointsManager = PointsManager(Lines2([]));

  @override
  Widget build(BuildContext context) {
    return CanvasTemplatePage(
      title: 'Just Paint Page',
      onClear: _pointsManager.reset,
      canvas: PaintTypeNoProcessor(
        backgroundColor: Colors.grey,
        pointsManager: _pointsManager,
      ),
    );
  }
}

class PointsManager {
  final Lines2 lines;

  PointsManager(Lines2? lines) : lines = lines ?? Lines2([]);

  PointsManager addLine(Line2 line) {
    return PointsManager(Lines2([...lines.lines, line]));
  }

  PointsManager addPoint(Line2 line, Point point) {
    final updatedLines = lines.lines.map((l) {
      if (l == line) return Line2([...l.points, point]);
      return l;
    }).toList();
    return PointsManager(Lines2(updatedLines));
  }

  PointsManager reset() => PointsManager(Lines2([]));
}

class PaintTypeNoProcessor extends StatelessWidget {
  final Color backgroundColor;
  final PointsManager? pointsManager;

  const PaintTypeNoProcessor({
    super.key,
    this.backgroundColor = Colors.grey,
    this.pointsManager,
  });

  @override
  Widget build(BuildContext context) {
    return BasePaintCanvas(
      backgroundColor: backgroundColor,
      processor: null,
      showSinglePointCircle: false,
      pointsManager: pointsManager,
    );
  }
}


class BasePaintCanvas extends StatefulWidget {
  final Color backgroundColor;
  final CanvasProcessor? processor;
  final bool showSinglePointCircle;
  final PointsManager? pointsManager;

  final bool processOnPointerUp;

  /// The external canvas state (optional)
  /// use for background or placeholder
  final CanvasState? initialState;

  const BasePaintCanvas({
    super.key,
    required this.backgroundColor,
    this.processor,
    this.showSinglePointCircle = false,
    this.pointsManager,
    this.processOnPointerUp = false,
    this.initialState,
  });

  @override
  BasePaintCanvasState createState() => BasePaintCanvasState();
}

class BasePaintCanvasState extends State<BasePaintCanvas> {
  late final PointsManager _pointsManager;
  Line2? _currentLine;
  late CanvasState _canvasState;

  @override
  void initState() {
    super.initState();
    _pointsManager = widget.pointsManager ?? PointsManager(Lines2([]));
    _canvasState =
        widget.initialState ??
        CanvasState(pointsManager: _pointsManager, outputText: '');
  }

  void _startDrawing(Offset pos) {
    setState(() {      
      final newLine = Line2([Point(pos.dx, pos.dy)]);
      _pointsManager = _pointsManager.addLine(newLine);
      _currentLine = newLine;

      if (!widget.processOnPointerUp && widget.processor != null) {
        _updateOutput();
      }
    });
  }

  void _updateOutput() {
    final output = widget.processor!.process(_pointsManager.lines);
    _canvasState = CanvasState(
      pointsManager: _pointsManager,
      outputText: output,
    );
  }

  void _draw(Offset pos) {
    if (_currentLine == null) return;
    setState(() {
      _pointsManager.addPoint(_currentLine!, Point(pos.dx, pos.dy));

      if (!widget.processOnPointerUp && widget.processor != null) {
        _updateOutput();
      }
    });
  }

   void _stopDrawing() {
    setState(() {
      _currentLine = null;

      if (widget.processOnPointerUp && widget.processor != null) {
        _updateOutput();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: GestureDetector(
        onPanStart: (details) => _startDrawing(details.localPosition),
        onPanUpdate: (details) => _draw(details.localPosition),
        onPanEnd: (_) => _stopDrawing(),
        child: CustomPaint(
          painter: CanvasPainter(
            drawState: _canvasState,
            showSinglePointCircle: widget.showSinglePointCircle,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class CanvasState {
  final PointsManager pointsManager;
  final String outputText;

  CanvasState({required this.pointsManager, this.outputText = ''});
}

class CanvasPainter extends CustomPainter {
  final bool showSinglePointCircle;
  final CanvasState drawState;

  CanvasPainter({required this.drawState, required this.showSinglePointCircle});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // Draw all lines
    for (final line in drawState.pointsManager.lines.lines) {
      if (line.points.length == 1) {
        final p1 = line.points[0];
        canvas.drawCircle(Offset(p1.x, p1.y), 5.0, paint);
      } else if (line.points.length > 1) {
        for (int i = 0; i < line.points.length - 1; i++) {
          final p1 = line.points[i];
          final p2 = line.points[i + 1];
          canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), paint);
        }
      }
    }

    // Draw processor output text
    if (drawState.outputText.isNotEmpty) {
      final textStyle = TextStyle(color: Colors.black, fontSize: 20);
      final textPainter = TextPainter(
        text: TextSpan(text: drawState.outputText, style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(size.width - 120, 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
