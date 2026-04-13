import 'package:flutter/material.dart';
import 'dart:ui';
import 'activity_model.dart';
import 'activity_session_page.dart';
import 'emotion_check_in_page.dart';

/// Activity detail — dark teal, card-based flow & materials (design reference #00333d).
class ActivityDetailPage extends StatefulWidget {
  final Activity activity;
  /// Backend modality key: art, sound, drama, movement, storytelling.
  final String modality;

  const ActivityDetailPage({
    super.key,
    required this.activity,
    required this.modality,
  });

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  bool _descriptionExpanded = false;

  static const Color _bgDeep = Color(0xFF00333D);
  static const Color _cardSurface = Color(0xFF0A3D45);
  static const Color _cardBorder = Color(0xFF2A5F66);
  static const Color _divider = Color(0xFF1A4F57);
  static const Color _orangeAccent = Color(0xFFF39200);
  static const Color _engageButton = Color(0xFF506668);

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;
    final fullDescription = activity.fullDescription ?? activity.description;
    final topImageHeight = MediaQuery.of(context).size.height * 0.45;

    return Scaffold(
      backgroundColor: _bgDeep,
      body: Column(
        children: [
          SizedBox(
            height: topImageHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (activity.imagePath != null)
                  Image.asset(
                    activity.imagePath!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholderBackground(),
                  )
                else
                  _buildPlaceholderBackground(),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: _bgDeep,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildPill(Icons.access_time, activity.duration),
                        const SizedBox(width: 8),
                        _buildPill(
                          Icons.location_on,
                          activity.location,
                          trailingIcon: Icons.info_outline,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildFacilitatorSection(activity),
                    const SizedBox(height: 20),
                    _buildDescriptionSection(
                      fullDescription,
                      expanded: _descriptionExpanded,
                      onTap: () {
                        setState(() {
                          _descriptionExpanded = !_descriptionExpanded;
                        });
                      },
                    ),
                    const SizedBox(height: 28),
                    if (activity.flowSteps != null &&
                        activity.flowSteps!.isNotEmpty) ...[
                      _buildSectionTitle('Activity Flow'),
                      const SizedBox(height: 12),
                      _buildFlowCard(activity.flowSteps!),
                      const SizedBox(height: 28),
                    ],
                    if (activity.materials != null &&
                        activity.materials!.isNotEmpty) ...[
                      _buildSectionTitle('Materials Required'),
                      const SizedBox(height: 12),
                      _buildMaterialsCard(activity.materials!),
                      const SizedBox(height: 24),
                    ],
                    const SizedBox(height: 8),
                    _buildEngageButton(),
                    if (activity.materials != null &&
                        activity.materials!.isNotEmpty) ...[
                      const SizedBox(height: 28),
                      _buildOutcomesFooter(),
                    ],
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00333D),
            Color(0xFF0A464E),
          ],
        ),
      ),
    );
  }

  Widget _buildPill(IconData icon, String text, {IconData? trailingIcon}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.22),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 6),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 4),
                Icon(trailingIcon, color: Colors.white, size: 14),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacilitatorSection(Activity activity) {
    final name = activity.facilitatorName ?? 'Engage';
    final imagePath = activity.facilitatorImagePath;

    return Row(
      children: [
        ClipOval(
          child: Container(
            width: 48,
            height: 48,
            color: Colors.white.withOpacity(0.15),
            child: imagePath != null
                ? Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 48,
                    height: 48,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                  )
                : const Icon(Icons.person, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Facilitated by',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.22),
                  width: 1,
                ),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(
    String text, {
    required bool expanded,
    required VoidCallback onTap,
  }) {
    const previewLength = 120;
    final showPreview = text.length > previewLength && !expanded;
    final displayText = showPreview
        ? '${text.substring(0, previewLength).trim()}...'
        : text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: TextStyle(
            color: Colors.white.withOpacity(0.92),
            fontSize: 15,
            height: 1.5,
          ),
        ),
        if (text.length > previewLength)
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                expanded ? 'Read less ^' : 'Read more',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFlowCard(List<ActivityFlowStep> steps) {
    return Container(
      decoration: BoxDecoration(
        color: _cardSurface.withOpacity(0.92),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            if (i > 0)
              Divider(height: 1, thickness: 1, color: _divider.withOpacity(0.9)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: _buildFlowRow(steps[i]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFlowRow(ActivityFlowStep step) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDiscIcon(
          iconAsset: step.iconAsset,
          icon: step.icon,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                step.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Circular orange disc — PNG assets are already full discs; [icon] is fallback.
  Widget _buildDiscIcon({String? iconAsset, IconData? icon}) {
    const double size = 52;
    if (iconAsset != null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipOval(
          child: Image.asset(
            iconAsset,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _discIconFallback(icon),
          ),
        ),
      );
    }
    return _discIconFallback(icon);
  }

  Widget _discIconFallback(IconData? icon) {
    const double size = 52;
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: _orangeAccent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon ?? Icons.circle_outlined,
        color: Colors.white,
        size: 26,
      ),
    );
  }

  Widget _buildMaterialsCard(List<ActivityMaterial> materials) {
    return Container(
      decoration: BoxDecoration(
        color: _cardSurface.withOpacity(0.92),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        children: [
          for (int i = 0; i < materials.length; i++) ...[
            if (i > 0)
              Divider(height: 1, thickness: 1, color: _divider.withOpacity(0.9)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: ClipOval(
                      child: Image.asset(
                        materials[i].iconAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: _orangeAccent,
                          alignment: Alignment.center,
                          child: const Icon(Icons.inventory_2_outlined,
                              color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      materials[i].label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEngageButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (ctx) => EmotionCheckInPage(
                    activity: widget.activity,
                    onFinished: (checkInContext, tags) {
                      Navigator.of(checkInContext).push<void>(
                        MaterialPageRoute<void>(
                          builder: (_) => ActivitySessionPage(
                            activity: widget.activity,
                            selectedEmotions: tags,
                            modality: widget.modality,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                color: _engageButton.withOpacity(0.88),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white.withOpacity(0.18),
                  width: 1,
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                height: 54,
                child: Center(
                  child: Text(
                    'Engage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutcomesFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Expected Outcomes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Blog link coming soon'),
                backgroundColor: _bgDeep,
              ),
            );
          },
          child: Text(
            'Read Blog >',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
