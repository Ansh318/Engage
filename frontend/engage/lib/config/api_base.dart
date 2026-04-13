import 'dart:io';

import 'package:flutter/foundation.dart';

/// Base URL for the local FastAPI server.
///
/// Android emulator: `10.0.2.2` maps to the host machine's localhost.
/// Override at build time: `--dart-define=API_BASE_URL=http://192.168.1.5:8000`
String engageApiBaseUrl() {
  const fromEnv = String.fromEnvironment('API_BASE_URL');
  if (fromEnv.isNotEmpty) {
    return fromEnv.replaceAll(RegExp(r'/$'), '');
  }
  if (kIsWeb) {
    return 'http://localhost:8000';
  }
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:8000';
  }
  return 'http://127.0.0.1:8000';
}
