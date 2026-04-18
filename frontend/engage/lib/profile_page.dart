import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

import 'api/engage_api.dart';
import 'services/session_store.dart';
import 'settings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  EngageUser? _user;

  Map<String, int> _checkInPct = {
    'regulated': 0,
    'energized': 0,
    'tense': 0,
    'low': 0,
  };
  Map<String, int> _checkOutPct = {
    'regulated': 0,
    'energized': 0,
    'tense': 0,
    'low': 0,
  };
  bool _journeyCheckIn = true;
  bool _journeyLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadEmotionJourney();
  }

  int _zonePct(String zoneKey) {
    final src = _journeyCheckIn ? _checkInPct : _checkOutPct;
    return src[zoneKey] ?? 0;
  }

  Future<void> _loadEmotionJourney() async {
    final token = await SessionStore.getToken();
    if (!mounted) return;
    if (token == null) {
      setState(() => _journeyLoading = false);
      return;
    }
    try {
      final stats = await engageApi.getEmotionJourneyStats(token);
      if (!mounted) return;
      setState(() {
        _checkInPct = stats.checkInPercentages;
        _checkOutPct = stats.checkOutPercentages;
        _journeyLoading = false;
      });
    } catch (e) {
      debugPrint('ProfilePage emotion journey: $e');
      if (mounted) setState(() => _journeyLoading = false);
    }
  }

  Future<void> _loadUser() async {
    final token = await SessionStore.getToken();
    if (!mounted) return;
    if (token == null) return;
    try {
      final user = await engageApi.getMe(token);
      if (mounted) setState(() => _user = user);
    } catch (e) {
      debugPrint('ProfilePage getMe: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F3B40),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Picture and Info
              _buildProfileHeader(),
              const SizedBox(height: 30),
              // Settings and Favourites buttons
              _buildActionButtons(context),
              const SizedBox(height: 30),
              // All time Stats
              _buildAllTimeStats(),
              const SizedBox(height: 20),
              // Daily Reflection Streak
              _buildDailyReflectionStreak(),
              const SizedBox(height: 20),
              // My Emotional Journey
              _buildEmotionalJourney(),
              const SizedBox(height: 20),
              // My Journal
              _buildMyJournal(),
              const SizedBox(height: 100), // Space for bottom nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Profile Picture
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFB6C1), // Light pink background
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Container(
              color: const Color(0xFFFFB6C1),
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Name
        Text(
          _user == null
              ? '…'
              : (_user!.firstName.trim().isNotEmpty
                  ? _user!.firstName.trim()
                  : 'Member'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Email
        Text(
          _user?.email ?? '…',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            child: _buildActionButton(
              icon: Icons.settings,
              label: 'Settings',
            ),
          ),
          _buildActionButton(
            icon: Icons.favorite_border,
            label: 'Favourites',
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label}) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAllTimeStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All time Stats',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F3B40).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildStatRow('Activities Completed', '456'),
                    const SizedBox(height: 16),
                    _buildStatRow('Minutes Engaged', '60 mins'),
                    const SizedBox(height: 16),
                    _buildStatRow('Most engaged modality', 'Drama'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyReflectionStreak() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1F3B40).withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Reflection Streak',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Every small step adds up. Keep showing up for yourself.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF066B85).withOpacity(0.32),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64,
                              height: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Day Streak',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40 / 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 118,
                        height: 118,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.cyanAccent.withOpacity(0.15),
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.cyanAccent.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Image.asset(
                                'assets/Fire Streaks 1.png',
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Center(
                                  child: Text(
                                    '🔥',
                                    style: TextStyle(fontSize: 40),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmotionalJourney() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1F3B40).withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Emotional Journey',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'See how your creative check-ins have shaped your mood over time.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _journeyCheckIn = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _journeyCheckIn
                                ? const Color(0xFF1F3B40).withOpacity(0.8)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Check In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight:
                                    _journeyCheckIn ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _journeyCheckIn = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !_journeyCheckIn
                                ? const Color(0xFF1F3B40).withOpacity(0.8)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Check Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight:
                                    !_journeyCheckIn ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (_journeyLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 28),
                    child: Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _EmotionMeter(
                          label: 'Regulated',
                          percentage: _zonePct('regulated'),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: _EmotionMeter(
                          label: 'Energized',
                          percentage: _zonePct('energized'),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: _EmotionMeter(
                          label: 'Tense',
                          percentage: _zonePct('tense'),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: _EmotionMeter(
                          label: 'Low',
                          percentage: _zonePct('low'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyJournal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1F3B40).withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Journal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your space to revisit thoughts, feelings, and creative moments.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Notebook illustration placeholder
                      Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: CustomPaint(
                          painter: _NotebookPainter(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Padding(
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
                isSelected: false,
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _BottomNavItem(
                icon: Icons.explore,
                label: 'explore',
                isSelected: false,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              _BottomNavItem(
                icon: Icons.person,
                label: 'profile',
                isSelected: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmotionMeter extends StatelessWidget {
  final String label;
  final int percentage;

  const _EmotionMeter({
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        if (w <= 0) {
          return const SizedBox.shrink();
        }
        // Fit ring + label inside each Expanded slot (avoids horizontal overflow).
        final ring = w.clamp(48.0, 92.0);
        final inner = ring * (56 / 92);
        final stroke = (15 * ring / 92).clamp(5.0, 15.0);
        final pctSize = (16 * ring / 92).clamp(10.0, 16.0);
        final labelSize = (12 * ring / 92).clamp(8.0, 12.0);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: ring,
                height: ring,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: ring,
                      height: ring,
                      child: CircularProgressIndicator(
                        value: percentage / 100,
                        strokeWidth: stroke,
                        backgroundColor: const Color(0xFF0B7F99).withOpacity(0.55),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Color(0xFF00D3F6)),
                      ),
                    ),
                    Container(
                      width: inner,
                      height: inner,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF006A84),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$percentage%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: pctSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: math.max(6.0, 12 * ring / 92)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: math.max(5.0, 8 * ring / 92),
                  horizontal: 4,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.17),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.55),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: labelSize,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
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

class _NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw notebook pages
    // Left page with wavy edge
    final leftPath = Path();
    leftPath.moveTo(0, 0);
    leftPath.lineTo(size.width * 0.4, 0);
    leftPath.lineTo(size.width * 0.4, size.height);
    leftPath.lineTo(0, size.height);
    leftPath.close();

    // Add wavy edge
    for (double y = 0; y < size.height; y += 3) {
      leftPath.lineTo(
        size.width * 0.4 + math.sin(y * 0.5) * 2,
        y,
      );
    }

    canvas.drawPath(leftPath, paint);

    // Right page
    final rightPath = Path();
    rightPath.moveTo(size.width * 0.4, 0);
    rightPath.lineTo(size.width, 0);
    rightPath.lineTo(size.width, size.height);
    rightPath.lineTo(size.width * 0.4, size.height);
    rightPath.close();
    canvas.drawPath(rightPath, paint);

    // Draw dark area on right page
    final darkPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.5, size.height * 0.2, size.width * 0.4, size.height * 0.6),
      darkPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
