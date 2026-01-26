import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';

class PaintTypeNoProcessor extends StatelessWidget {
  final Color backgroundColor;
  final CanvasController controller;

  const PaintTypeNoProcessor({
    super.key,
    this.backgroundColor = Colors.grey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          CanvasView(controller: controller),
          CanvasGestureLayer(controller: controller),
        ],
      ),
    );
  }
}
