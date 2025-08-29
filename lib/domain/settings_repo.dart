import 'dart:async';

import 'settings_model.dart';

abstract class SettingsRepo {
  // Gets the full settings object.
  Future<Settings> getSettings();

  // Saves the full settings object.
  // The implementation will delegate to the correct services.
  Future<void> saveSettings(Settings settings);

  // A stream that emits the new Settings object whenever they change.
  Stream<Settings> get settingsStream;


  // Shows a test notification.
  Future<void> showTestNotification();

  Future<bool> isNotificationPermissionGranted();
  Future<bool> requestNotificationPermission();
}
