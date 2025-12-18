import 'package:flutter/material.dart';
import '../../theme.dart';

class SettingsProfileSetupScreen extends StatelessWidget {
  const SettingsProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(backgroundColor: AppColors.primary, title: const Text('Profile Setup', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Full Name'),
            const SizedBox(height: 8),
            TextField(decoration: const InputDecoration(hintText: 'Amaka John')),
            const SizedBox(height: 12),
            const Text('Email Address'),
            const SizedBox(height: 8),
            TextField(decoration: const InputDecoration(hintText: 'amaka.john@email.com')),
            const SizedBox(height: 12),
            const Text('Password'),
            const SizedBox(height: 8),
            TextField(obscureText: true, decoration: const InputDecoration(hintText: '••••••••')),
            const SizedBox(height: 12),
            const Text('Profile Picture'),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () {}, child: const Text('Upload image')),
            const SizedBox(height: 12),
            const Text('Faith Preference'),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: const [Chip(label: Text('Christian')), Chip(label: Text('Muslim')), Chip(label: Text('None'))]),
            const SizedBox(height: 12),
            Row(children: const [Text('Audio Guidance'), Spacer(), Switch(value: false, onChanged: null)]),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Save'))),
          ]),
        ),
      ),
    );
  }
}
