import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'auth_exception.dart';

abstract class AuthService {
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<User?> signUpWithPhone({
    required String phoneNumber,
  });

  Future<bool> verifyEmailOTP({
    required String email,
    required String otp,
  });

  Future<bool> verifyPhoneOTP({
    required String phoneNumber,
    required String otp,
  });

  Future<bool> resendEmailOTP({required String email});

  Future<bool> resendPhoneOTP({required String phoneNumber});

  Future<User?> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? profileImagePath,
  });

  Future<User?> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<User?> getCurrentUser();

  Stream<User?> authStateChanges();
}

class AuthServiceImpl extends ChangeNotifier implements AuthService {
  SharedPreferences? _prefs;
  final Map<String, String> _inMemoryPrefs = {};
  User? _currentUser;
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();

  User? get currentUser => _currentUser;

  AuthServiceImpl() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _loadUserFromPrefs();
    } catch (e) {
      debugPrint('SharedPreferences init error: $e');
    }
  }

  Future<void> _ensurePrefs() async {
    if (_prefs != null) return;
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      debugPrint('SharedPreferences ensure error: $e');
      // Fall back to in-memory prefs when SharedPreferences is unavailable
      _prefs = null;
    }
  }

  String? _getString(String key) {
    if (_prefs != null) return _prefs!.getString(key);
    return _inMemoryPrefs[key];
  }

  Future<void> _setString(String key, String value) async {
    if (_prefs != null) {
      await _prefs!.setString(key, value);
      return;
    }
    _inMemoryPrefs[key] = value;
  }

  Future<void> _removeString(String key) async {
    if (_prefs != null) {
      await _prefs!.remove(key);
      return;
    }
    _inMemoryPrefs.remove(key);
  }

  void _loadUserFromPrefs() {
    try {
      final userJson = _getString('user');
      if (userJson != null) {
        try {
          _currentUser = User.fromJson(Map<String, dynamic>.from(
            (userJson as dynamic) as Map,
          ));
        } catch (e) {
          debugPrint('Error loading user: $e');
        }
      }
    } catch (e) {
      debugPrint('Load user prefs error: $e');
    }
  }

  Future<void> _saveUserToPrefs(User user) async {
    await _ensurePrefs();
    await _setString('user', _jsonEncode(user.toJson()));
    _currentUser = user;
    _authStateController.add(user);
    notifyListeners();
  }

  String _jsonEncode(Map<String, dynamic> data) {
    // Simple JSON encoding - in production use json package
    return data.toString();
  }

  @override
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // Validate email format
      if (!_isValidEmail(email)) {
        throw AuthException(AuthErrorCodes.invalidEmail);
      }

      // Validate password strength
      if (password.length < 8) {
        throw AuthException(AuthErrorCodes.passwordTooShort);
      }

      // Check if user already exists
      await _ensurePrefs();
      final existingUser = _getString('user_$email');
      if (existingUser != null) {
        throw AuthException(AuthErrorCodes.emailAlreadyRegistered);
      }

      // Create user object
      final user = User(
        email: email,
        emailVerified: false,
        createdAt: DateTime.now(),
      );

      // Store temporary user for verification
      await _setString('temp_user_$email', _jsonEncode(user.toJson()));
      await _setString('user_password_$email', password);

      // In production, send OTP via email
      debugPrint('Sending OTP to $email');

      return user;
    } catch (e) {
      debugPrint('Sign up error: $e');
      rethrow;
    }
  }

  @override
  Future<User?> signUpWithPhone({
    required String phoneNumber,
  }) async {
    try {
      // Validate phone format
      if (!_isValidPhoneNumber(phoneNumber)) {
        throw AuthException(AuthErrorCodes.invalidPhone);
      }

      // Check if phone already registered
      await _ensurePrefs();
      final existingUser = _getString('user_$phoneNumber');
      if (existingUser != null) {
        throw AuthException(AuthErrorCodes.phoneAlreadyRegistered);
      }

      // Create user object
      final user = User(
        email: '', // Will be set later
        phoneNumber: phoneNumber,
        phoneVerified: false,
        createdAt: DateTime.now(),
      );

      // Store temporary user
      await _setString('temp_user_$phoneNumber', _jsonEncode(user.toJson()));

      // In production, send OTP via SMS
      debugPrint('Sending OTP to $phoneNumber');

      return user;
    } catch (e) {
      debugPrint('Sign up error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> verifyEmailOTP({
    required String email,
    required String otp,
  }) async {
    try {
      // In production, verify OTP with backend
      if (otp.length != 6) {
        throw AuthException(AuthErrorCodes.invalidOtpFormat);
      }

      // Simulate OTP verification (in production, call backend)
      debugPrint('Verifying OTP: $otp for email: $email');

      // Get temporary user
      await _ensurePrefs();
      final tempUserJson = _getString('temp_user_$email');
      if (tempUserJson == null) {
        throw AuthException(AuthErrorCodes.userNotFound);
      }

      // Update user with verified email
      final user = User(
        email: email,
        emailVerified: true,
        createdAt: DateTime.now(),
      );

      // Save verified user
      await _saveUserToPrefs(user);
      await _removeString('temp_user_$email');

      return true;
    } catch (e) {
      debugPrint('OTP verification error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> verifyPhoneOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      if (otp.length != 6) {
        throw AuthException(AuthErrorCodes.invalidOtpFormat);
      }

      debugPrint('Verifying OTP: $otp for phone: $phoneNumber');

      // Get temporary user
      await _ensurePrefs();
      final tempUserJson = _getString('temp_user_$phoneNumber');
      if (tempUserJson == null) {
        throw AuthException(AuthErrorCodes.userNotFound);
      }

      // Update user with verified phone
      final user = User(
        email: '',
        phoneNumber: phoneNumber,
        phoneVerified: true,
        createdAt: DateTime.now(),
      );

      await _saveUserToPrefs(user);
      await _removeString('temp_user_$phoneNumber');

      return true;
    } catch (e) {
      debugPrint('OTP verification error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> resendEmailOTP({required String email}) async {
    try {
      if (!_isValidEmail(email)) {
        throw AuthException(AuthErrorCodes.invalidEmail);
      }

      debugPrint('Resending OTP to email: $email');
      // In production, send OTP via email service
      return true;
    } catch (e) {
      debugPrint('Resend OTP error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> resendPhoneOTP({required String phoneNumber}) async {
    try {
      if (!_isValidPhoneNumber(phoneNumber)) {
        throw AuthException(AuthErrorCodes.invalidPhone);
      }

      debugPrint('Resending OTP to phone: $phoneNumber');
      // In production, send OTP via SMS service
      return true;
    } catch (e) {
      debugPrint('Resend OTP error: $e');
      rethrow;
    }
  }

  @override
  Future<User?> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? profileImagePath,
  }) async {
    try {
      if (_currentUser == null) {
        throw AuthException(AuthErrorCodes.noUserLoggedIn);
      }

      final updatedUser = _currentUser!.copyWith(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        profileImageUrl: profileImagePath,
        updatedAt: DateTime.now(),
      );

      await _saveUserToPrefs(updatedUser);

      return updatedUser;
    } catch (e) {
      debugPrint('Update profile error: $e');
      rethrow;
    }
  }

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // In production, call backend authentication
      await _ensurePrefs();
      final userJson = _getString('user_$email');
      if (userJson == null) {
        throw AuthException(AuthErrorCodes.userNotFound);
      }
      _loadUserFromPrefs();
      return _currentUser;
    } catch (e) {
      debugPrint('Sign in error: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _currentUser = null;
      await _ensurePrefs();
      await _removeString('user');
      _authStateController.add(null);
      notifyListeners();
    } catch (e) {
      debugPrint('Sign out error: $e');
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Stream<User?> authStateChanges() {
    return _authStateController.stream;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length >= 7 && digitsOnly.length <= 15;
  }

  @override
  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}
