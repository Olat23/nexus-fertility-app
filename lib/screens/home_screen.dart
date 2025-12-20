import 'package:flutter/material.dart';

import 'package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          _buildCalendarTab(),
          _buildLearnHubTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: AppLocalizations.of(context)!.calendar,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: AppLocalizations.of(context)!.learn,
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    final size = MediaQuery.of(context).size;
    final heroHeight = size.height * 0.5;
    const buttonHeight = 64.0;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: heroHeight + (buttonHeight / 2),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: heroHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E683D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 30,
                          left: 30,
                          child: Icon(
                            Icons.menu,
                            color: Color(0xFFA8D497),
                            size: 28,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "Today's fertility insight",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFA8D497),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Your next fertility window is from\nDec 23-27',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: heroHeight - (buttonHeight / 2),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 280,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA8D497),
                          foregroundColor: const Color(0xFF2E683D),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.water_drop, color: Color(0xFF2E683D)),
                            SizedBox(width: 12),
                            Text(
                              'Log symptoms',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Color(0xFF2E683D),
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_right, color: Color(0xFF2E683D)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'December 2025',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildCalendarGrid(),
          const SizedBox(height: 24),
          
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.loggedSymptoms,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildLoggedSymptomItem(AppLocalizations.of(context)!.bleeding, 7),
          _buildLoggedSymptomItem(AppLocalizations.of(context)!.mood, 14),
          _buildLoggedSymptomItem(AppLocalizations.of(context)!.cervicalMucus, 21),
          _buildLoggedSymptomItem(AppLocalizations.of(context)!.pain, 28),
          _buildLoggedSymptomItem(AppLocalizations.of(context)!.notes, 30),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final days = List.generate(31, (i) => i + 1);
    const dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Column(
      children: [
        // Day labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayLabels
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 12),
        // Calendar days
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 35,
          itemBuilder: (context, index) {
            final day = index - 1;
            if (day < 0 || day >= 31) {
              return const SizedBox();
            }
            return Container(
              decoration: BoxDecoration(
                color: day + 1 == 23
                    ? Colors.blue.shade400
                    : day + 1 > 23
                        ? Colors.grey.shade200
                        : Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${day + 1}',
                  style: TextStyle(
                    fontSize: 14,
                    color: day + 1 == 23 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoggedSymptomItem(String symptom, int day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.grey.shade400, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              symptom,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Text(
            '$day',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildLearnHubTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.learnHub,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.educationalContentComingSoon,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.black),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomCard(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

