import 'package:flutter/material.dart';

class PageItem {
  final String title;
  final String description;
  final WidgetBuilder builder;

  PageItem({
    required this.title,
    required this.description,
    required this.builder,
  });
}

class PageListPage extends StatefulWidget {
  final String title;
  final List<PageItem> pages;

  const PageListPage({
    super.key,
    required this.pages,
    this.title = 'Pages',
  });

  @override
  State<PageListPage> createState() => _PageListPageState();
}

class _PageListPageState extends State<PageListPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredPages = widget.pages.where((p) {
      final q = query.toLowerCase();
      return p.title.toLowerCase().contains(q) ||
             p.description.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => query = value);
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredPages.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final page = filteredPages[index];
                return ListTile(
                  title: Text(page.title),
                  subtitle: Text(page.description),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: page.builder),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
