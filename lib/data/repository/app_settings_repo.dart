import 'dart:async';

import '../../domain/settings_model.dart';
import '../../domain/settings_repo.dart';
import '../services/notification_service.dart';
import '../services/reminder_settings_service.dart';
import '../services/weight_settings_service.dart';

class AppSettingsRepo implements SettingsRepo {
  AppSettingsRepo({
    required this.weightSettingsService,
    required this.reminderSettingsService,
    required this.notificationService,
  });

  final WeightSettingsService weightSettingsService;
  final ReminderSettingsService reminderSettingsService;
  final NotificationService notificationService;

  final _settingsController = StreamController<Settings>.broadcast();

  @override
  Stream<Settings> get settingsStream => _settingsController.stream;

  @override
  Future<Settings> getSettings() async {
    final weightUnit = await weightSettingsService.getWeightUnit();
    final remindersEnabled =
        await reminderSettingsService.getRemindersEnabled();
    final reminderTime = await reminderSettingsService.getReminderTime();

    final settings = Settings(
      weightUnit: weightUnit,
      remindersEnabled: remindersEnabled,
      reminderTime: reminderTime,
    );
    _settingsController.add(settings);
    return settings;
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    // Persist each setting using its dedicated service
    await weightSettingsService.setWeightUnit(settings.weightUnit);
    await reminderSettingsService
        .setRemindersEnabled(settings.remindersEnabled);
    await reminderSettingsService.setReminderTime(settings.reminderTime);

    // Handle notification logic
    if (settings.remindersEnabled) {
      await notificationService.scheduleDailyWeighInReminder(settings.reminderTime);
    } else {
      await notificationService.cancelAllNotifications();
    }

    // Update the current settings cache and notify listeners
    _settingsController.add(settings);
  }

  @override
  Future<void> showTestNotification() async {
    return notificationService.showNotification(
      id: 1,
      title: 'Test Notification',
      body: 'This is a test notification.',
    );
  }

  @override
  Future<bool> isNotificationPermissionGranted() {
    return notificationService.isNotificationPermissionGranted();
  }

  @override
  Future<bool> requestNotificationPermission() {
    return notificationService.requestNotificationPermission();
  }
}
