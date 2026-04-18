import 'dart:io';

import 'package:flutter/foundation.dart';

/// Production API (Heroku).
const String _kProdApiBaseUrl =
    'https://lets-engage-dfd94a3903ae.herokuapp.com';

/// Base URL for the Engage FastAPI backend.
///
/// **Defaults to production** so TestFlight / App Store / release IPA never
/// accidentally talk to `127.0.0.1` (a common failure when a debug-style
/// build is uploaded).
///
/// Priority:
/// 1. `--dart-define=API_BASE_URL=https://...` — full override (strips `/`).
/// 2. `--dart-define=USE_LOCAL_API=true` — use local dev server (debug/profile
///    only; see below).
/// 3. Otherwise: [_kProdApiBaseUrl].
///
/// Local backend during development:
/// ```sh
/// flutter run --dart-define=USE_LOCAL_API=true
/// ```
/// Android emulator uses `10.0.2.2:8000`; iOS/macOS/desktop use `127.0.0.1:8000`.
String engageApiBaseUrl() {
  const fromEnv = String.fromEnvironment('API_BASE_URL');
  if (fromEnv.isNotEmpty) {
    return fromEnv.replaceAll(RegExp(r'/$'), '');
  }

  const useLocalApi = bool.fromEnvironment(
    'USE_LOCAL_API',
    defaultValue: false,
  );
  if (useLocalApi && !kReleaseMode) {
    if (kIsWeb) {
      return 'http://localhost:8000';
    }
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    }
    return 'http://127.0.0.1:8000';
  }

  return _kProdApiBaseUrl;
}
