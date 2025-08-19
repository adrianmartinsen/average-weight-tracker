import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/weighin_model.dart';
import '../../domain/weighin_repo.dart';
import 'weighin_state.dart';

class WeighinCubit extends Cubit<WeighinState> {
  // Constructor initializes the cubit with an initial state
  WeighinCubit({
    required WeighinRepo weighinRepo,
  })  : _weighinRepo = weighinRepo,
        super(WeighinInitial()) {
    // Subscribe to the weighins stream
    _weighinsSubscription = _weighinRepo.getWeighinsStream().listen((weighins) {
      emit(WeighinLoaded(weighins: weighins));
    });
    // Initial load
    loadWeighins();
  }

  // Repository to fetch weighin data
  final WeighinRepo _weighinRepo;
  late final StreamSubscription<List<Weighin>> _weighinsSubscription;

  // Method to load weighins from the repository
  void loadWeighins() async {
    emit(WeighinLoading());
    try {
      final weighins = await _weighinRepo.getWeighins();
      emit(WeighinLoaded(weighins: weighins));
    } catch (e) {
      emit(WeighinError(e.toString()));
    }
  }

  Future<void> addWeighin(double weight, DateTime date) async {
    try {
      await _weighinRepo.addWeighin(weight, date);
    } catch (e) {
      emit(WeighinError(e.toString()));
    }
  }

  Future<void> updateWeighin(Weighin weighin) async {
    try {
      await _weighinRepo.updateWeighin(weighin);
    } catch (e) {
      emit(WeighinError(e.toString()));
    }
  }

  Future<void> deleteWeighin(Weighin weighin) async {
    try {
      await _weighinRepo.deleteWeighin(weighin);
    } catch (e) {
      emit(WeighinError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _weighinsSubscription.cancel();
    return super.close();
  }
}
