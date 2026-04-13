import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'survey_bottom_sheet.dart';
import 'art_activities_page.dart';
import 'sound_activities_page.dart';
import 'movement_activities_page.dart';
import 'drama_activities_page.dart';
import 'storytelling_activities_page.dart';
import 'profile_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedIndex = 1; // Explore is selected

  final List<ModalityItem> _modalities = [
    ModalityItem(
      title: 'Art',
      description: 'Express through colour, shape, and image.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF8B1538),
          Color(0xFFB83D5E),
          Color(0xFFD67A8F),
          Color(0xFFE8A5B5),
        ],
      ),
      imagePath: 'assets/art1.png',
    ),
    ModalityItem(
      title: 'Sound',
      description: 'Use you voice, breath or sound to shift state.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF5B3A7A),
          Color(0xFF6B4C93),
          Color(0xFFFF6B35),
          Color(0xFFFFA500),
        ],
      ),
      imagePath: 'assets/music1.png',
    ),
    ModalityItem(
      title: 'Drama',
      description: 'Explore emotions through performance and storytelling.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A2E3A),
          Color(0xFF2D4A5A),
          Color(0xFF3D6B7A),
          Color(0xFF4A8A9A),
        ],
      ),
      imagePath: 'assets/drama3.png',
    ),
    ModalityItem(
      title: 'Movement',
      description: 'Connect body and mind through physical expression.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2D5016), Color(0xFF4A7C2A), Color(0xFF6BA84F)],
      ),
      imagePath: 'assets/movement1.png',
    ),
    ModalityItem(
      title: 'Storytelling',
      description: 'Share narratives that shape understanding.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF6B2C5A),
          Color(0xFF8B3D6A),
          Color(0xFFAD5A7A),
          Color(0xFFCF7A9A),
        ],
      ),
      imagePath: 'assets/story5.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F3B40), // Dark teal background
      body: SafeArea(
        child: Column(
          children: [
            // Top section - "Let's check in" Survey
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Not sure where to start?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Let\'s check in.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Answer 3 questions, and we\'ll suggest something made for this moment.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const SurveyBottomSheet(),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Take survey',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
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
            ),

            // Middle section - Modalities
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How would you like to engage right now?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Go with what feels right.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ..._modalities.map(
                      (modality) => _ModalityItemCard(modality: modality),
                    ),
                    const SizedBox(height: 40),
                    // Explore Activities section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Explore Activities',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.tune,
                          color: Colors.white.withOpacity(0.7),
                          size: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Go with what feels right.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Activity cards
                    _buildActivityCard(
                      title: 'Grounding with a Pencil',
                      description:
                          'Draw a freehand shape and reconnect with yourself through mindful movement.',
                      duration: '7 mins',
                      location: 'Anywhere',
                      imageColors: [
                        Color(0xFFE8D5B7),
                        Color(0xFFA8C5D1),
                        Color(0xFFF5F5DC),
                      ],
                      imagePath: 'assets/groundingpencil1.png',
                      isFavorite: false,
                      showDetails: true,
                    ),
                    const SizedBox(height: 16),
                    _buildActivityCard(
                      title: 'Body Scan',
                      description:
                          'A guided scan to reconnect with your body, one breath and sensation at a time.',
                      duration: '7 mins',
                      location: 'Anywhere',
                      imageColors: [
                        Color(0xFF2D5016),
                        Color(0xFF4A7C2A),
                        Color(0xFF6BA84F),
                      ],
                      imagePath: 'assets/bodyscan6.png',
                      isFavorite: false,
                      showDetails: true,
                    ),
                    const SizedBox(height: 16),
                    _buildActivityCard(
                      title: 'Paper play',
                      description:
                          'Use and deform papers to explore how you feel, create your own art arrangement.',
                      duration: '20 mins',
                      location: 'Creative Space',
                      imageColors: [
                        Color(0xFFD3D3D3),
                        Color(0xFFE8D5B7),
                        Color(0xFF90EE90),
                      ],
                      imagePath: 'assets/paper2.png',
                      isFavorite: false,
                      showDetails: true,
                    ),
                    const SizedBox(height: 40),
                    // Explore Blogs section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Explore Blogs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Go with what feels right.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Blog cards
                    _buildBlogCard(
                      title: 'Unlocking Clarity',
                      description: 'The Surprising Power of Art Making for...',
                      imageColors: [
                        Color(0xFFFFD700),
                        Color(0xFFFF6B35),
                        Color(0xFF4A8A9A),
                        Color(0xFF90EE90),
                      ],
                      imagePath: 'assets/artblog6.png',
                    ),
                    const SizedBox(height: 16),
                    _buildBlogCard(
                      title: 'The Power of gentle Move...',
                      description: 'Enhancing Wellbeing and Mental Health...',
                      imageColors: [
                        Color(0xFFFF6B35),
                        Color(0xFF4A8A9A),
                        Color(0xFF2D5016),
                      ],
                      imagePath: 'assets/movementblog2.png',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom navigation bar - no SafeArea to prevent overflow
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 12 + MediaQuery.of(context).padding.bottom,
          top: 0,
        ),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF1A2E35),
            borderRadius: BorderRadius.circular(40),
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.12),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _BottomNavItem(
                  icon: Icons.home,
                  label: 'home',
                  isSelected: _selectedIndex == 0,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                _BottomNavItem(
                  icon: Icons.explore,
                  label: 'explore',
                  isSelected: _selectedIndex == 1,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.person,
                  label: 'profile',
                  isSelected: _selectedIndex == 2,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    String? description,
    String? duration,
    String? location,
    required List<Color> imageColors,
    String? imagePath,
    bool isFavorite = false,
    bool showDetails = false,
  }) {
    return Container(
      height: showDetails ? 200 : 160,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          // Background image/gradient
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imagePath != null
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: imageColors,
                        ),
                      ),
                      child: CustomPaint(painter: _ActivityImagePainter()),
                    ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag and favorite icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
                if (showDetails) ...[
                  const Spacer(),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (duration != null)
                        _buildInfoTag(Icons.access_time, duration),
                      if (location != null) ...[
                        const SizedBox(width: 8),
                        _buildInfoTag(Icons.location_on, location),
                      ],
                      const Spacer(),
                      ClipRRect(
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
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(
                text,
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
    );
  }

  Widget _buildBlogCard({
    required String title,
    required String description,
    required List<Color> imageColors,
    String? imagePath,
  }) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F3B40).withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          // Text content
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          // Image
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (imagePath != null)
                    Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: imageColors,
                        ),
                      ),
                      child: CustomPaint(painter: _BlogImagePainter()),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModalityItem {
  final String title;
  final String description;
  final LinearGradient gradient;
  final String imagePath;

  ModalityItem({
    required this.title,
    required this.description,
    required this.gradient,
    required this.imagePath,
  });
}

class _ModalityItemCard extends StatelessWidget {
  final ModalityItem modality;

  const _ModalityItemCard({required this.modality});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (modality.title == 'Art') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ArtActivitiesPage()),
          );
        } else if (modality.title == 'Sound') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SoundActivitiesPage(),
            ),
          );
        } else if (modality.title == 'Movement') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MovementActivitiesPage(),
            ),
          );
        } else if (modality.title == 'Drama') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DramaActivitiesPage(),
            ),
          );
        } else if (modality.title == 'Storytelling') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const StorytellingActivitiesPage(),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F3B40).withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: Row(
          children: [
            // Illustration on the left
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                modality.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to gradient container if image fails to load
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: modality.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Text content in the middle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    modality.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    modality.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Arrow icon on the right
            const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}

class _ActivityImagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw abstract patterns
    for (int i = 0; i < 5; i++) {
      final angle = (i / 5) * math.pi * 2;
      final radius = size.width * (0.2 + (i % 2) * 0.1);
      final x = size.width * 0.5 + math.cos(angle) * radius;
      final y = size.height * 0.5 + math.sin(angle) * radius;

      paint.color = Colors.white.withOpacity(0.1);
      canvas.drawCircle(Offset(x, y), size.width * 0.1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BlogImagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw abstract colorful patterns
    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * math.pi * 2;
      final radius = size.width * (0.15 + (i % 3) * 0.05);
      final x = size.width * 0.5 + math.cos(angle) * radius;
      final y = size.height * 0.5 + math.sin(angle) * radius;

      paint.color = Colors.white.withOpacity(0.15 + (i % 3) * 0.05);
      canvas.drawCircle(
        Offset(x, y),
        size.width * (0.08 + (i % 2) * 0.03),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          size: 20,
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.22),
                    Colors.white.withOpacity(0.12),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Center(child: content),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Center(child: content),
            ),
    );
  }
}
