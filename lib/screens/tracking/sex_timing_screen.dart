import 'package:flutter/material.dart';

class SexTimingPreferencesScreen extends StatelessWidget {
  const SexTimingPreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sex Timing Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Preferences for timing sex relative to fertility window', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
