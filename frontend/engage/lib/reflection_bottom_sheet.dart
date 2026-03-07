import 'package:flutter/material.dart';
import 'dart:math' as math;

class ReflectionBottomSheet extends StatefulWidget {
  const ReflectionBottomSheet({super.key});

  @override
  State<ReflectionBottomSheet> createState() => _ReflectionBottomSheetState();
}

class _ReflectionBottomSheetState extends State<ReflectionBottomSheet> {
  final TextEditingController _thoughtsController = TextEditingController();
  final Set<String> _selectedTags = {};

  final List<String> _availableTags = [
    'Calmness',
    'Chaos',
    'Curiosity',
    'Energy',
    'Peace',
  ];

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  void dispose() {
    _thoughtsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF0F1C20), // Very dark teal/almost black background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question text
                  const Text(
                    'What does this image stir in you?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Abstract image card
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomPaint(
                        painter: _AbstractReflectionPainter(),
                        size: Size.infinite,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Image credits
                  Text(
                    'Image credits : Name of the artist',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tag buttons
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _availableTags.map((tag) {
                      final isSelected = _selectedTags.contains(tag);
                      return GestureDetector(
                        onTap: () => _toggleTag(tag),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF1E7B8C).withOpacity(0.3)
                                : const Color(0xFF1F3B40).withOpacity(0.8),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tag,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                isSelected ? Icons.check : Icons.add,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Add thoughts input field
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF1F3B40),
                          Color(0xFF1F3B40),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _thoughtsController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Add thoughts',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E7B8C),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the abstract reflection image
class _AbstractReflectionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient
    final backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF1A2E3A),
        const Color(0xFF0A1A1A),
        const Color(0xFF1A0A0A),
        const Color(0xFF3A0A0A),
      ],
    );

    final backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final backgroundPaint = Paint()
      ..shader = backgroundGradient.createShader(backgroundRect);
    canvas.drawRect(backgroundRect, backgroundPaint);

    // Create marbled/swirling effect
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Blue/white swirling patterns (top and center-left)
    for (int i = 0; i < 15; i++) {
      final angle = (i / 15) * math.pi * 2;
      final x = size.width * (0.2 + math.cos(angle) * 0.3);
      final y = size.height * (0.2 + math.sin(angle) * 0.2);

      paint.color = Colors.white.withOpacity(0.15 + (i % 3) * 0.05);
      canvas.drawCircle(
        Offset(x, y),
        size.width * (0.08 + (i % 3) * 0.02),
        paint,
      );
    }

    // Blue/teal swirls
    final bluePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF2D4A5A).withOpacity(0.4);

    for (int i = 0; i < 8; i++) {
      final centerX = size.width * (0.1 + i * 0.1);
      final centerY = size.height * (0.15 + (i % 3) * 0.1);
      final radius = size.width * (0.1 + (i % 2) * 0.05);

      canvas.drawCircle(
        Offset(centerX, centerY),
        radius,
        bluePaint,
      );
    }

    // Red/orange fiery patterns (bottom and right)
    final redPaint = Paint()
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final x = size.width * (0.5 + (i % 10) * 0.05);
      final y = size.height * (0.6 + (i % 8) * 0.05);
      final opacity = 0.2 + (i % 4) * 0.1;

      redPaint.color = const Color(0xFF8B1F2A).withOpacity(opacity);
      canvas.drawCircle(
        Offset(x, y),
        size.width * (0.03 + (i % 3) * 0.02),
        redPaint,
      );
    }

    // Dark swirling patterns in the middle
    final darkPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF0A0A0A).withOpacity(0.6);

    for (int i = 0; i < 5; i++) {
      final path = Path();
      final centerX = size.width * (0.4 + i * 0.1);
      final centerY = size.height * (0.4 + i * 0.1);
      final radius = size.width * (0.15 + i * 0.05);

      path.addOval(
        Rect.fromCircle(
          center: Offset(centerX, centerY),
          radius: radius,
        ),
      );
      canvas.drawPath(path, darkPaint);
    }

    // Add some bright specks (stars/embers)
    final speckPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    final random = math.Random(42);
    for (int i = 0; i < 30; i++) {
      final x = size.width * random.nextDouble();
      final y = size.height * random.nextDouble();
      final opacity = 0.4 + random.nextDouble() * 0.6;

      speckPaint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(
        Offset(x, y),
        1.5 + random.nextDouble() * 2,
        speckPaint,
      );
    }

    // Red embers/specks
    for (int i = 0; i < 25; i++) {
      final x = size.width * (0.5 + random.nextDouble() * 0.5);
      final y = size.height * (0.6 + random.nextDouble() * 0.4);
      final opacity = 0.5 + random.nextDouble() * 0.5;

      speckPaint.color = const Color(0xFFFF6B35).withOpacity(opacity);
      canvas.drawCircle(
        Offset(x, y),
        2 + random.nextDouble() * 3,
        speckPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
