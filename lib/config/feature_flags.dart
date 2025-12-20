import 'package:flutter/foundation.dart' show kIsWeb;

import '../firebase_options.dart';

class FeatureFlags {
  // Compile-time flags controlled via --dart-define
  static const bool enableFirebaseAuth = bool.fromEnvironment(
    'ENABLE_FIREBASE_AUTH',
    defaultValue: false,
  );

  static const bool enableFastApi = bool.fromEnvironment(
    'ENABLE_FASTAPI',
    defaultValue: true,
  );

  // Add more flags as needed, e.g., TTS or analytics
  static const bool enableTts = bool.fromEnvironment(
    'ENABLE_TTS',
    defaultValue: true,
  );

  /// Runtime guard to avoid using Firebase when web config is not filled.
  static bool get firebaseAuthAvailable {
    // On native, we assume platform config files are present.
    if (!enableFirebaseAuth) return false;
    if (!kIsWeb) return true;
    return !DefaultFirebaseOptions.isPlaceholder;
  }
}
