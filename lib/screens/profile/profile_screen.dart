import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../services/localization_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServiceImpl>(context);
    final loc = Provider.of<LocalizationProvider>(context);
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('profileTitle')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header area styled to match provided image
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF9B8CFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: const Icon(Icons.person, size: 48, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(user?.email.isNotEmpty == true ? user!.email : (user?.phoneNumber ?? ''), style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Text(loc.translate('joined')),
                subtitle: Text(user?.createdAt != null ? user!.createdAt.toLocal().toString().split(' ').first : 'Unknown'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: const Text('Date of birth'),
                subtitle: Text(user?.dateOfBirth != null ? user!.dateOfBirth!.toLocal().toString().split(' ').first : 'Not set'),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/onboarding/profile');
              },
              child: Text(loc.translate('editProfile')),
            ),
          ],
        ),
      ),
    );
  }
}
