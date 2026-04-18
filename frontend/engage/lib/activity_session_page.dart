import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'activity_model.dart';
import 'api/engage_api.dart';
import 'emotion_check_in_page.dart';
import 'emotion_tag.dart';
import 'services/session_store.dart';

/// In-activity experience: sequential session videos when [Activity.sessionVideoAssets] is set.
class ActivitySessionPage extends StatefulWidget {
  final Activity activity;
  final List<EmotionTag> selectedEmotions;
  final String modality;

  const ActivitySessionPage({
    super.key,
    required this.activity,
    required this.selectedEmotions,
    required this.modality,
  });

  @override
  State<ActivitySessionPage> createState() => _ActivitySessionPageState();
}

class _ActivitySessionPageState extends State<ActivitySessionPage> {
  static const Color _bg = Color(0xFF00333D);

  VideoPlayerController? _controller;
  int _videoIndex = 0;
  bool _initializing = true;
  bool _loadError = false;
  bool _allComplete = false;
  bool _usedVideoSkip = false;

  List<String> get _videos => widget.activity.sessionVideoAssets ?? [];

  @override
  void initState() {
    super.initState();
    if (_videos.isEmpty) {
      _initializing = false;
    } else {
      _loadVideo(0);
    }
  }

  void _disposeController() {
    _controller?.removeListener(_onVideoTick);
    _controller?.dispose();
    _controller = null;
  }

  Future<void> _loadVideo(int index) async {
    _disposeController();
    if (!mounted) return;
    if (index >= _videos.length) {
      setState(() {
        _allComplete = true;
        _initializing = false;
      });
      return;
    }

    setState(() {
      _initializing = true;
      _loadError = false;
      _videoIndex = index;
    });

    try {
      final c = _createControllerForSource(_videos[index]);
      await c.initialize();
      if (!mounted) {
        c.dispose();
        return;
      }
      c.setLooping(false);
      _controller = c;
      c.addListener(_onVideoTick);
      setState(() => _initializing = false);
      await c.play();
    } catch (e, st) {
      debugPrint('Activity video load error: $e\n$st');
      if (mounted) {
        setState(() {
          _loadError = true;
          _initializing = false;
        });
      }
    }
  }

  VideoPlayerController _createControllerForSource(String source) {
    final normalized = source.trim().toLowerCase();
    if (normalized.startsWith('http://') || normalized.startsWith('https://')) {
      return VideoPlayerController.networkUrl(Uri.parse(source));
    }
    return VideoPlayerController.asset(source);
  }

  void _onVideoTick() {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    final d = c.value.duration;
    if (d <= Duration.zero) return;
    if (c.value.position >= d) {
      c.removeListener(_onVideoTick);
      final next = _videoIndex + 1;
      if (next >= _videos.length) {
        if (mounted) setState(() => _allComplete = true);
      } else {
        _loadVideo(next);
      }
    }
  }

  void _skipToNext() {
    _usedVideoSkip = true;
    final c = _controller;
    if (c == null) return;
    c.removeListener(_onVideoTick);
    final next = _videoIndex + 1;
    if (next >= _videos.length) {
      setState(() => _allComplete = true);
    } else {
      _loadVideo(next);
    }
  }

  Future<void> _persistSessionCompletion(List<EmotionTag> postTags) async {
    final token = await SessionStore.getToken();
    if (token == null) return;
    final n = _videos.length;
    try {
      await engageApi.recordActivitySession(
        token: token,
        modality: widget.modality,
        activityTitle: widget.activity.title,
        preEmotionTagIds: widget.selectedEmotions.map((e) => e.id).toList(),
        postEmotionTagIds: postTags.map((e) => e.id).toList(),
        videosTotal: n,
        videosCompleted: n,
        usedVideoSkip: _usedVideoSkip,
      );
    } catch (e, st) {
      debugPrint('recordActivitySession failed: $e\n$st');
    }
  }

  /// Same emotion grid as pre-activity; then pops post → session → pre check-in (back to detail).
  void _openPostActivityCheckIn() {
    final nav = Navigator.of(context);
    nav.push<void>(
      MaterialPageRoute<void>(
        builder: (ctx) => EmotionCheckInPage(
          activity: widget.activity,
          phase: EmotionCheckPhase.afterActivity,
          preActivityEmotions: widget.selectedEmotions,
          onFinished: (postCtx, postTags) {
            debugPrint(
              'Emotion check-in recorded — before: ${widget.selectedEmotions.map((e) => e.label).join(', ')}; '
              'after: ${postTags.map((e) => e.label).join(', ')}',
            );
            unawaited(_persistSessionCompletion(postTags));
            Navigator.of(postCtx).pop();
            nav.pop();
            nav.pop();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasVideos = _videos.isNotEmpty;

    return Scaffold(
      backgroundColor: hasVideos ? Colors.black : _bg,
      appBar: AppBar(
        backgroundColor: hasVideos ? Colors.black : _bg,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.activity.title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (hasVideos && !_allComplete && !_loadError)
            TextButton(
              onPressed: _initializing ? null : _skipToNext,
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: _initializing ? 0.4 : 1),
                ),
              ),
            ),
        ],
      ),
      body: hasVideos
          ? _buildVideoBody()
          : _buildPlaceholderBody(),
    );
  }

  Widget _buildVideoBody() {
    if (_loadError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white70, size: 48),
              const SizedBox(height: 16),
              Text(
                'Could not load this clip.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 16),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go back'),
              ),
            ],
          ),
        ),
      );
    }

    if (_allComplete) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.check_circle_outline, size: 64, color: Colors.green.shade300),
              const SizedBox(height: 20),
              Text(
                'You finished all ${_videos.length} parts.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Moods you noted before: ${widget.selectedEmotions.map((e) => e.label).join(', ')}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF506668),
                ),
                onPressed: _openPostActivityCheckIn,
                child: const Text(
                  'How do you feel now?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final c = _controller;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_initializing || c == null || !c.value.isInitialized)
          const Center(child: CircularProgressIndicator(color: Colors.white)),
        if (!_initializing && c != null && c.value.isInitialized)
          Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: c.value.size.width,
                height: c.value.size.height,
                child: VideoPlayer(c),
              ),
            ),
          ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Part ${_videoIndex + 1} of ${_videos.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You’re checked in: ${widget.selectedEmotions.map((e) => e.label).join(', ')}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Text(
                  'Activity video\ncoming next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF506668),
              ),
              onPressed: _openPostActivityCheckIn,
              child: const Text(
                'Finish & note how you feel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
