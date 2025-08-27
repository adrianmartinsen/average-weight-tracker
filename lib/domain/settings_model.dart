import 'package:flutter/foundation.dart';

@immutable
class Settings {
  final String weightUnit;
  final bool remindersEnabled;
  final String reminderTime; // Stored in 'HH:mm' format, e.g., "20:30"

  const Settings({
    required this.weightUnit,
    required this.remindersEnabled,
    required this.reminderTime,
  });

  // Allows creating a new instance of Settings with updated values
  Settings copyWith({
    String? weightUnit,
    bool? remindersEnabled,
    String? reminderTime,
  }) {
    return Settings(
      weightUnit: weightUnit ?? this.weightUnit,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }
}
