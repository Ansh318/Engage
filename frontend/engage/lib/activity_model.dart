import 'package:flutter/material.dart';

/// One step in the activity flow (e.g. Introduction, Activity, Reflection).
class ActivityFlowStep {
  final String title;
  final String description;
  /// Optional PNG (e.g. orange disc with white artwork). Use [icon] if null.
  final String? iconAsset;
  final IconData? icon;

  const ActivityFlowStep({
    required this.title,
    required this.description,
    this.iconAsset,
    this.icon,
  }) : assert(
          icon != null || iconAsset != null,
          'Provide icon and/or iconAsset for ActivityFlowStep',
        );
}

/// One row in "Materials Required" with a branded circular icon asset.
class ActivityMaterial {
  final String label;
  final String iconAsset;

  const ActivityMaterial({
    required this.label,
    required this.iconAsset,
  });
}

/// Activity card and detail data. Optional fields power the detail page.
class Activity {
  final String title;
  final String description;
  final String duration;
  final String location;
  final String? imagePath;
  final List<Color> imageColors;

  /// Facilitator name, e.g. "Lucy Steggals". If null, detail page shows a default.
  final String? facilitatorName;
  /// Optional asset path for facilitator avatar.
  final String? facilitatorImagePath;
  /// Longer description for detail page. If null, [description] is used.
  final String? fullDescription;
  /// Steps shown in "Activity Flow" section.
  final List<ActivityFlowStep>? flowSteps;
  /// Items shown in "Materials Required" section.
  final List<ActivityMaterial>? materials;
  /// In-session clips played in order after emotion check-in (asset paths).
  final List<String>? sessionVideoAssets;

  const Activity({
    required this.title,
    required this.description,
    required this.duration,
    required this.location,
    this.imagePath,
    required this.imageColors,
    this.facilitatorName,
    this.facilitatorImagePath,
    this.fullDescription,
    this.flowSteps,
    this.materials,
    this.sessionVideoAssets,
  });
}
