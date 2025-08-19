abstract class CardConfigRepo {
  Future<List<String>> getCardConfig();

  Future<void> setCardConfig(List<String> cardTypes);

  Stream<List<String>> cardConfigStream();
}
