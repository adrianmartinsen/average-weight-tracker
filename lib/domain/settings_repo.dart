abstract class SettingsRepo {
  Future<String> getWeightUnit();

  Future<void> setWeightUnit(String unit);

  Stream<String> unitTypeStream();
}
