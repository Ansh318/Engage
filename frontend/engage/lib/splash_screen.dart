import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'onboarding/account_creation_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      debugPrint('Attempting to load video: assets/landing_page_video.mp4');
      _controller = VideoPlayerController.asset('assets/landing_page_video.mp4');
      await _controller!.initialize();
      debugPrint('Video initialized successfully. Duration: ${_controller!.value.duration}');
      _controller!.setLooping(false);
      _controller!.setVolume(0.0); // Mute the video
      
      // Listen for video completion
      _controller!.addListener(_videoListener);
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _controller!.play();
        debugPrint('Video playback started. IsPlaying: ${_controller!.value.isPlaying}, Position: ${_controller!.value.position}, Duration: ${_controller!.value.duration}');
      }
    } catch (e, stackTrace) {
      debugPrint('Error loading video: $e');
      debugPrint('Stack trace: $stackTrace');
      // If video fails to load, navigate after a short delay
      if (mounted) {
        setState(() {
          _hasError = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          _navigateToOnboarding();
        });
      }
    }
  }

  void _videoListener() {
    if (_controller != null && 
        _controller!.value.isInitialized &&
        _controller!.value.duration > Duration.zero) {
      // Check if video has completed
      if (_controller!.value.position >= _controller!.value.duration) {
        _controller!.removeListener(_videoListener);
        _navigateToOnboarding();
      }
    }
  }

  void _navigateToOnboarding() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AccountCreationPage(),
        ),
      );
    }
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
