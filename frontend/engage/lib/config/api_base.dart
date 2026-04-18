import 'dart:io';

import 'package:flutter/foundation.dart';

/// Production API (Heroku). Used in [kReleaseMode] unless overridden.
const String _kProdApiBaseUrl =
    'https://lets-engage-dfd94a3903ae.herokuapp.com';

/// Base URL for the Engage FastAPI backend.
///
/// Priority:
/// 1. `--dart-define=API_BASE_URL=...` (any mode; strips trailing `/`)
/// 2. Non-debug (release/profile): [_kProdApiBaseUrl]
/// 3. Debug only: local server (Android emulator: `10.0.2.2` → host localhost)
String engageApiBaseUrl() {
  const fromEnv = String.fromEnvironment('API_BASE_URL');
  if (fromEnv.isNotEmpty) {
    return fromEnv.replaceAll(RegExp(r'/$'), '');
  }
  if (!kDebugMode) {
    return _kProdApiBaseUrl;
  }
  if (kIsWeb) {
    return 'http://localhost:8000';
  }
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:8000';
  }
  return 'http://127.0.0.1:8000';
}
