import 'package:flutter/material.dart';
import 'dart:ui';
import 'activity_model.dart';
import 'activity_detail_page.dart';

class StorytellingActivitiesPage extends StatelessWidget {
  const StorytellingActivitiesPage({super.key});

  static const List<String> _letterToPartOfYourselfVideos = [
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2001.mp4?alt=media&token=5e5f25bd-3a49-4300-960c-6ccf1cad8b35',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2002.mp4?alt=media&token=15300bc9-8517-4919-a697-b87642833c14',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2003.mp4?alt=media&token=875e2026-bdf0-45bc-8ac1-d1fe8368e93b',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2004.mp4?alt=media&token=93143498-113f-4bf6-80aa-0e9bac6f92e6',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2005.mp4?alt=media&token=0fcf7176-47a7-4d32-81aa-4087c13c0816',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2006.mp4?alt=media&token=4b712ef9-84de-4c87-96e5-118f91432a02',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2007.mp4?alt=media&token=c7287d59-46bb-495b-b987-75cf9d202385',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2008.mp4?alt=media&token=5485461d-f52e-42c2-b263-1cd6beb8eaeb',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%2009.mp4?alt=media&token=d6e2b134-871a-470f-994f-109fe9d79fa0',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%20010.mp4?alt=media&token=6df98d8f-24f4-4fd3-a8a1-c932756c37dd',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%20011.mp4?alt=media&token=80799045-378e-447b-b192-4548708287d8',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/VIdeo%208%20-%20Letter%20to%20part%20of%20yourself%20012.mp4?alt=media&token=cb514793-2bf1-4980-acb3-304a1e0ef03f',
  ];

  static const List<String> _symbolsOfReflectionVideos = [
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%209%20-%20Symbols%20of%20reflection%2001.mp4?alt=media&token=66c326fe-f8d2-45c9-9316-13d6083f7b98',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%209%20-%20Symbols%20of%20reflection%2002.mp4?alt=media&token=5480979a-5087-4e6f-ade2-4f2610173b0e',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%209%20-%20Symbols%20of%20reflection%2003.mp4?alt=media&token=8fb14603-bac5-401b-8a7b-707d14202f0d',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%209%20-%20Symbols%20of%20reflection%2004.mp4?alt=media&token=c7a3fa78-9eb6-4e7e-a1e6-61fcc58dbe53',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%209%20-%20Symbols%20of%20reflection%2005.mp4?alt=media&token=8550df1a-19c9-4330-9e65-0c7ae3a88fe2',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%209%20-%20Symbols%20of%20reflection%2006.mp4?alt=media&token=276ce2fc-d8ce-4ad1-b10a-72faa5142aa4',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%209%20-%20Symbols%20of%20reflection%2007.mp4?alt=media&token=5b7e536b-8da1-4476-9683-020466694f08',
    'https://firebasestorage.googleapis.com/v0/b/engage-a9a72.firebasestorage.app/o/Video%209%20-%20Symbols%20of%20reflection%2008.mp4?alt=media&token=ef82452a-904b-4195-bcf6-27992f0d1d53',
  ];

  final List<Activity> _activities = const [
    Activity(
      title: 'A Letter to a Part of Myself',
      description: 'This gentle storytelling and reflection activity invites you to write a short letter to a part of yourself.',
      duration: '10 mins',
      location: 'Anywhere',
      imagePath: 'assets/lettertomyself4.png',
      imageColors: [Color(0xFF4A8A9A), Color(0xFF90EE90), Color(0xFFFFD700)],
      facilitatorName: 'Chloë Hobden',
      facilitatorImagePath: 'assets/chloe.jpeg',
      fullDescription:
          "This gentle storytelling and reflection activity invites you to write a short letter to a part of yourself, maybe one you're struggling with, one that's been loud lately, or one you've forgotten to listen to. Through writing, you'll create space for deeper self-connection, compassion, and emotional insight.",
      sessionVideoAssets: _letterToPartOfYourselfVideos,
    ),
    Activity(
      title: 'Symbols of reflection',
      description: 'This activity invites you to listen to short stories from around the world to explore symbols, narratives and perspectives.',
      duration: '15 mins',
      location: 'Anywhere',
      imagePath: 'assets/symbols1.png',
      imageColors: [Color(0xFFFFD700), Color(0xFF90EE90), Color(0xFF87CEEB)],
      facilitatorName: 'Chloë Hobden',
      facilitatorImagePath: 'assets/chloe.jpeg',
      fullDescription:
          'This activity invites you to listen to short stories from around the world to explore symbols, narratives and perspectives. Choose from different themes that resonate with you and dive into an imaginary world where you can connect with different characters and rewrite your endings.',
      sessionVideoAssets: _symbolsOfReflectionVideos,
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
                  'assets/story5.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF6B2C5A),
                            Color(0xFF8B3D6A),
                            Color(0xFFAD5A7A),
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
                  'Storytelling',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Put words to feeling. Write it out, speak it in.',
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
                              modality: 'storytelling',
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

    // Create abstract patterns for storytelling/writing theme
    for (int i = 0; i < colors.length; i++) {
      paint.color = colors[i].withOpacity(0.6);
      
      // Draw flowing, narrative shapes
      if (i == 0) {
        // Draw book-like shapes
        canvas.drawRect(
          Rect.fromLTWH(
            size.width * 0.3,
            size.height * 0.2,
            size.width * 0.4,
            size.height * 0.5,
          ),
          paint,
        );
      } else if (i == 1) {
        // Draw flowing lines like writing
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 3;
        paint.color = colors[i].withOpacity(0.8);
        
        final path = Path();
        path.moveTo(size.width * 0.2, size.height * 0.5);
        path.quadraticBezierTo(
          size.width * 0.4,
          size.height * 0.3,
          size.width * 0.6,
          size.height * 0.5,
        );
        path.quadraticBezierTo(
          size.width * 0.8,
          size.height * 0.7,
          size.width * 0.6,
          size.height * 0.9,
        );
        canvas.drawPath(path, paint);
        
        paint.style = PaintingStyle.fill;
      } else {
        // Draw glowing, ethereal shapes
        final path = Path();
        path.moveTo(size.width * 0.4, size.height * 0.6);
        path.quadraticBezierTo(
          size.width * 0.6,
          size.height * 0.4,
          size.width * 0.8,
          size.height * 0.6,
        );
        path.quadraticBezierTo(
          size.width * 0.6,
          size.height * 0.8,
          size.width * 0.4,
          size.height * 0.6,
        );
        canvas.drawPath(path, paint);
      }
    }

    // Add golden flowing lines effect
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = colors[1].withOpacity(0.4);
    
    for (int i = 0; i < 3; i++) {
      final path = Path();
      final startX = size.width * (0.2 + i * 0.2);
      final startY = size.height * 0.3;
      path.moveTo(startX, startY);
      path.quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.5,
        size.width * (0.8 - i * 0.2),
        size.height * 0.7,
      );
      canvas.drawPath(path, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
