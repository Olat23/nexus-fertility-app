import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  int _age = 27;
  int _cycleLength = 28;
  DateTime? _lastPeriodDate;
  String? _ttcHistory;
  String? _faithPreference;
  String _language = 'English';
  bool _audioGuidance = false;
  bool _isLoading = false;
  bool _acceptTerms = false;

  final List<String> _ttcHistories = [
    'Trying to Conceive',
    'Trying to Conceive - Default',
    'Preparing to conceive',
    'Just tracking my cycle',
    'TTC 6+ months',
    'TTC 12+ months',
    'Using fertility treatment',
    'Prefer not to say'
  ];

  final List<String> _faithPreferences = [
    'Christian',
    'Muslim',
    'Jewish',
    'None'
  ];

  final List<String> _languages = [
    'English',
    'Yoruba',
    'Igbo',
    'Hausa',
    'Pidgin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.9,
                  minHeight: 4,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue.shade400,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                'Let\'s complete your profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This will help us personalize your cycle guide',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 32),

                  // Age
                  _buildFieldLabel('Age'),
                  _buildNumberDropdown(
                    value: _age,
                    items: List.generate(73, (i) => i + 18),
                    onChanged: (value) => setState(() => _age = value),
                  ),
                  const SizedBox(height: 20),

                  // Cycle Length
                  _buildFieldLabel('Cycle Length'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<int>(
                      value: _cycleLength,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: List.generate(30, (i) => i + 1).map((days) {
                        return DropdownMenuItem(
                          value: days,
                          child: Text('$days Days'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _cycleLength = value ?? 28);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Average number of days between your periods',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Last Period Date
                  _buildFieldLabel('Last Period Date'),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.grey.shade600, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _lastPeriodDate == null
                                  ? 'Select date'
                                  : '${_lastPeriodDate!.day}, Dec ${_lastPeriodDate!.year}',
                              style: TextStyle(
                                fontSize: 16,
                                color: _lastPeriodDate == null
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'When your last menstrual bleeding started',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // TTC History
                  _buildFieldLabel('TTC History'),
                  _buildDropdown(
                    value: _ttcHistory,
                    items: _ttcHistories,
                    onChanged: (value) => setState(() => _ttcHistory = value),
                  ),
                  const SizedBox(height: 20),

                  // Faith Preference
                  _buildFieldLabel('Faith Preference'),
                  _buildDropdown(
                    value: _faithPreference,
                    items: _faithPreferences,
                    onChanged: (value) => setState(() => _faithPreference = value),
                  ),
                  const SizedBox(height: 20),

                  // Language
                  _buildFieldLabel('Language'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _language,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: _languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _language = value ?? 'English');
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Audio Guidance
                  _buildFieldLabel('Audio Guidance'),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Switch(
                          value: _audioGuidance,
                          onChanged: (value) =>
                              setState(() => _audioGuidance = value),
                          activeThumbColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Terms & Conditions
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I agree to the Terms and Conditions and Privacy Policy',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: (_isLoading || !_acceptTerms) ? null : _handleContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildNumberDropdown({
    required int value,
    required List<int> items,
    required Function(int) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<int>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: (val) => onChanged(val ?? value),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text('Select option'),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _lastPeriodDate = date;
      });
    }
  }

  Future<void> _handleContinue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthServiceImpl>(context, listen: false);
      final currentUser = authService.currentUser;

      if (currentUser == null) {
        throw Exception('User not found');
      }

      await authService.updateUserProfile(
        userId: currentUser.id ?? '',
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile setup complete!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to home screen
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
