import 'dart:async';

import '../../domain/card_config_repo.dart';
import '../services/weight_card_service.dart';

class AppCardConfigRepo implements CardConfigRepo {
  AppCardConfigRepo(this._weightCardService);

  final WeightCardService _weightCardService;

  @override
  Future<List<String>> getCardConfig() async {
    return await _weightCardService.getCardConfig();
  }

  @override
  Future<void> setCardConfig(List<String> cardTypes) async {
    await _weightCardService.setCardConfig(cardTypes);
    _weightCardController.add(cardTypes);
  }

  final _weightCardController = StreamController<List<String>>.broadcast();

  @override
  Stream<List<String>> cardConfigStream() => _weightCardController.stream;
}
