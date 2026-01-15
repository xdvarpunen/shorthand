import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/templates/centered_text_template_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CenteredTextTemplatePage(
      title: 'About',
      heading: 'About This App',
      body:
          'Shorthand App is a simple tool for exploring writing systems '
          'and symbolic languages such as Ogham and Morse.\n\n'
          'Designed to be minimal, fast, and mobile-friendly. Maybe.',
    );
  }
}
