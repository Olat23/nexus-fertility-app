import 'package:flutter/material.dart';

class SexTimingPreferencesScreen extends StatelessWidget {
<<<<<<< HEAD
  const SexTimingPreferencesScreen({super.key});
=======
  const SexTimingPreferencesScreen({Key? key}) : super(key: key);
>>>>>>> 5875813aa29915844ad55ca06839c98c1a4de123

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sex Timing Preferences')),
<<<<<<< HEAD
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
=======
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
>>>>>>> 5875813aa29915844ad55ca06839c98c1a4de123
            Text('Preferences for timing sex relative to fertility window', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
