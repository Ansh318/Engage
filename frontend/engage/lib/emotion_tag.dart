/// One selectable mood in the Engage check-in grid.
class EmotionTag {
  final String id;
  final String label;
  final String assetPath;

  const EmotionTag({
    required this.id,
    required this.label,
    required this.assetPath,
  });
}

/// Full catalog (PNG in assets/emotions/). Order: heavier feelings, then lighter.
const List<EmotionTag> kEmotionCatalog = [
  EmotionTag(id: 'anxious', label: 'Anxious', assetPath: 'assets/emotions/anxious.png'),
  EmotionTag(id: 'restless', label: 'Restless', assetPath: 'assets/emotions/restless.png'),
  EmotionTag(id: 'stressed', label: 'Stressed', assetPath: 'assets/emotions/stressed.png'),
  EmotionTag(id: 'overwhelmed', label: 'Overwhelmed', assetPath: 'assets/emotions/overwhelmed.png'),
  EmotionTag(id: 'irritated', label: 'Irritated', assetPath: 'assets/emotions/irritated.png'),
  EmotionTag(id: 'uneasy', label: 'Uneasy', assetPath: 'assets/emotions/uneasy.png'),
  EmotionTag(id: 'tired', label: 'Tired', assetPath: 'assets/emotions/tired.png'),
  EmotionTag(id: 'sad', label: 'Sad', assetPath: 'assets/emotions/sad.png'),
  EmotionTag(id: 'numb', label: 'Numb', assetPath: 'assets/emotions/numb.png'),
  EmotionTag(id: 'disconnected', label: 'Disconnected', assetPath: 'assets/emotions/disconnected.png'),
  EmotionTag(id: 'heavy', label: 'Heavy', assetPath: 'assets/emotions/heavy.png'),
  EmotionTag(id: 'lonely', label: 'Lonely', assetPath: 'assets/emotions/lonely.png'),
  EmotionTag(id: 'calm', label: 'Calm', assetPath: 'assets/emotions/calm.png'),
  EmotionTag(id: 'present', label: 'Present', assetPath: 'assets/emotions/present.png'),
  EmotionTag(id: 'safe', label: 'Safe', assetPath: 'assets/emotions/safe.png'),
  EmotionTag(id: 'connected', label: 'Connected', assetPath: 'assets/emotions/connected.png'),
  EmotionTag(id: 'grateful', label: 'Grateful', assetPath: 'assets/emotions/grateful.png'),
  EmotionTag(id: 'grounded', label: 'Grounded', assetPath: 'assets/emotions/grounded.png'),
  EmotionTag(id: 'energized', label: 'Energized', assetPath: 'assets/emotions/energized.png'),
  EmotionTag(id: 'creative', label: 'Creative', assetPath: 'assets/emotions/creative.png'),
  EmotionTag(id: 'joyful', label: 'Joyful', assetPath: 'assets/emotions/joyful.png'),
  EmotionTag(id: 'motivated', label: 'Motivated', assetPath: 'assets/emotions/motivated.png'),
  EmotionTag(id: 'inspired', label: 'Inspired', assetPath: 'assets/emotions/inspired.png'),
  EmotionTag(id: 'curious', label: 'Curious', assetPath: 'assets/emotions/curious.png'),
];
