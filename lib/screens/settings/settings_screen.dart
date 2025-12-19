import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
<<<<<<< HEAD
  const SettingsScreen({super.key});
=======
  const SettingsScreen({Key? key}) : super(key: key);
>>>>>>> 5875813aa29915844ad55ca06839c98c1a4de123

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
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
            Text('Settings coming soon', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
