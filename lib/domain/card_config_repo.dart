abstract class CardConfigRepo {
  Future<List<String>> getCardConfig();

  // Future<List<String>> getCardConfigOnce();

  Future<void> setCardConfig(List<String> cardTypes);

  Stream<List<String>> cardConfigStream();
}
