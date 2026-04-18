import 'dart:ui';

import 'package:flutter/material.dart';

class BlogDetailPage extends StatelessWidget {
  final String title;
  final String heroImagePath;
  final List<BlogSection> sections;
  final List<String> references;

  const BlogDetailPage({
    super.key,
    required this.title,
    required this.heroImagePath,
    required this.sections,
    required this.references,
  });

  static const Color _bg = Color(0xFF003847);
  static const Color _surface = Color(0xFF003847);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: Image.asset(
                      heroImagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: _buildBackButton(context),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                  decoration: const BoxDecoration(
                    color: _surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 44 / 2,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 14),
                      for (final section in sections) ...[
                        if (section.heading.isNotEmpty) ...[
                          Text(
                            section.heading,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                        Text(
                          section.body,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.96),
                            fontSize: 35 / 2,
                            height: 1.32,
                          ),
                        ),
                        const SizedBox(height: 28),
                      ],
                      const Text(
                        'References:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final reference in references) ...[
                        Text(
                          reference,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.96),
                            fontSize: 34 / 2,
                            height: 1.32,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.26),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.45),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class BlogSection {
  final String heading;
  final String body;

  const BlogSection({
    required this.heading,
    required this.body,
  });
}
