import 'package:flutter/material.dart';
import 'dart:ui';
import 'completion_page.dart';

// Question 1: What brings you to Engage?
class Question1Page extends StatefulWidget {
  const Question1Page({super.key});

  @override
  State<Question1Page> createState() => _Question1PageState();
}

class _Question1PageState extends State<Question1Page> {
  final Map<String, bool> _selections = {
    'I want to feel less anxious or overwhelmed.': false,
    'I want to be more creative.': false,
    'I want to feel more connected to my body.': false,
    'I want to gain clarity of thought.': false,
  };

  @override
  Widget build(BuildContext context) {
    return _QuestionPageTemplate(
      questionNumber: 1,
      totalQuestions: 5,
      title: 'What brings you to Engage?',
      subtitle: 'Choose one or more goals that feel true to you.',
      illustration: _DoorwayIllustration(),
      imageAssetPath: 'assets/onboarding1.png',
      options: _selections.keys.toList(),
      selections: _selections,
      onToggle: (key) {
        setState(() {
          _selections[key] = !_selections[key]!;
        });
      },
      onNext: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Question2Page()),
        );
      },
    );
  }
}

// Question 2: What creative activities interest you?
class Question2Page extends StatefulWidget {
  const Question2Page({super.key});

  @override
  State<Question2Page> createState() => _Question2PageState();
}

class _Question2PageState extends State<Question2Page> {
  final Map<String, bool> _selections = {
    'Drawing or Doodling': true,
    'Writing or Journaling': true,
    'Moving or Dancing': true,
    'Music or Sound': true,
  };

  @override
  Widget build(BuildContext context) {
    return _QuestionPageTemplate(
      questionNumber: 2,
      totalQuestions: 5,
      title: 'What creative activities interest you?',
      subtitle: 'No pressure - pick what ever feels interesting or calming.',
      illustration: _MusicIllustration(),
      imageAssetPath: 'assets/page2a.png',
      options: _selections.keys.toList(),
      selections: _selections,
      onToggle: (key) {
        setState(() {
          _selections[key] = !_selections[key]!;
        });
      },
      onPrevious: () => Navigator.of(context).pop(),
      onNext: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Question3Page()),
        );
      },
    );
  }
}

// Question 3: How do you usually feel - day to day?
class Question3Page extends StatefulWidget {
  const Question3Page({super.key});

  @override
  State<Question3Page> createState() => _Question3PageState();
}

class _Question3PageState extends State<Question3Page> {
  final Map<String, bool> _selections = {
    'Pretty calm, but I want to stay that way.': true,
    'Up and down - depends on the day.': true,
    'Often stressed, anxious or overwhelmed.': true,
    'A bit numb or disconnected': true,
  };

  @override
  Widget build(BuildContext context) {
    return _QuestionPageTemplate(
      questionNumber: 3,
      totalQuestions: 5,
      title: 'How do you usually feel - day to day?',
      subtitle: "We'll use this to shape your experience with us.",
      illustration: _LandscapeIllustration(),
      imageAssetPath: 'assets/page3a.png',
      options: _selections.keys.toList(),
      selections: _selections,
      onToggle: (key) {
        setState(() {
          _selections[key] = !_selections[key]!;
        });
      },
      onPrevious: () => Navigator.of(context).pop(),
      onNext: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Question4Page()),
        );
      },
    );
  }
}

// Question 4: When would you ideally spend some time for yourself?
class Question4Page extends StatefulWidget {
  const Question4Page({super.key});

  @override
  State<Question4Page> createState() => _Question4PageState();
}

class _Question4PageState extends State<Question4Page> {
  final Map<String, bool> _selections = {
    'Morning': true,
    'Midday/Lunch': true,
    'Evening': true,
    'Before Bed': true,
  };

  @override
  Widget build(BuildContext context) {
    return _QuestionPageTemplate(
      questionNumber: 4,
      totalQuestions: 5,
      title: 'When would you ideally spend some time for yourself?',
      subtitle: "Just so we can nudge you at the right time.",
      illustration: _ClockIllustration(),
      imageAssetPath: 'assets/page4a.png',
      options: _selections.keys.toList(),
      selections: _selections,
      onToggle: (key) {
        setState(() {
          _selections[key] = !_selections[key]!;
        });
      },
      onPrevious: () => Navigator.of(context).pop(),
      onNext: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Question5Page()),
        );
      },
    );
  }
}

// Question 5: Let's make a small commitment
class Question5Page extends StatefulWidget {
  const Question5Page({super.key});

  @override
  State<Question5Page> createState() => _Question5PageState();
}

class _Question5PageState extends State<Question5Page> {
  final Map<String, bool> _selections = {
    '1-2 Times': true,
    '3-4 Times': true,
    '5 or more times': true,
    "Let's see how it goes": true,
  };

  @override
  Widget build(BuildContext context) {
    return _QuestionPageTemplate(
      questionNumber: 5,
      totalQuestions: 5,
      title: "Let's make a small commitment",
      subtitle: 'How many days in a week do you want to engage in a creative activity?',
      illustration: _CalendarIllustration(),
      imageAssetPath: 'assets/page5b.png',
      options: _selections.keys.toList(),
      selections: _selections,
      onToggle: (key) {
        setState(() {
          _selections[key] = !_selections[key]!;
        });
      },
      onPrevious: () => Navigator.of(context).pop(),
      onNext: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CompletionPage()),
        );
      },
    );
  }
}

// Reusable question page template (pic 2 layout: orange top, curved bottom, image on right)
class _QuestionPageTemplate extends StatelessWidget {
  static const double _circleImageSize = 108;

  final int questionNumber;
  final int totalQuestions;
  final String title;
  final String subtitle;
  final Widget illustration;
  final List<String> options;
  final Map<String, bool> selections;
  final Function(String) onToggle;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  /// When set (e.g. 'assets/onboarding1.png'), shown in the circular image on the right instead of [illustration].
  final String? imageAssetPath;

  const _QuestionPageTemplate({
    required this.questionNumber,
    required this.totalQuestions,
    required this.title,
    required this.subtitle,
    required this.illustration,
    required this.options,
    required this.selections,
    required this.onToggle,
    required this.onNext,
    this.onPrevious,
    this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    final progress = questionNumber / totalQuestions;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Top orange section with curved bottom (pic 2)
            Expanded(
              flex: 2,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Solid base so curved paint edges never reveal white (white-on-white subtitle).
                  Positioned.fill(
                    child: ColoredBox(
                      color: _QuestionOrangeCurvedPainter.orange,
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _QuestionOrangeCurvedPainter(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16 + topPadding, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button, progress bar, 1/5
                        Row(
                          children: [
                            if (onPrevious != null)
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: onPrevious,
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                              ),
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: progress,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$questionNumber/$totalQuestions',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Title and subtitle on left; space reserved for circular image on right
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.only(bottom: 28),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        subtitle,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 16,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Width only: fixed height was shrinking the Row (crossAxis start + scroll
                              // intrinsic height) and clipping title/subtitle.
                              SizedBox(width: _circleImageSize),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Circular image on right, slightly overlapping white section
                  Positioned(
                    right: 16,
                    bottom: 24,
                    child: Container(
                      width: _circleImageSize,
                      height: _circleImageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: imageAssetPath != null
                            ? Image.asset(
                                imageAssetPath!,
                                fit: BoxFit.cover,
                              )
                            : illustration,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom white section with options
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  children: [
                    ...options.map((option) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _OptionTile(
                            text: option,
                            isSelected: selections[option] ?? false,
                            onToggle: () => onToggle(option),
                          ),
                        )),
                    const SizedBox(height: 16),
                    // Next (and optional Previous) button
                    if (onPrevious != null)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onPrevious,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF1F3B40),
                                side: const BorderSide(color: Color(0xFF1F3B40)),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Previous',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onNext,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F3B40),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F3B40),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Warm orange top section with curved bottom (white bulges up).
class _QuestionOrangeCurvedPainter extends CustomPainter {
  static const Color orange = Color(0xFFE89D3C);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 56,
      0,
      size.height,
    );
    path.close();
    final paint = Paint()
      ..color = orange
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OptionTile extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onToggle;

  const _OptionTile({
    required this.text,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            Switch(
              value: isSelected,
              onChanged: (_) => onToggle(),
              activeColor: const Color(0xFF1F3B40),
            ),
          ],
        ),
      ),
    );
  }
}

// Illustration painters
class _DoorwayIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DoorwayPainter(),
      size: Size.infinite,
    );
  }
}

class _DoorwayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw doorway
    paint.color = const Color(0xFF1F3B40).withOpacity(0.3);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.3, size.height * 0.2, size.width * 0.4, size.height * 0.6),
      paint,
    );

    // Draw light rays
    paint.color = const Color(0xFFFFC107).withOpacity(0.5);
    for (int i = 0; i < 5; i++) {
      final path = Path();
      path.moveTo(size.width * 0.5, size.height * 0.2);
      path.lineTo(size.width * (0.2 + i * 0.15), size.height * 0.8);
      canvas.drawPath(path, paint..strokeWidth = 3..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MusicIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MusicPainter(),
      size: Size.infinite,
    );
  }
}

class _MusicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw saxophone
    paint.color = const Color(0xFF1F3B40);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.3, size.height * 0.3, size.width * 0.4, size.height * 0.4),
      paint,
    );

    // Draw musical notes
    paint.color = const Color(0xFFFFC107);
    for (int i = 0; i < 5; i++) {
      canvas.drawCircle(
        Offset(size.width * (0.2 + i * 0.15), size.height * 0.5),
        8,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LandscapeIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LandscapePainter(),
      size: Size.infinite,
    );
  }
}

class _LandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw hills
    paint.color = const Color(0xFF90EE90).withOpacity(0.4);
    final hillPath = Path();
    hillPath.moveTo(0, size.height * 0.7);
    hillPath.quadraticBezierTo(size.width * 0.3, size.height * 0.5, size.width * 0.6, size.height * 0.6);
    hillPath.quadraticBezierTo(size.width * 0.8, size.height * 0.55, size.width, size.height * 0.65);
    hillPath.lineTo(size.width, size.height);
    hillPath.lineTo(0, size.height);
    hillPath.close();
    canvas.drawPath(hillPath, paint);

    // Draw water
    paint.color = const Color(0xFF87CEEB).withOpacity(0.4);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.7, size.width, size.height * 0.3),
      paint,
    );

    // Draw small figures
    paint.color = const Color(0xFF1F3B40).withOpacity(0.6);
    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(size.width * (0.2 + i * 0.3), size.height * 0.6),
        10,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ClockIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClockPainter(),
      size: Size.infinite,
    );
  }
}

class _ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 3;

    // Draw clock face
    paint.color = const Color(0xFF1F3B40);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.3,
      paint,
    );

    // Draw clock hands
    paint.strokeWidth = 4;
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.5),
      Offset(size.width * 0.5, size.height * 0.3),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.5),
      Offset(size.width * 0.65, size.height * 0.5),
      paint,
    );

    // Draw landscape
    paint.color = const Color(0xFF90EE90).withOpacity(0.4);
    paint.style = PaintingStyle.fill;
    final landscapePath = Path();
    landscapePath.moveTo(0, size.height * 0.7);
    landscapePath.quadraticBezierTo(size.width * 0.5, size.height * 0.6, size.width, size.height * 0.7);
    landscapePath.lineTo(size.width, size.height);
    landscapePath.lineTo(0, size.height);
    landscapePath.close();
    canvas.drawPath(landscapePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CalendarIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CalendarPainter(),
      size: Size.infinite,
    );
  }
}

class _CalendarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw grid/calendar
    paint.color = const Color(0xFF1F3B40).withOpacity(0.2);
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        canvas.drawRect(
          Rect.fromLTWH(
            size.width * (0.2 + i * 0.2),
            size.height * (0.3 + j * 0.2),
            size.width * 0.15,
            size.height * 0.15,
          ),
          paint,
        );
      }
    }

    // Draw creative elements
    paint.color = const Color(0xFFFFC107);
    // Musical note
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.4), 8, paint);
    // Paint palette
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.5), 10, paint);
    // Pencil
    paint.color = const Color(0xFF1F3B40);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.5, size.height * 0.6, size.width * 0.1, size.height * 0.05),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
