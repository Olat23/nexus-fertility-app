import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/encouragement_service.dart';
import '../../services/tts_service.dart';
import '../../services/localization_provider.dart';
import '../../theme.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  FaithMode _mode = FaithMode.neutral;

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);
    final encourager = EncouragementService();
    final tts = Provider.of<TtsService>(context);
    final message = encourager.dailyMessage(_mode);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(loc.translate('supportHub'), style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(loc.translate('chooseSupportMode'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                _modeButton(FaithMode.neutral, 'Neutral'),
                const SizedBox(width: 8),
                _modeButton(FaithMode.christian, 'Christian'),
                const SizedBox(width: 8),
                _modeButton(FaithMode.muslim, 'Muslim'),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.favorite, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(loc.translate('dailyAffirmation'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 6),
                        Text(message, style: TextStyle(color: Colors.grey.shade700)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(tts.isPlaying ? Icons.pause : Icons.play_arrow, color: AppColors.primary),
                    onPressed: () async {
                      if (tts.isPlaying) {
                        await tts.stop();
                      } else {
                        await tts.speak(message);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Cultural Guidance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Coping with family pressure and finding peace in community support. Explore recommended readings and groups.',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/community_groups'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text(loc.translate('exploreCommunityGroups')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modeButton(FaithMode mode, String label) {
    final isSelected = _mode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(child: Text(label, style: TextStyle(color: isSelected ? AppColors.primary : Colors.grey.shade700))),
        ),
      ),
    );
  }
}
