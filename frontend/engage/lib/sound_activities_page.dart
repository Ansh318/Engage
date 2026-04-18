import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'activity_model.dart';
import 'activity_detail_page.dart';

class SoundActivitiesPage extends StatelessWidget {
  const SoundActivitiesPage({super.key});

  static const List<String> _createYourTuneVideos = [
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2010%20-%20Create%20your%20Tune%2001.mp4?alt=media&token=20955cd3-5385-4317-b349-4b66d8eeb249',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2010%20-%20Create%20your%20Tune%2002.mp4?alt=media&token=2d01cbf0-1453-4282-b483-a5912ef0fc65',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2010%20-%20Create%20your%20Tune%2003.mp4?alt=media&token=0fc88a30-0048-4f35-81e4-76264073cd06',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2010%20-%20Create%20your%20Tune%2004.mp4?alt=media&token=4f236ffe-83a1-4961-a487-770035d7bb52',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2010%20-%20Create%20your%20Tune%2005.mp4?alt=media&token=57c25313-d8f1-4325-a639-928309a900ff',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2010%20-%20Create%20your%20Tune%2006.mp4?alt=media&token=36821127-8cbd-414e-a6bf-5d6fee13e704',
  ];

  static const List<String> _feelThroughSoundVideos = [
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2011%20-%20Feel%20through%20sound%2001.mp4?alt=media&token=8221e828-d3df-4505-b560-52a37c89f2f8',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2011%20-%20Feel%20through%20sound%2002.mp4?alt=media&token=a2690cc1-28c9-409a-bd61-1cb732047d85',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2011%20-%20Feel%20through%20sound%2003.mp4?alt=media&token=78b034a6-5245-4c25-b56a-a0b1ac60819d',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2011%20-%20Feel%20through%20sound%2004.mp4?alt=media&token=2c537dd0-6f69-454a-8f12-2d305b64b3d1',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2011%20-%20Feel%20through%20sound%2005%20-%20Birdsong.mp4?alt=media&token=26c224bc-10ff-412e-99aa-2fdc0645764f',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2011%20-%20Feel%20through%20sound%2006%20-%20Forest.mp4?alt=media&token=34c4d9a3-7a06-4f2c-ad2f-aff038f2d021',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2011%20-%20Feel%20through%20sound%2007%20-%20Waterfall.mp4?alt=media&token=d54ee233-cc6e-4680-a65e-520ecc88a60f',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%2011%20-%20Feel%20through%20sound%2008.mp4?alt=media&token=632c9c5c-360c-4997-adb0-548430add8eb',
  ];

  final List<Activity> _activities = const [
    Activity(
      title: 'Create your tune',
      description: 'This activity invites you create your own rhythm using an instrument, or your body.',
      duration: '5 mins',
      location: 'Creative Space',
      imagePath: 'assets/tune3.png',
      imageColors: [Color(0xFF90EE90), Color(0xFFFFD700), Color(0xFF8B4513)],
      facilitatorName: 'Shravani Purandare',
      facilitatorImagePath: 'assets/shravani.jpeg',
      fullDescription:
          'This activity invites you create your own rhythm using an instrument, or your body. Follow simple prompts to create a short intuitive tune to help reflect on your present mood while engaging in a rhythmic flow state.',
      sessionVideoAssets: _createYourTuneVideos,
    ),
    Activity(
      title: 'Feel Through Sound',
      description: 'This sound-led activity guides you through different sounds to evoke thoughts, feelings and sensations.',
      duration: '8 mins',
      location: 'Anywhere',
      imagePath: 'assets/feelthroughsound3.png',
      imageColors: [Color(0xFF1E3A5F), Color(0xFF6B4C93), Color(0xFFFF6B35)],
      facilitatorName: 'Shravani Purandare',
      facilitatorImagePath: 'assets/shravani.jpeg',
      fullDescription:
          'This sound-led activity guides you through different sounds to evoke thoughts, feelings and sensations. Listen to short tunes and reflect on what they stir in you to identify themes, emotional states and recurring thoughts. No effort is required, just listen, feel, and reflect.',
      sessionVideoAssets: _feelThroughSoundVideos,
    ),
    Activity(
      title: 'Sway and Hymmm',
      description: 'Let sound guide your emotions, explore calm, energy, and reflection through music.',
      duration: '1 min',
      location: 'Anywhere',
      imagePath: 'assets/tune8.png',
      imageColors: [Color(0xFF90EE90), Color(0xFFFFD700), Color(0xFF87CEEB)],
      facilitatorName: 'Shravani Purandare',
      facilitatorImagePath: 'assets/shravani.jpeg',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ActivityDetailPage(
                              activity: widget.activity,
                              modality: 'sound',
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
