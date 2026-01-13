import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/widgets/base_paint_canvas.dart';

class PaintTypeNoProcessor extends StatelessWidget {
  final Color backgroundColor;

  const PaintTypeNoProcessor({super.key, this.backgroundColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return BasePaintCanvas(
      backgroundColor: backgroundColor,
      processor: null,
      showSinglePointCircle: false,
    );
  }
}