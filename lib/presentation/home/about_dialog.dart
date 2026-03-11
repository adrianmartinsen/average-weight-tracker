import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutDialogWidget extends StatelessWidget {
  AboutDialogWidget({super.key});
  // A PNG image of a coffee cup from Buy Me a Coffee
  final coffeePng = Image.network(
    "https://cdn.buymeacoffee.com/buttons/default-orange.png",
    height: 40,
  );

  final localPng = Image(
    image: AssetImage('assets/images/default-orange.png'),
    height: 40,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Enjoying the app?'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Close',
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'If you enjoy this app, consider supporting its development by buying me a coffee.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              launchUrl(
                Uri.parse('https://buymeacoffee.com/adrianmartinsen'),
                mode: LaunchMode.externalApplication,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: localPng,
            ),
          ),
        ],
      ),
    );
  }
}
