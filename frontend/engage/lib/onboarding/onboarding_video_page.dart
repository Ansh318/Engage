import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../api/engage_api.dart';
import '../landing_page.dart';
import '../services/session_store.dart';

const String _onboardingVideoUrl =
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/engage_onboarding_video.mp4?alt=media&token=1e4b3e45-bd97-4362-8bef-733faec5aeea';

/// Full-screen page that plays the Engage onboarding activity video.
/// On completion (or skip), navigates to [LandingPage].
class OnboardingVideoPage extends StatefulWidget {
  const OnboardingVideoPage({super.key});

  @override
  State<OnboardingVideoPage> createState() => _OnboardingVideoPageState();
}

class _OnboardingVideoPageState extends State<OnboardingVideoPage> {
  VideoPlayerController? _controller;
  bool _hasError = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(_onboardingVideoUrl));
      await _controller!.initialize();
      _controller!.setLooping(false);
      _controller!.addListener(_videoListener);
      if (mounted) {
        setState(() => _isInitialized = true);
        _controller!.play();
      }
    } catch (e) {
      debugPrint('Onboarding video load error: $e');
      if (mounted) {
        setState(() => _hasError = true);
        _goToLanding();
      }
    }
  }

  void _videoListener() {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (_controller!.value.duration <= Duration.zero) return;
    if (_controller!.value.position >= _controller!.value.duration) {
      _controller!.removeListener(_videoListener);
      _goToLanding();
    }
  }

  Future<void> _goToLanding() async {
    if (!mounted) return;
    final token = await SessionStore.getToken();
    if (token != null) {
      try {
        await engageApi.completeOnboarding(token);
      } catch (e) {
        debugPrint('completeOnboarding: $e');
      }
    }
    await SessionStore.setOnboardingCompleteLocally(true);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LandingPage()),
      (route) => false,
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_hasError || !_isInitialized || _controller == null)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          else
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            ),
          // Skip button
          if (_isInitialized && _controller != null)
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: _goToLanding,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
