import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/weighin_model.dart';
import '../../../domain/weighin_repo.dart';

class AverageWeightCardCubit extends Cubit<List<Weighin>> {
  // Constructor initializes the cubit with an empty list
  AverageWeightCardCubit({
    required WeighinRepo weighinRepo,
  })  : _weighinRepo = weighinRepo,
        super([]) {
    // Subscribe to the weighins stream
    _weighinsSubscription = weighinRepo.getWeighinsStream().listen((weighins) {
      emit(weighins);
    });
    // Initial load
    loadWeighins();
  }

  // Repository to fetch weighin data
  final WeighinRepo _weighinRepo;
  late final StreamSubscription<List<Weighin>> _weighinsSubscription;

  // Method to load weighins from the repository
  void loadWeighins() async {
    final weighins = await _weighinRepo.getWeighins();
    emit(weighins);
  }

  List<Weighin> getLastWeekWeighins(List<Weighin> weighins) {
    return weighins
        .where((weighin) => isDateInPeriod(weighin.date, 7))
        .toList();
  }

  List<Weighin> getLastTwoWeeksWeighins(List<Weighin> weighins) {
    return weighins
        .where((weighin) => isDateInPeriod(weighin.date, 14))
        .toList();
  }

  List<Weighin> getLastMonthWeighins(List<Weighin> weighins) {
    return weighins
        .where((weighin) => isDateInPeriod(weighin.date, 30))
        .toList();
  }

  List<Weighin> getLastTwoMonthsWeighins(List<Weighin> weighins) {
    return weighins
        .where((weighin) => isDateInPeriod(weighin.date, 60))
        .toList();
  }

  List<Weighin> getLastSixMonthsWeighins(List<Weighin> weighins) {
    return weighins
        .where((weighin) => isDateInPeriod(weighin.date, 180))
        .toList();
  }

  @override
  Future<void> close() {
    _weighinsSubscription.cancel();
    return super.close();
  }
}

bool isDateInPeriod(DateTime dateToCheck, int days) {
  // Get current date without time component
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  // Calculate date `days` ago
  final startDate = today.subtract(Duration(days: days - 1));

  // Get date to check without time component
  final dateWithoutTime = DateTime(
    dateToCheck.year,
    dateToCheck.month,
    dateToCheck.day,
  );

  // Check if date falls within range (inclusive)
  return (dateWithoutTime.isAtSameMomentAs(today) ||
          dateWithoutTime.isBefore(today)) &&
      (dateWithoutTime.isAtSameMomentAs(startDate) ||
          dateWithoutTime.isAfter(startDate));
}
