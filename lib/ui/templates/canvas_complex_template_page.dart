import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';

class CanvasComplexTemplatePage extends StatelessWidget {
  final String title;
  final Widget canvas;
  final VoidCallback? onClear;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final CanvasController? controller;

  const CanvasComplexTemplatePage({
    super.key,
    required this.title,
    required this.canvas,
    this.onClear,
    this.onUndo,
    this.onRedo,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (onUndo != null)
            IconButton(icon: const Icon(Icons.undo), onPressed: onUndo),
          if (onRedo != null)
            IconButton(icon: const Icon(Icons.redo), onPressed: onRedo),
          if (controller != null)
            AnimatedBuilder(
              animation: controller!,
              builder: (context, _) {
                return Row(
                  children: [
                    const Text('Pen'),
                    Switch(
                      value: controller!.tool == Tool.eraser,
                      onChanged: (_) => controller!.toggleTool(),
                    ),
                    const Text('Eraser'),
                  ],
                );
              },
            ),
          if (controller != null)
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: controller == null
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to clipboard')),
                      );
                      Clipboard.setData(
                        ClipboardData(text: controller?.outputText ?? ''),
                      );
                    },
            ),
          if (onClear != null)
            IconButton(icon: const Icon(Icons.clear), onPressed: onClear),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: canvas),
    );
  }
}
