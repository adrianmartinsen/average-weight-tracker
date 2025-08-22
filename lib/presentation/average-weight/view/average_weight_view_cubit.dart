import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/card_config_repo.dart';

const List<String> timePeriods = [
  'week',
  'twoweeks',
  'month',
  'twomonths',
  'sixmonths'
];

class AverageWeightViewCubit extends Cubit<List<String>> {
  AverageWeightViewCubit({required CardConfigRepo cardConfigRepo})
      : _cardConfigRepo = cardConfigRepo,
        super([]) {
    _subscription = _cardConfigRepo.cardConfigStream().listen((config) {
      emit(config);
    });
    // Initial load
    loadCardConfig();
  }

  final CardConfigRepo _cardConfigRepo;
  late final StreamSubscription<List<String>> _subscription;

  Future<void> loadCardConfig() async {
    final config = await _cardConfigRepo.getCardConfig();
    emit(config);
  }

  Future<void> addCard(String period) async {
    final config = await _cardConfigRepo.getCardConfig();
    if (timePeriods.contains(period)) {
      if (config.contains(period)) {
        // If the period already exists, do not add it again
        String errorMessage =
            'The period "$period" already exists in the configuration.';
        return Future.error(errorMessage);
      } else {
        // Add the new period to the configuration
        config.add(period);
        await _cardConfigRepo.setCardConfig(config);
        emit(config);
      }
    }
  }

  Future<void> removeCard(String period) async {
    final config = await _cardConfigRepo.getCardConfig();
    config.remove(period);
    await _cardConfigRepo.setCardConfig(config);
    emit(config);
  }

  Future<void> updateCard(String existingPeriod, String newPeriod) async {
    if (!timePeriods.contains(newPeriod)) {
      return;
    }

    final config = await _cardConfigRepo.getCardConfig();

    if (config.contains(newPeriod)) {
      String errorMessage =
          'The period "$newPeriod" already exists in the configuration.';
      return Future.error(errorMessage);
    }

    final index = config.indexOf(existingPeriod);

    if (index != -1) {
      config[index] = newPeriod;
      await _cardConfigRepo.setCardConfig(config);
      emit(config);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
