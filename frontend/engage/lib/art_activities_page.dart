import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'activity_model.dart';
import 'activity_detail_page.dart';

class ArtActivitiesPage extends StatelessWidget {
  const ArtActivitiesPage({super.key});

  static const List<String> _groundingWithPencilVideos = [
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%201%20-%20Act9Art%2001.mp4?alt=media&token=6debbb1c-8b0d-4684-9c90-f73f56173077',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%201%20-%20Act9Art%2002.mp4?alt=media&token=3f48fc33-a68d-459b-b475-bc6de0c1aa7d',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%201%20-%20Act9Art%2003.mp4?alt=media&token=d3401788-e0a7-46db-baf3-0ba6fd5df1d0',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%201%20-%20Act9Art%2004.mp4?alt=media&token=4a700e92-fc60-4753-8214-cdc49f1c2361',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%201%20-%20Act9Art%2005.mp4?alt=media&token=d3a0d482-4eac-4677-a2c7-24b610abea0f',
  ];

  static const List<String> _paperPlayVideos = [
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2001.mp4?alt=media&token=9e90104f-780a-4210-95dc-2f7a5ba1fd0a',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2002.mp4?alt=media&token=2e798efa-95fd-4fd5-bdd3-397ef11d48ea',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2003.mp4?alt=media&token=81f4859e-1316-4a04-9d98-046ba757e7eb',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2004.mp4?alt=media&token=e59cdea0-c14f-488a-89e7-4062dbef9a4c',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2005.mp4?alt=media&token=411988af-1790-4619-99f2-5951d34eea4e',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2006.mp4?alt=media&token=2ec568c6-ee10-4b51-ab4c-8ae9eeef4e06',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2007.mp4?alt=media&token=925353bd-fa30-4da8-b5cf-dbdee21b8ddb',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2008.mp4?alt=media&token=b363a184-e7b1-4f60-9c7b-5129df3ff602',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%203%20-%20Paper%20Play%2009.mp4?alt=media&token=a58b25d2-7cf2-444f-b238-238500924319',
  ];

  static const List<String> _natureDrawingVideos = [
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2001.mp4?alt=media&token=134130da-81a1-44ad-a850-689d0b6490dd',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2002.mp4?alt=media&token=cb997559-58ed-4191-8ec1-18670ceabf55',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2003.mp4?alt=media&token=2c4f7849-3a11-4953-991a-c4df7cca8de8',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2004.mp4?alt=media&token=e41bcda4-23eb-42fa-8382-f3cd7ebb1315',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2005.mp4?alt=media&token=e4152be8-57da-4340-a635-43d1565a311f',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2006.mp4?alt=media&token=2216161b-c3ed-49f1-a069-ccd1c1196527',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2007.mp4?alt=media&token=65f89caa-63d2-4934-8347-6e37ae974f1c',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2008.mp4?alt=media&token=105ff5a3-0c0c-4be8-9c0b-9a8f7d3ea0a1',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%2009.mp4?alt=media&token=b466daa9-6fef-45d5-bdc5-9a82e99bfa25',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%202%20-%20Act8%20Nature%20Drawing%20010.mp4?alt=media&token=a8e4fe38-f702-4baa-9d6d-9aa3e643ed84',
  ];

  static const List<Activity> _activities = [
    Activity(
      title: 'Grounding with a Pencil',
      description: 'This gentle art-based activity uses simple pencil movements to help you ground in the present moment.',
      duration: '7 mins',
      location: 'Anywhere',
      imagePath: 'assets/groundingpencil1.png',
      imageColors: [Color(0xFFE8D5B7), Color(0xFFA8C5D1), Color(0xFFF5F5DC)],
      facilitatorName: 'Lucy Steggals',
      facilitatorImagePath: 'assets/Lucy Image .jpg',
      fullDescription:
          "This gentle art-based activity uses simple pencil movements to help you ground in the present moment. With breath, touch, and creative flow, you'll create an intuitive shape and fill it with patterns or colours, not to produce a perfect drawing, but to settle your mind and reconnect with your body. The focus is not on what you make, but how you feel while making it.",
      sessionVideoAssets: _groundingWithPencilVideos,
    ),
    Activity(
      title: 'Nature Drawing',
      description: 'This creative art-based activity invites you to tune into your emotions and express them through color, shape, and form inspired by nature.',
      duration: '25 mins',
      location: 'Creative Space',
      imagePath: 'assets/nature2.png',
      imageColors: [Color(0xFFE8D5B7), Color(0xFFA8C5D1), Color(0xFFFFD700)],
      facilitatorName: 'Lucy Steggals',
      facilitatorImagePath: 'assets/Lucy Image .jpg',
      fullDescription:
          "This creative art-based activity invites you to tune into your emotions and express them through color, shape, and form inspired by nature. Using simple prompts and materials you already have at home, you'll create a visual representation of your current mood, without worrying about what it \"should\" look like. It's about process, not perfection.",
      flowSteps: [
        ActivityFlowStep(
          title: 'Introduction',
          description: 'Check in with your surroundings and connect with nature.',
          iconAsset: 'assets/flow_icon_intro.png',
          icon: Icons.chat_bubble_outline,
        ),
        ActivityFlowStep(
          title: 'Create',
          description: 'Create a simple nature-inspired image using prompts.',
          iconAsset: 'assets/flow_icon_activity.png',
          icon: Icons.palette_outlined,
        ),
        ActivityFlowStep(
          title: 'Reflection',
          description: 'Explore the meaning behind your creation.',
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
          label: 'Base to place objects',
          iconAsset: 'assets/material_icon_paper.png',
        ),
      ],
      sessionVideoAssets: _natureDrawingVideos,
    ),
    Activity(
      title: 'Paper play',
      description: "This art-based activity invites you to tune into your current emotional state through deforming and playing with different textures of paper.",
      duration: '20 mins',
      location: 'Creative Space',
      imagePath: 'assets/paper2.png',
      imageColors: [Color(0xFFD3D3D3), Color(0xFFE8D5B7), Color(0xFF90EE90)],
      facilitatorName: 'Lucy Steggals',
      facilitatorImagePath: 'assets/Lucy Image .jpg',
      fullDescription:
          "This art-based activity invites you to tune into your current emotional state through deforming and playing with different textures of paper. You'll select shapes that reflect what you're feeling and then bring them together to create a small arrangement. This is not about making something perfect, it's about expressing, releasing, and becoming more aware of your emotional landscape.",
      sessionVideoAssets: _paperPlayVideos,
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
                  'assets/art1.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF8B1538),
                            Color(0xFFB83D5E),
                            Color(0xFFD67A8F),
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
                  'Art',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Express through colour, shape, and image.',
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
                              modality: 'art',
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
