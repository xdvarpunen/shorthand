import 'package:flutter/material.dart';
import 'package:shorthand_app/canvas/ogham_script_painter.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/ogham_processor.dart';

class OghamScriptPage extends StatefulWidget {
  const OghamScriptPage({super.key});

  @override
  State<OghamScriptPage> createState() => _OghamScriptPageState();
}

class _OghamScriptPageState extends State<OghamScriptPage> {
  final PointsManager _pointsManager = PointsManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ogham Script ᚛ᚑᚌᚐᚋ᚜')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Button to show popup
            ElevatedButton(
              onPressed: () {
                _pointsManager.reset();
              },
              child: const Text('Clear'),
            ),
            // Add space between the canvas and the button
            const SizedBox(height: 20), // Adds space between canvas and button
            // Paint Canvas
            Expanded(
              child: OghamScriptPaintCanvas(
                backgroundColor: Colors.grey,
                processor: OghamProcessor(100, 16),
                showSinglePointCircle: true,
                pointsManager: _pointsManager,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
