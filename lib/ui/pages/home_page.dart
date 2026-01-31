import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/pages/about/about_page.dart';
import 'package:shorthand_app/ui/pages/attic_numerals/attic_numerals_page.dart';
import 'package:shorthand_app/ui/pages/benchmark/benchmark_page.dart';
import 'package:shorthand_app/ui/pages/cuneiform/cuneiform_page.dart';
import 'package:shorthand_app/ui/pages/etruscan_numerals/etruscan_numerals_page.dart';
import 'package:shorthand_app/ui/pages/frends_logo/frends_logo_page.dart';
import 'package:shorthand_app/ui/pages/just_paint/just_paint_page.dart';
import 'package:shorthand_app/ui/pages/morse/morse_page.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/pigpen_cipher_page.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/pigpen_cipher_page2.dart';
import 'package:shorthand_app/ui/pages/power_symbol/power_symbol_page.dart';
import 'package:shorthand_app/ui/pages/rhaetic/sanzeno/sanzeno_page.dart';
import 'package:shorthand_app/ui/pages/tomtom_code/tomtom_code_page.dart';
import 'package:shorthand_app/ui/pages/ogham/ogham_multi_letter.dart';
import 'package:shorthand_app/ui/templates/page_list_page.dart';
import 'package:shorthand_app/ui/pages/ogham/ogham_script_painter.dart';

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
                        PageItem(
                          title: 'Morse Page',
                          description: 'Morse Page',
                          builder: (_) => MorsePage(),
                        ),
                        PageItem(
                          title: 'Ogham Script Page',
                          description: 'Ogham Script Page',
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
                        PageItem(
                          title: 'Frends Logo Page',
                          description: 'Frends Logo Page',
                          builder: (_) => FrendsLogoPage(),
                        ),
                        PageItem(
                          title: 'Pigpen Cipher Page',
                          description: 'Pigpen Cipher Page',
                          builder: (_) => PigpenCipherPage(),
                        ),
                        PageItem(
                          title: 'Pigpen Cipher Page 2',
                          description: 'Pigpen Cipher Page 2',
                          builder: (_) => PigpenCipherPage2(),
                        ),
                        PageItem(
                          title: 'Benchmark Page',
                          description: 'Benchmark Page',
                          builder: (_) => BenchmarkPage(),
                        ),
                        PageItem(
                          title: 'Rhaetic Page',
                          description: 'Rhaetic Page',
                          builder: (_) => SanzenoPage(),
                        ),
                        PageItem(
                          title: 'Etruscan Numerals Page',
                          description: 'Etruscan Numerals Page',
                          builder: (_) => EtruscanNumeralsPage(),
                        ),
                        PageItem(
                          title: 'Attic Numerals Page',
                          description: 'Attic Numerals Page',
                          builder: (_) => AtticNumeralsPage(),
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
