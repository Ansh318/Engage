import 'package:flutter/material.dart';
import 'dart:ui';
import 'activity_model.dart';
import 'emotion_tag.dart';

/// Before session vs after session — same grid, different copy and [onFinished] handling.
enum EmotionCheckPhase {
  beforeActivity,
  afterActivity,
}

/// Pick up to 3 emotion tags (ordered). Caller supplies [onFinished] (e.g. open session or pop stack).
class EmotionCheckInPage extends StatefulWidget {
  final Activity activity;
  final EmotionCheckPhase phase;
  /// Moods chosen on the pre-activity screen; shown as context when [phase] is [afterActivity].
  final List<EmotionTag> preActivityEmotions;
  final void Function(BuildContext context, List<EmotionTag> selected) onFinished;

  const EmotionCheckInPage({
    super.key,
    required this.activity,
    required this.onFinished,
    this.phase = EmotionCheckPhase.beforeActivity,
    this.preActivityEmotions = const [],
  });

  @override
  State<EmotionCheckInPage> createState() => _EmotionCheckInPageState();
}

class _EmotionCheckInPageState extends State<EmotionCheckInPage> {
  static const Color _bg = Color(0xFF00333D);
  static const int _maxTags = 3;

  final List<EmotionTag> _ordered = [];

  bool get _after => widget.phase == EmotionCheckPhase.afterActivity;

  String get _title =>
      _after ? 'How are you feeling now?' : 'How are you feeling right now?';

  String get _subtitle => _after
      ? 'Select upto 3 emotion tags after your activity, in order of how you feel.'
      : 'Select upto 3 emotion tags in order of how you feel.';

  String get _footerHint => _after
      ? 'Select upto 3 emotion tags after your activity.'
      : 'Select upto 3 emotion tags.';

  void _onTapEmotion(EmotionTag tag) {
    setState(() {
      final i = _ordered.indexWhere((e) => e.id == tag.id);
      if (i >= 0) {
        _ordered.removeAt(i);
      } else if (_ordered.length < _maxTags) {
        _ordered.add(tag);
      }
    });
  }

  int? _orderFor(EmotionTag tag) {
    final i = _ordered.indexWhere((e) => e.id == tag.id);
    return i < 0 ? null : i + 1;
  }

  void _submit() {
    if (_ordered.isEmpty) return;
    widget.onFinished(context, List<EmotionTag>.from(_ordered));
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final pre = widget.preActivityEmotions;

    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.12),
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Text(
              _title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              _subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.88),
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
          if (_after && pre.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                ),
                child: Text(
                  'Before you started: ${pre.map((e) => e.label).join(', ')}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ),
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              itemCount: kEmotionCatalog.length,
              itemBuilder: (context, index) {
                final tag = kEmotionCatalog[index];
                final order = _orderFor(tag);
                final selected = order != null;
                return _EmotionCard(
                  tag: tag,
                  selected: selected,
                  order: order,
                  onTap: () => _onTapEmotion(tag),
                );
              },
            ),
          ),
          _FooterBar(
            count: _ordered.length,
            max: _maxTags,
            bottomPadding: bottomInset + 16,
            hintText: _footerHint,
            onContinue: _submit,
          ),
        ],
      ),
    );
  }
}

class _EmotionCard extends StatelessWidget {
  final EmotionTag tag;
  final bool selected;
  final int? order;
  final VoidCallback onTap;

  const _EmotionCard({
    required this.tag,
    required this.selected,
    required this.order,
    required this.onTap,
  });

  static const Color _labelBar = Color(0xFF0A3D45);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? Colors.white.withValues(alpha: 0.95)
                  : Colors.white.withValues(alpha: 0.18),
              width: selected ? 2 : 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                          child: Container(
                            color: Colors.white.withValues(alpha: 0.1),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              tag.assetPath,
                              fit: BoxFit.contain,
                              height: 72,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.sentiment_satisfied_alt,
                                color: Colors.white.withValues(alpha: 0.5),
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (order != null)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Text(
                              '$order',
                              style: const TextStyle(
                                color: Color(0xFF00333D),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  color: _labelBar,
                  child: Text(
                    tag.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterBar extends StatelessWidget {
  final int count;
  final int max;
  final double bottomPadding;
  final String hintText;
  final VoidCallback onContinue;

  const _FooterBar({
    required this.count,
    required this.max,
    required this.bottomPadding,
    required this.hintText,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    hintText,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: count > 0 ? onContinue : null,
              borderRadius: BorderRadius.circular(999),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: count > 0
                          ? Colors.white.withValues(alpha: 0.18)
                          : Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: Colors.white.withValues(
                          alpha: count > 0 ? 0.28 : 0.12,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$count/$max',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: count > 0 ? 1 : 0.45),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white.withValues(alpha: count > 0 ? 1 : 0.45),
                          size: 22,
                        ),
                      ],
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
