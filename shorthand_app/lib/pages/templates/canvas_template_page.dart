import 'package:flutter/material.dart';

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
