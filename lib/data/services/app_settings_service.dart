import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _weightUnitKey = 'weight_unit';

  Future<void> setWeightUnit(String unitType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weightUnitKey, unitType);
  }

  Future<String> getWeightUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_weightUnitKey) ?? 'kg'; // Default to 'kg'
  }
}
