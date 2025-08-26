import 'package:shared_preferences/shared_preferences.dart';

class ReminderSettingsService {
  static const String _remindersEnabledKey = 'reminders_enabled';
  static const String _reminderTimeKey = 'reminder_time';

  Future<bool> getRemindersEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_remindersEnabledKey) ?? false;
  }

  Future<void> setRemindersEnabled(bool areEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_remindersEnabledKey, areEnabled);
  }

  Future<String> getReminderTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_reminderTimeKey) ?? '20:00'; // Default to 8 PM
  }

  Future<void> setReminderTime(String time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_reminderTimeKey, time);
  }
}
