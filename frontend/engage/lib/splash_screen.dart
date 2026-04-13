import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'api/engage_api.dart';
import 'landing_page.dart';
import 'onboarding/account_creation_page.dart';
import 'onboarding/intro_page.dart';
import 'onboarding/personal_info_page.dart';
import 'services/session_store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? _controller;
  bool _hasError = false;
  bool _isInitialized = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      debugPrint('Attempting to load video: assets/landing_page_video.mp4');
      _controller = VideoPlayerController.asset('assets/landing_page_video.mp4');
      await _controller!.initialize();
      debugPrint(
        'Video initialized successfully. Duration: ${_controller!.value.duration}',
      );
      _controller!.setLooping(false);
      _controller!.setVolume(0.0);

      _controller!.addListener(_videoListener);

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _controller!.play();
        debugPrint(
          'Video playback started. IsPlaying: ${_controller!.value.isPlaying}, Position: ${_controller!.value.position}, Duration: ${_controller!.value.duration}',
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Error loading video: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          _navigateAfterSplash();
        });
      }
    }
  }

  void _videoListener() {
    if (_controller != null &&
        _controller!.value.isInitialized &&
        _controller!.value.duration > Duration.zero) {
      if (_controller!.value.position >= _controller!.value.duration) {
        _controller!.removeListener(_videoListener);
        _navigateAfterSplash();
      }
    }
  }

  Future<void> _navigateAfterSplash() async {
    if (!mounted || _navigated) return;
    _navigated = true;

    if (await SessionStore.isOnboardingCompleteLocally()) {
      _pushReplacement(const LandingPage());
      return;
    }

    final token = await SessionStore.getToken();
    if (token != null) {
      try {
        final user = await engageApi.getMe(token);
        if (user.onboardingCompleted) {
          await SessionStore.setOnboardingCompleteLocally(true);
          _pushReplacement(const LandingPage());
          return;
        }
        if (user.birthYear != null &&
            user.gender != null &&
            (user.displayName != null && user.displayName!.isNotEmpty)) {
          _pushReplacement(const IntroPage());
          return;
        }
        _pushReplacement(const PersonalInfoPage());
        return;
      } catch (e) {
        debugPrint('Splash session check failed: $e');
      }
    }

    _pushReplacement(const AccountCreationPage());
  }

  void _pushReplacement(Widget page) {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _hasError || !_isInitialized || _controller == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller!.value.size.width,
                  height: _controller!.value.size.height,
                  child: VideoPlayer(_controller!),
                ),
              ),
            ),
    );
  }
}
