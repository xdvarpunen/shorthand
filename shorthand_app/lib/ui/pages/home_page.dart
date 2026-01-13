import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/pages/about_page.dart';
import 'package:shorthand_app/ui/pages/morse_page.dart';
import 'package:shorthand_app/ui/pages/ogham_script_page.dart';
import 'package:shorthand_app/ui/templates/page_list_page.dart';

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
                          title: 'Ogham Script Page',
                          description: 'Ogham Script Page',
                          builder: (_) => OghamScriptPage(),
                        ),
                        PageItem(
                          title: 'Hangul Page',
                          description: 'Hangul Page',
                          builder: (_) => MorsePage(),
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