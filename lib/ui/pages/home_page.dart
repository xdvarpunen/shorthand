import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/pages/about_page.dart';
import 'package:shorthand_app/ui/pages/cuneiform_page.dart';
import 'package:shorthand_app/ui/pages/just_paint_page.dart';
import 'package:shorthand_app/ui/pages/morse_page.dart';
import 'package:shorthand_app/ui/pages/power_symbol_page.dart';
import 'package:shorthand_app/ui/pages/tomtom_code_page.dart';
import 'package:shorthand_app/ui/processors/ogham/ogham_multi_letter.dart';
// import 'package:shorthand_app/ui/pages/morse_page.dart';
// import 'package:shorthand_app/ui/pages/ogham_script_multi_letter_page.dart';
// import 'package:shorthand_app/ui/pages/ogham_script_page.dart';
// import 'package:shorthand_app/ui/pages/tomtom_code_page.dart';
import 'package:shorthand_app/ui/templates/page_list_page.dart';
import 'package:shorthand_app/ui/widgets/ogham_script_painter.dart';
// import 'package:shorthand_app/ui/pages/power_symbol_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PageListPage(
                      title: 'Single Letter Pages',
                      pages: [
                        PageItem(
                          title: 'Just Paint Page',
                          description: 'Just Paint Page',
                          builder: (_) => JustPaintPage(),
                        ),
                        // PageItem(
                        //   title: 'Ogham Script Page',
                        //   description: 'Ogham Script Page',
                        //   builder: (_) => OghamScriptPage(),
                        // ),
                        // PageItem(
                        //   title: 'Ogham Script 2 Page',
                        //   description: 'Ogham Script 2 Page',
                        //   builder: (_) => OghamScriptMultiLetterPage(),
                        // ),
                        PageItem(
                          title: 'Morse Page',
                          description: 'Morse Page',
                          builder: (_) => MorsePage(),
                        ),
                        PageItem(
                          title: 'Morse2 Page',
                          description: 'Morse 2Page',
                          builder: (_) => OghamPage(
                            textInterpreter: OghamMultiLetterProcessor(100, 16),
                          ),
                        ),
                        PageItem(
                          title: 'Tomtom Code Page',
                          description: 'Tomtom Code Page',
                          builder: (_) => TomtomCodePage(),
                        ),
                        PageItem(
                          title: 'Power Symbol Page',
                          description: 'Power Symbol Page',
                          builder: (_) => PowerSymbolPage(),
                        ),
                        PageItem(
                          title: 'Cuneiform Page',
                          description: 'Cuneiform Page',
                          builder: (_) => CuneiformPage(),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Tools'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutPage()),
                );
              },
              child: const Text('Go to About Page'),
            ),
          ],
        ),
      ),
    );
  }
}
