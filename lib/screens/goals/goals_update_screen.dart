import 'package:flutter/material.dart';
import '../../theme.dart';

class GoalsUpdateScreen extends StatelessWidget {
  const GoalsUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(backgroundColor: AppColors.primary, title: const Text('Update Goals', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Start Date'),
            const SizedBox(height: 8),
            TextField(decoration: const InputDecoration(hintText: '15/06/2025')),
            const SizedBox(height: 12),
            const Text('Primary Goal'),
            const SizedBox(height: 8),
            TextField(decoration: const InputDecoration(hintText: 'Conceive')),
            const SizedBox(height: 12),
            const Text('Cycle Length'),
            const SizedBox(height: 8),
            TextField(decoration: const InputDecoration(hintText: '28')),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Update')))
          ]),
        ),
      ),
    );
  }
}
