import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/settings_model.dart';
import '../../domain/settings_repo.dart';

const List<String> weightUnits = ['kg', 'lbs'];

class SettingsCubit extends Cubit<Settings> {
  SettingsCubit({required SettingsRepo settingsRepo})
      : _settingsRepo = settingsRepo,
        super(
          const Settings(
            weightUnit: 'kg',
            remindersEnabled: false,
            reminderTime: '20:00',
          ),
        ) {
    _subscription = _settingsRepo.settingsStream.listen((settings) {
      emit(settings);
    });
    // Initial load
    loadSettings();
  }

  final SettingsRepo _settingsRepo;
  late final StreamSubscription<Settings> _subscription;

  Future<void> loadSettings() async {
    final settings = await _settingsRepo.getSettings();
    emit(settings);
  }

  Future<void> setWeightUnit(String unitType) async {
    if (weightUnits.contains(unitType)) {
      final newSettings = state.copyWith(weightUnit: unitType);
      await _settingsRepo.saveSettings(newSettings);
    }
  }

  Future<void> setReminders({required bool enabled, String? time}) async {
    final newSettings = state.copyWith(
      remindersEnabled: enabled,
      reminderTime: time ?? state.reminderTime, // Only update time if provided
    );
    await _settingsRepo.saveSettings(newSettings);
  }

  Future<void> showTestNotification() async {
    await _settingsRepo.showTestNotification();
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
