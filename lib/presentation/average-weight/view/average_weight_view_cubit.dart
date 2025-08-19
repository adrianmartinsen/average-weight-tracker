import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/card_config_repo.dart';

const List<String> timePeriods = ['week', 'month'];

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
}
