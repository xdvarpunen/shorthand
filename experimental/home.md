import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/pages/development_page.dart';
// import 'package:shorthand_app/ui/pages/glagotic_page.dart';
// import 'package:shorthand_app/ui/pages/hangul_page.dart';
// import 'package:shorthand_app/ui/pages/math_page.dart';
// import 'package:shorthand_app/ui/pages/ogham_script_page.dart';
import 'package:shorthand_app/ui/pages/toolbox_based_page.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DevelopmentPage()),
                );
              },
              child: const Text('Go to Development Page'),
            ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (_) => OghamScriptPage()),
            //     );
            //   },
            //   child: const Text('Go to Ogham Script Page'),
            // ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => PageListPage(
            //           title: 'Single Letter Pages',
            //           pages: [
            //             PageItem(
            //               title: 'Glagotic Page',
            //               description: 'Glagotic Page',
            //               builder: (_) => GlagoticPage(),
            //             ),
            //             PageItem(
            //               title: 'Hangul Page',
            //               description: 'Hangul Page',
            //               builder: (_) => HangulPage(),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            //   child: const Text('Go to Single Letter Page'),
            // ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (_) => MathPage()),
            //     );
            //   },
            //   child: const Text('Go to Math Page'),
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PageListPage(
                      title: 'Toolbox Based Pages',
                      pages: [
                        PageItem(
                          title: 'Toolbox Based Page',
                          description: 'Toolbox Based Page',
                          builder: (_) => ToolboxBasedPage(),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Go to Toolbox Based Page'),
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
