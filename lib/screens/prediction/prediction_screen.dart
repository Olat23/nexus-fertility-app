import 'package:flutter/material.dart';
import '../../theme.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(backgroundColor: AppColors.primary, title: const Text('PredictBot', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('PredictBot', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('This tool provides a prediction of your fertile window. Always confirm with your clinician.'),
          ])),
          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: const Column(children: [
            ListTile(leading: Icon(Icons.calendar_today), title: Text('Mark on calendar')),
            ListTile(leading: Icon(Icons.medical_services), title: Text('Verify Prediction with a Doctor')),
          ]))
        ]),
      ),
    );
  }
}
