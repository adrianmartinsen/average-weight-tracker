import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/settings_model.dart';
import 'settings_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Settings>(
      builder: (context, settings) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    // --- General Section ---
                    const _SettingsGroupTitle(title: 'General'),
                    ListTile(
                      leading: const Icon(Icons.line_weight),
                      title: const Text('Weight Unit'),
                      trailing: Text(
                        settings.weightUnit.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => _showWeightUnitDialog(context, settings),
                    ),
                    const Divider(),

                    // --- Notifications Section ---
                    const _SettingsGroupTitle(title: 'Notifications'),
                    SwitchListTile(
                      secondary:
                          const Icon(Icons.notifications_active_outlined),
                      title: const Text('Daily Reminders'),
                      value: settings.remindersEnabled,
                      onChanged: (bool value) {
                        context
                            .read<SettingsCubit>()
                            .setReminders(enabled: value);
                      },
                    ),
                    ListTile(
                      enabled: settings.remindersEnabled,
                      leading: const Icon(Icons.access_time),
                      title: const Text('Reminder Time'),
                      trailing:
                          Text(_formatTime(context, settings.reminderTime)),
                      onTap: () => _selectTime(context, settings.reminderTime),
                    ),
                    ListTile(
                      leading: const Icon(Icons.send_outlined),
                      title: const Text('Send Test Notification'),
                      onTap: () {
                        context.read<SettingsCubit>().showTestNotification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Test notification sent!')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                      child: Text(
                          "App icon made by Freepik from www.flaticon.com")),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(BuildContext context, String time) {
    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final timeOfDay = TimeOfDay(hour: hour, minute: minute);
    return timeOfDay.format(context);
  }

  Future<void> _selectTime(BuildContext context, String currentTime) async {
    final cubit = context.read<SettingsCubit>();
    final timeParts = currentTime.split(':');
    final initialTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      final newTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      cubit.setReminders(enabled: cubit.state.remindersEnabled, time: newTime);
    }
  }

  void _showWeightUnitDialog(BuildContext context, Settings settings) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Select Weight Unit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Kilograms (kg)'),
                value: 'kg',
                groupValue: settings.weightUnit,
                onChanged: (String? value) {
                  if (value != null) {
                    context.read<SettingsCubit>().setWeightUnit(value);
                    Navigator.of(dialogContext).pop();
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('Pounds (lbs)'),
                value: 'lbs',
                groupValue: settings.weightUnit,
                onChanged: (String? value) {
                  if (value != null) {
                    context.read<SettingsCubit>().setWeightUnit(value);
                    Navigator.of(dialogContext).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// A helper widget for section titles to keep the list clean and consistent.
class _SettingsGroupTitle extends StatelessWidget {
  const _SettingsGroupTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 24.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
