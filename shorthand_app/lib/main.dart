import 'package:flutter/material.dart';
import 'package:shorthand_app/base_paint.dart';
import 'package:shorthand_app/canvas_paint_type_4.dart';
import 'package:shorthand_app/canvas_paint_type_5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paint Canvas with Popup and Background Color',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Track the selected paint (base class extended by other paints)
  Widget? selectedPaint;

  @override
  void initState() {
    super.initState();
    selectedPaint = PaintType1(); // Set the default paint
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint Canvas with Popup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Button to show popup
            ElevatedButton(
              onPressed: () {
                showPopupMenu(context);
              },
              child: const Text('Show Popup Menu'),
            ),
            // Add space between the canvas and the button
            const SizedBox(height: 20), // Adds space between canvas and button
            // Paint Canvas
            Expanded(
              child: selectedPaint!,
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the popup menu
  void showPopupMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a paint type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Paint Type 1'),
                onTap: () {
                  setState(() {
                    selectedPaint = PaintType1(); // Set to PaintType1
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Paint Type 2'),
                onTap: () {
                  setState(() {
                    selectedPaint = PaintType2(); // Set to PaintType2
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Paint Type 3'),
                onTap: () {
                  setState(() {
                    selectedPaint = PaintType3(); // Set to PaintType3
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Paint Type 4'),
                onTap: () {
                  setState(() {
                    selectedPaint = CanvasPaintType4(); // Set to CanvasPaintType4
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Paint Type 5'),
                onTap: () {
                  setState(() {
                    selectedPaint = CanvasPaintType5(); // Set to CanvasPaintType5
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

// Three different paint types, extending BasePaint

class PaintType1 extends BasePaint {
  const PaintType1({super.key}) : super(backgroundColor: Colors.yellow); // Example background color
}

class PaintType2 extends BasePaint {
  const PaintType2({super.key}) : super(backgroundColor: Colors.green); // Example background color
}

class PaintType3 extends BasePaint {
  const PaintType3({super.key}) : super(backgroundColor: Colors.orange); // Example background color
}
