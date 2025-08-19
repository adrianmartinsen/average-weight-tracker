import 'package:shared_preferences/shared_preferences.dart';

class WeightCardService {
  static const String _cardConfigKey = 'weight_card_config';

  Future<void> setCardConfig(List<String> cardTypes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_cardConfigKey, cardTypes);
  }

  Future<List<String>> getCardConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_cardConfigKey) ?? ['week', 'month'];
  }
}
