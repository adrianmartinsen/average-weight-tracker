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
  late Settings? _currentSettings;

  @override
  Stream<Settings> get settingsStream => _settingsController.stream;

  @override
  Future<Settings> getSettings() async {
    final weightUnit = await weightSettingsService.getWeightUnit();
    final remindersEnabled =
        await reminderSettingsService.getRemindersEnabled();
    // final reminderTime = await reminderSettingsService.getReminderTime();

    final settings = Settings(
      weightUnit: weightUnit,
      remindersEnabled: remindersEnabled,
      // reminderTime: reminderTime,
    );
    _currentSettings = settings;
    return settings;
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    // Persist each setting using its dedicated service
    await weightSettingsService.setWeightUnit(settings.weightUnit);
    await reminderSettingsService
        .setRemindersEnabled(settings.remindersEnabled);
    // await reminderSettingsService.setReminderTime(settings.reminderTime);

    // Handle notification logic
    // if (settings.remindersEnabled) {
    //   await notificationService.scheduleDailyWeighInReminder(settings.reminderTime);
    // } else {
    //   await notificationService.cancelAllNotifications();
    // }

    // Update the current settings cache and notify listeners
    _currentSettings = settings;
    _settingsController.add(settings);
  }
}
