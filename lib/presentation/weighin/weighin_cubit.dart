import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/weighin_model.dart';
import '../../domain/weighin_repo.dart';

class WeighinCubit extends Cubit<List<Weighin>> {
  // Constructor initializes the cubit with an empty list
  WeighinCubit({
    required this.weighinRepo,
  }) : super([]) {
    // Subscribe to the weighins stream
    _weighinsSubscription = weighinRepo.getWeighinsStream().listen((weighins) {
      emit(weighins);
    });
    // Initial load
    loadWeighins();
  }

  // Repository to fetch weighin data
  final WeighinRepo weighinRepo;
  late final StreamSubscription<List<Weighin>> _weighinsSubscription;

  // Method to load weighins from the repository
  void loadWeighins() async {
    final weighins = await weighinRepo.getWeighins();
    emit(weighins);
  }

  Future<void> addWeighin(double weight, DateTime date) async {
    await weighinRepo.addWeighin(weight, date);
  }

  Future<void> updateWeighin(Weighin weighin) async {
    await weighinRepo.updateWeighin(weighin);
  }

  Future<void> deleteWeighin(Weighin weighin) async {
    await weighinRepo.deleteWeighin(weighin);
  }

  @override
  Future<void> close() {
    _weighinsSubscription.cancel();
    return super.close();
  }
}
