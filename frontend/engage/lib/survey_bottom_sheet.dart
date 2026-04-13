import 'package:flutter/material.dart';
import 'dart:ui';

class SurveyBottomSheet extends StatefulWidget {
  const SurveyBottomSheet({super.key});

  @override
  State<SurveyBottomSheet> createState() => _SurveyBottomSheetState();
}

class _SurveyBottomSheetState extends State<SurveyBottomSheet> {
  final Set<String> _selectedEngagement = {};
  final Set<String> _selectedLocation = {};
  final Set<String> _selectedTime = {};

  final List<String> _engagementOptions = [
    'I want to feel grounded',
    'I want to check in with my body',
    'I want to feel energized',
    'I want to reflect on my day',
    'I want to create something',
  ];

  final List<String> _locationOptions = [
    'At Home',
    'At Work',
    'Commuting',
    'Outdoors',
    'Somewhere Else',
  ];

  final List<String> _timeOptions = [
    'Under 10 mins',
    '10-30 mins',
    '30+ mins',
  ];

  void _toggleEngagement(String option) {
    setState(() {
      if (_selectedEngagement.contains(option)) {
        _selectedEngagement.remove(option);
      } else {
        _selectedEngagement.add(option);
      }
    });
  }

  void _toggleLocation(String option) {
    setState(() {
      if (_selectedLocation.contains(option)) {
        _selectedLocation.remove(option);
      } else {
        _selectedLocation.add(option);
      }
    });
  }

  void _toggleTime(String option) {
    setState(() {
      if (_selectedTime.contains(option)) {
        _selectedTime.remove(option);
      } else {
        _selectedTime.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: const Color(0xFF1F3B40).withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F3B40).withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
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
                        // Question 1: How do you wish to engage right now?
                        _QuestionCard(
                          title: 'How do you wish to engage right now?',
                          options: _engagementOptions,
                          selectedOptions: _selectedEngagement,
                          onToggle: _toggleEngagement,
                        ),

                        const SizedBox(height: 20),

                        // Question 2: Where are you right now?
                        _QuestionCard(
                          title: 'Where are you right now?',
                          options: _locationOptions,
                          selectedOptions: _selectedLocation,
                          onToggle: _toggleLocation,
                        ),

                        const SizedBox(height: 20),

                        // Question 3: How much time do you have?
                        _QuestionCard(
                          title: 'How much time do you have?',
                          options: _timeOptions,
                          selectedOptions: _selectedTime,
                          onToggle: _toggleTime,
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Close',
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
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: GestureDetector(
                              onTap: () {
                                // Handle engage action
                                Navigator.of(context).pop();
                                // You can add navigation or callback here
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Engage',
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
}

class _QuestionCard extends StatelessWidget {
  final String title;
  final List<String> options;
  final Set<String> selectedOptions;
  final Function(String) onToggle;

  const _QuestionCard({
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...options.map((option) => _OptionItem(
                    text: option,
                    isSelected: selectedOptions.contains(option),
                    onTap: () => onToggle(option),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionItem({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.3)
                    : Colors.transparent,
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
