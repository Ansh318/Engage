import 'package:flutter/material.dart';
import 'dart:ui';
import 'question_pages.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Let's get to know you better.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Answer a few quick questions so we can tailor your experience to what matters most to you.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // Illustration
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                ),
                child: CustomPaint(
                  painter: _CreativeSilhouettePainter(),
                ),
              ),
              const Spacer(),
              // Let's go button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Question1Page(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F3B40),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Let's go",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreativeSilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw silhouette shape (head and torso)
    final silhouettePath = Path();
    // Head
    silhouettePath.addOval(
      Rect.fromCircle(
        center: Offset(size.width * 0.5, size.height * 0.25),
        radius: size.width * 0.15,
      ),
    );
    // Torso
    silhouettePath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.35,
          size.height * 0.35,
          size.width * 0.3,
          size.height * 0.4,
        ),
        const Radius.circular(20),
      ),
    );

    // Fill with gradient-like colors
    paint.color = const Color(0xFF1F3B40).withOpacity(0.3);
    canvas.drawPath(silhouettePath, paint);

    paint.color = const Color(0xFFFFC107).withOpacity(0.3);
    canvas.drawPath(silhouettePath, paint);

    // Draw creative elements inside
    // Musical notes
    paint.color = const Color(0xFFFFC107);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.3), 8, paint);
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.32), 6, paint);

    // Treble clef
    final clefPath = Path();
    clefPath.moveTo(size.width * 0.55, size.height * 0.5);
    clefPath.quadraticBezierTo(
      size.width * 0.55,
      size.height * 0.4,
      size.width * 0.6,
      size.height * 0.45,
    );
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    paint.color = const Color(0xFF1F3B40);
    canvas.drawPath(clefPath, paint);

    // Paint palette
    paint.style = PaintingStyle.fill;
    paint.color = const Color(0xFFFFC107);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.6), 15, paint);

    // Book
    paint.color = const Color(0xFFFFC107);
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.3,
        size.height * 0.65,
        size.width * 0.2,
        size.height * 0.15,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
