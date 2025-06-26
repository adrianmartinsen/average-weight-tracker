import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/settings_repo.dart';

const List<String> weightUnits = ['kg', 'lbs'];

class SettingsCubit extends Cubit<String> {
  SettingsCubit(this._settingsRepo) : super('') {
    _subscription = _settingsRepo.unitTypeStream().listen((unitType) {
      emit(unitType);
    });
    // Initial load
    loadWeightUnit();
  }

  final SettingsRepo _settingsRepo;
  late final StreamSubscription<String> _subscription;

  Future<void> loadWeightUnit() async {
    final weightUnit = await _settingsRepo.getWeightUnit();
    emit(weightUnit);
  }

  Future<void> setWeightUnit(String unitType) async {
    if (weightUnits.contains(unitType)) {
      await _settingsRepo.setWeightUnit(unitType);
      emit(unitType);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
