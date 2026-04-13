import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'activity_model.dart';
import 'activity_detail_page.dart';

class DramaActivitiesPage extends StatelessWidget {
  const DramaActivitiesPage({super.key});

  /// Act 1 — plays in order in [ActivitySessionPage].
  static const List<String> _everydayObjectsAct1Videos = [
    'assets/videos/everyday_objects_act1/01.mp4',
    'assets/videos/everyday_objects_act1/02.mp4',
    'assets/videos/everyday_objects_act1/03.mp4',
    'assets/videos/everyday_objects_act1/04.mp4',
    'assets/videos/everyday_objects_act1/05.mp4',
    'assets/videos/everyday_objects_act1/06.mp4',
    'assets/videos/everyday_objects_act1/07.mp4',
    'assets/videos/everyday_objects_act1/08.mp4',
    'assets/videos/everyday_objects_act1/09.mp4',
    'assets/videos/everyday_objects_act1/10.mp4',
    'assets/videos/everyday_objects_act1/11.mp4',
    'assets/videos/everyday_objects_act1/12.mp4',
  ];

  /// Act 2 — The Roles We Play (8 parts).
  static const List<String> _rolesWePlayAct2Videos = [
    'assets/videos/roles_we_play_act2/01.mp4',
    'assets/videos/roles_we_play_act2/02.mp4',
    'assets/videos/roles_we_play_act2/03.mp4',
    'assets/videos/roles_we_play_act2/04.mp4',
    'assets/videos/roles_we_play_act2/05.mp4',
    'assets/videos/roles_we_play_act2/06.mp4',
    'assets/videos/roles_we_play_act2/07.mp4',
    'assets/videos/roles_we_play_act2/08.mp4',
  ];

  final List<Activity> _activities = const [
    Activity(
      title: 'Everyday Objects, Inner Reflections',
      description: 'Turn everyday objects into mirrors for your thoughts and emotions.',
      duration: '12 mins',
      location: 'Creative Space',
      imagePath: 'assets/everydayobjects6.png',
      imageColors: [Color(0xFFE8D5B7), Color(0xFFA8C5D1), Color(0xFF8B4513)],
      facilitatorName: 'Sohail Al-Mahri',
      facilitatorImagePath: 'assets/sohail.jpg',
      fullDescription:
          'A gentle, drama-inspired exercise to help you reflect on your current emotional state using simple, familiar objects around you. This activity invites you to create a symbolic arrangement and explore the stories it reveals, offering insight, clarity, and connection with yourself.',
      flowSteps: [
        ActivityFlowStep(
          title: 'Introduction',
          description: 'Settle into your space and prepare your materials.',
          iconAsset: 'assets/flow_icon_intro.png',
          icon: Icons.chat_bubble_outline,
        ),
        ActivityFlowStep(
          title: 'Activity',
          description: 'Create a visual arrangement using your objects.',
          iconAsset: 'assets/flow_icon_activity.png',
          icon: Icons.apps,
        ),
        ActivityFlowStep(
          title: 'Reflection',
          description: 'Explore the meaning behind your arrangement.',
          iconAsset: 'assets/flow_icon_reflection.png',
          icon: Icons.psychology_outlined,
        ),
      ],
      materials: [
        ActivityMaterial(
          label: '5 everyday objects',
          iconAsset: 'assets/material_icon_objects.png',
        ),
        ActivityMaterial(
          label: 'Journal (optional)',
          iconAsset: 'assets/material_icon_journal.png',
        ),
        ActivityMaterial(
          label: 'Blank sheet of paper/ base to place objects',
          iconAsset: 'assets/material_icon_paper.png',
        ),
      ],
      sessionVideoAssets: _everydayObjectsAct1Videos,
    ),
    Activity(
      title: 'The Roles We Play',
      description: 'Explore the roles you play each day, and how they shape your emotional world.',
      duration: '10 mins',
      location: 'Anywhere',
      imagePath: 'assets/roles7.png',
      imageColors: [Color(0xFF1A2E3A), Color(0xFF2D4A5A), Color(0xFF4A8A9A)],
      sessionVideoAssets: _rolesWePlayAct2Videos,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F3B40), // Dark teal background
      body: Column(
        children: [
          // Header image section - extends to top
          Stack(
            children: [
              // Header image
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  'assets/drama3.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1A2E3A),
                            Color(0xFF2D4A5A),
                            Color(0xFF3D6B7A),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // SafeArea for status bar
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
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
            ],
          ),
          // Title and subtitle section - left aligned
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1F3B40),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Drama',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Play, role and story to explore emotion.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Activities list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                return _ActivityCard(activity: _activities[index]);
              },
            ),
          ),
          ],
        ),
    );
  }
}

class _ActivityCard extends StatefulWidget {
  final Activity activity;

  const _ActivityCard({required this.activity});

  @override
  State<_ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<_ActivityCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F3B40).withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image on top - full width, same left edge as content below
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: widget.activity.imagePath != null
                      ? Image.asset(
                          widget.activity.imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return CustomPaint(
                              painter: _ActivityImagePainter(widget.activity.imageColors),
                              size: Size.infinite,
                            );
                          },
                        )
                      : CustomPaint(
                          painter: _ActivityImagePainter(widget.activity.imageColors),
                          size: Size.infinite,
                        ),
                ),
              ),
              // Favorite and arrow on top of image
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              _isFavorited ? Icons.favorite : Icons.favorite_border,
                              color: _isFavorited ? Colors.red : Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ActivityDetailPage(
                              activity: widget.activity,
                              modality: 'drama',
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Content directly below image - same left margin as image
          Text(
            widget.activity.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            widget.activity.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.activity.duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              widget.activity.location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom painter for activity images
class _ActivityImagePainter extends CustomPainter {
  final List<Color> colors;

  _ActivityImagePainter(this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Create abstract patterns for drama/theatrical theme
    for (int i = 0; i < colors.length; i++) {
      paint.color = colors[i].withOpacity(0.6);
      
      // Draw dramatic shapes
      if (i == 0) {
        // Draw spotlight-like circles
        canvas.drawCircle(
          Offset(size.width * 0.5, size.height * 0.3),
          size.width * 0.3,
          paint,
        );
      } else if (i == 1) {
        // Draw abstract shapes representing objects/roles
        canvas.drawRect(
          Rect.fromLTWH(
            size.width * 0.2,
            size.height * 0.5,
            size.width * 0.3,
            size.height * 0.3,
          ),
          paint,
        );
      } else {
        // Draw flowing, expressive shapes
        final path = Path();
        path.moveTo(size.width * 0.3, size.height * 0.6);
        path.quadraticBezierTo(
          size.width * 0.5,
          size.height * 0.8,
          size.width * 0.7,
          size.height * 0.6,
        );
        path.quadraticBezierTo(
          size.width * 0.5,
          size.height * 0.4,
          size.width * 0.3,
          size.height * 0.6,
        );
        canvas.drawPath(path, paint);
      }
    }

    // Add some texture with smaller shapes
    final random = math.Random(42);
    for (int i = 0; i < 10; i++) {
      paint.color = colors[i % colors.length].withOpacity(0.3);
      canvas.drawCircle(
        Offset(
          size.width * random.nextDouble(),
          size.height * random.nextDouble(),
        ),
        size.width * (0.05 + random.nextDouble() * 0.1),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
