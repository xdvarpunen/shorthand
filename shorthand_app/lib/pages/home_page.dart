import 'package:flutter/material.dart';
import 'package:shorthand_app/pages/development_page.dart';
import 'package:shorthand_app/pages/glagotic_page.dart';
import 'package:shorthand_app/pages/hangul_page.dart';
import 'package:shorthand_app/pages/math_page.dart';
import 'package:shorthand_app/pages/ogham_script_page.dart';
import 'package:shorthand_app/pages/templates/page_list_page.dart';

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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DevelopmentPage()),
                );
              },
              child: const Text('Go to Development Page'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OghamScriptPage()),
                );
              },
              child: const Text('Go to Ogham Script Page'),
            ),
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
                          title: 'Glagotic Page',
                          description: 'Glagotic Page',
                          builder: (_) => GlagoticPage(),
                        ),
                        PageItem(
                          title: 'Hangul Page',
                          description: 'Hangul Page',
                          builder: (_) => HangulPage(),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Go to Single Letter Page'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MathPage()),
                );
              },
              child: const Text('Go to Math Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
