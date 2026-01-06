import 'package:flutter/material.dart';
import 'package:shorthand_app/canvas/canvas.dart';
import 'package:shorthand_app/new/elder_furthak_processor.dart';
import 'package:shorthand_app/new/kahakalamahou_processor.dart';
import 'package:shorthand_app/new/lao_maori_processor.dart';
import 'package:shorthand_app/new/pigpen_cipher_processor.dart';
import 'package:shorthand_app/processors/morse_code_processor_service.dart';
import 'package:shorthand_app/processors/tally_marks_five_processor_service.dart';
import 'package:shorthand_app/processors/tally_marks_four_processor_service.dart';
import 'package:shorthand_app/processors/tally_marks_one_processor_service.dart';
import 'package:shorthand_app/processors/tally_marks_three_processor_service.dart';
import 'package:shorthand_app/processors/tally_marks_two_processor_service.dart';
import 'package:shorthand_app/processors/tomtom_code_processor_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paint Canvas with Popup and Background Color',
      theme: ThemeData(primarySwatch: Colors.blue),
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
    selectedPaint = PaintTypeNoProcessor(backgroundColor: Colors.yellow);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paint Canvas with Popup')),
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
            Expanded(child: selectedPaint!),
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
                title: const Text('Test 1'),
                onTap: () {
                  setState(() {
                    selectedPaint = PaintTypeNoProcessor(
                      key: UniqueKey(),
                      backgroundColor: Colors.yellow,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Test 2'),
                onTap: () {
                  setState(() {
                    selectedPaint = PaintTypeNoProcessor(
                      key: UniqueKey(),
                      backgroundColor: Colors.green,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Test 3'),
                onTap: () {
                  setState(() {
                    selectedPaint = PaintTypeNoProcessor(
                      key: UniqueKey(),
                      backgroundColor: Colors.orange,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Tomtom Code'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: TomtomCodeProcessorService(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Morse Code'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: MorseCodeProcessorService(),
                      showSinglePointCircle: true,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Tally Marks One'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: TallyMarksOneProcessorService(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              
              ListTile(
                title: const Text('Tally Marks Two'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: TallyMarksTwoProcessorService(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Tally Marks Three'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: TallyMarksThreeProcessorService(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Tally Marks Four'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: TallyMarksFourProcessorService(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Tally Marks Five'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: TallyMarksFiveProcessorService(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Elder Furthak'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: ElderFurthakProcessor(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Ka Hakalama Hou'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: KahakalamahouProcessor(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Lao Maori'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: LaoMaoriProcessor(),
                      showSinglePointCircle: false,
                    );
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Pigpen Cipher'),
                onTap: () {
                  setState(() {
                    selectedPaint = BasePaintCanvas(
                      key: UniqueKey(),
                      backgroundColor: Colors.grey,
                      processor: PigpenCipherProcessor(),
                      showSinglePointCircle: true,
                    );
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
