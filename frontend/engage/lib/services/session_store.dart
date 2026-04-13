import 'package:shared_preferences/shared_preferences.dart';

const _kAuthToken = 'engage_auth_token';
const _kOnboardingComplete = 'engage_onboarding_complete';

class SessionStore {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kAuthToken);
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAuthToken, token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kAuthToken);
  }

  static Future<bool> isOnboardingCompleteLocally() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kOnboardingComplete) ?? false;
  }

  static Future<void> setOnboardingCompleteLocally(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingComplete, value);
  }
}
