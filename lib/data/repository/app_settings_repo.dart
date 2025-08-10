import 'dart:async';

import '../../domain/settings_repo.dart';
import '../services/app_settings_service.dart';

class AppSettingsRepo implements SettingsRepo {
  AppSettingsRepo(this._settingsService);

  final SettingsService _settingsService;

  @override
  Future<String> getWeightUnit() async {
    return await _settingsService.getWeightUnit();
  }

  @override
  Future<void> setWeightUnit(String unitType) async {
    await _settingsService.setWeightUnit(unitType);
    _weightUnitController.add(unitType);
  }

  final _weightUnitController = StreamController<String>.broadcast();

  @override
  Stream<String> unitTypeStream() => _weightUnitController.stream;
}
