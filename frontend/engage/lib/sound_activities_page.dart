import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class SoundActivitiesPage extends StatelessWidget {
  const SoundActivitiesPage({super.key});

  final List<Activity> _activities = const [
    Activity(
      title: 'Create your tune',
      description: 'Let your intuition guide the music you create, and reflect on your present moment.',
      duration: '5 mins',
      location: 'Creative Space',
      imagePath: 'assets/tune3.png',
      imageColors: [Color(0xFF90EE90), Color(0xFFFFD700), Color(0xFF8B4513)],
    ),
    Activity(
      title: 'Feel Through Sound',
      description: 'Let music prompt your emotions, explore feelings, thoughts, and reflection through music.',
      duration: '8 mins',
      location: 'Anywhere',
      imagePath: 'assets/feelthroughsound3.png',
      imageColors: [Color(0xFF1E3A5F), Color(0xFF6B4C93), Color(0xFFFF6B35)],
    ),
    Activity(
      title: 'Sway and Hymmm',
      description: 'Let sound guide your emotions, explore calm, energy, and reflection through music.',
      duration: '1 min',
      location: 'Anywhere',
      imagePath: 'assets/tune8.png',
      imageColors: [Color(0xFF90EE90), Color(0xFFFFD700), Color(0xFF87CEEB)],
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
                  'assets/music1.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF5B3A7A),
                            Color(0xFF6B4C93),
                            Color(0xFFFF6B35),
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
                  'Sound',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Use your voice, breath, or sound to explore emotional state.',
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

class Activity {
  final String title;
  final String description;
  final String duration;
  final String location;
  final String? imagePath;
  final List<Color> imageColors;

  const Activity({
    required this.title,
    required this.description,
    required this.duration,
    required this.location,
    this.imagePath,
    required this.imageColors,
  });
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
                    ClipRRect(
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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

    // Create abstract patterns based on activity type
    for (int i = 0; i < colors.length; i++) {
      paint.color = colors[i].withOpacity(0.6);
      
      // Draw different shapes for variety
      if (i == 0) {
        // Draw circles
        canvas.drawCircle(
          Offset(size.width * 0.3, size.height * 0.3),
          size.width * 0.2,
          paint,
        );
      } else if (i == 1) {
        // Draw rectangles
        canvas.drawRect(
          Rect.fromLTWH(
            size.width * 0.5,
            size.height * 0.2,
            size.width * 0.3,
            size.height * 0.4,
          ),
          paint,
        );
      } else {
        // Draw paths for organic shapes
        final path = Path();
        path.moveTo(size.width * 0.2, size.height * 0.6);
        path.quadraticBezierTo(
          size.width * 0.5,
          size.height * 0.8,
          size.width * 0.8,
          size.height * 0.6,
        );
        path.quadraticBezierTo(
          size.width * 0.5,
          size.height * 0.4,
          size.width * 0.2,
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
