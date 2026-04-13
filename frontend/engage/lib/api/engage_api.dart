import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_base.dart';

class EngageUser {
  EngageUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.displayName,
    this.gender,
    this.birthYear,
    required this.onboardingCompleted,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String? displayName;
  final String? gender;
  final int? birthYear;
  final bool onboardingCompleted;

  factory EngageUser.fromJson(Map<String, dynamic> json) {
    return EngageUser(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      displayName: json['display_name'] as String?,
      gender: json['gender'] as String?,
      birthYear: json['birth_year'] as int?,
      onboardingCompleted: json['onboarding_completed'] as bool? ?? false,
    );
  }
}

class EngageApiException implements Exception {
  EngageApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'EngageApiException($statusCode): $message';
}

class EngageApi {
  EngageApi({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Uri _uri(String path) {
    final base = engageApiBaseUrl();
    return Uri.parse('$base$path');
  }

  Map<String, String> _headers({String? token}) {
    final h = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      h['Authorization'] = 'Bearer $token';
    }
    return h;
  }

  Future<({String token, EngageUser user})> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final res = await _client.post(
      _uri('/auth/register'),
      headers: _headers(),
      body: jsonEncode({
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      }),
    );
    if (res.statusCode != 200) {
      throw _parseError(res);
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final token = body['access_token'] as String;
    final user = EngageUser.fromJson(body['user'] as Map<String, dynamic>);
    return (token: token, user: user);
  }

  Future<EngageUser> getMe(String token) async {
    final res = await _client.get(
      _uri('/users/me'),
      headers: _headers(token: token),
    );
    if (res.statusCode != 200) {
      throw _parseError(res);
    }
    return EngageUser.fromJson(
      jsonDecode(res.body) as Map<String, dynamic>,
    );
  }

  Future<EngageUser> updateProfile({
    required String token,
    String? displayName,
    String? gender,
    int? birthYear,
  }) async {
    final body = <String, dynamic>{};
    if (displayName != null) body['display_name'] = displayName;
    if (gender != null) body['gender'] = gender;
    if (birthYear != null) body['birth_year'] = birthYear;

    final res = await _client.patch(
      _uri('/users/me'),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );
    if (res.statusCode != 200) {
      throw _parseError(res);
    }
    return EngageUser.fromJson(
      jsonDecode(res.body) as Map<String, dynamic>,
    );
  }

  /// Records a completed activity with pre/post emotion tags (requires login).
  Future<void> recordActivitySession({
    required String token,
    required String modality,
    required String activityTitle,
    required List<String> preEmotionTagIds,
    required List<String> postEmotionTagIds,
    int? videosTotal,
    int? videosCompleted,
    bool usedVideoSkip = false,
  }) async {
    final body = <String, dynamic>{
      'modality': modality,
      'activity_title': activityTitle,
      'pre_emotion_tag_ids': preEmotionTagIds,
      'post_emotion_tag_ids': postEmotionTagIds,
      'used_video_skip': usedVideoSkip,
    };
    if (videosTotal != null) body['videos_total'] = videosTotal;
    if (videosCompleted != null) body['videos_completed'] = videosCompleted;

    final res = await _client.post(
      _uri('/users/me/activity-sessions'),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );
    if (res.statusCode != 200) {
      throw _parseError(res);
    }
  }

  Future<EngageUser> completeOnboarding(String token) async {
    final res = await _client.post(
      _uri('/users/me/onboarding/complete'),
      headers: _headers(token: token),
    );
    if (res.statusCode != 200) {
      throw _parseError(res);
    }
    return EngageUser.fromJson(
      jsonDecode(res.body) as Map<String, dynamic>,
    );
  }

  EngageApiException _parseError(http.Response res) {
    try {
      final m = jsonDecode(res.body) as Map<String, dynamic>;
      final detail = m['detail'];
      if (detail is String) {
        return EngageApiException(detail, statusCode: res.statusCode);
      }
      if (detail is List) {
        return EngageApiException(
          detail.map((e) => e.toString()).join('; '),
          statusCode: res.statusCode,
        );
      }
    } catch (_) {}
    return EngageApiException(
      res.body.isNotEmpty ? res.body : 'Request failed',
      statusCode: res.statusCode,
    );
  }
}

/// Singleton-style accessor for widgets that do not use DI.
final engageApi = EngageApi();
