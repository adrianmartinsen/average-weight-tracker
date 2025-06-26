import 'dart:async';

import 'package:bloc_weigh_in/domain/weighin_model.dart';

import '../../domain/weighin_repo.dart';
import '../services/sql_weighin_service.dart';

class SqlWeighinRepo implements WeighinRepo {
  SqlWeighinRepo({
    required SqlWeighin db,
  }) : _db = db {
    // Initialize the stream controller
    _weighinsController = StreamController<List<Weighin>>.broadcast();
    // Load initial data
    _loadWeighins();
  }

  final SqlWeighin _db;
  late final StreamController<List<Weighin>> _weighinsController;

  // Private method to load and emit weighins
  Future<void> _loadWeighins() async {
    final weighins = await getWeighins();
    _weighinsController.add(weighins);
  }

  @override
  Future<List<Weighin>> getWeighins() async {
    final weighins = await _db.getWeighins();
    return weighins.map((weighin) => Weighin.fromMap(weighin)).toList();
  }

  @override
  Stream<List<Weighin>> getWeighinsStream() => _weighinsController.stream;

  @override
  Future<void> addWeighin(double weight, DateTime date) async {
    await _db.insertWeighin(
      weight.toString(),
      date.millisecondsSinceEpoch,
    );
    // Reload and emit new data after adding
    await _loadWeighins();
  }

  @override
  Future<void> updateWeighin(Weighin weighin) async {
    await _db.updateWeighin(
      weighin.id,
      weighin.weight.toString(),
      weighin.date.millisecondsSinceEpoch,
    );
    // Reload and emit new data after updating
    await _loadWeighins();
  }

  @override
  Future<void> deleteWeighin(Weighin weighin) async {
    await _db.deleteWeighin(weighin.id);
    // Reload and emit new data after deleting
    await _loadWeighins();
  }

  void dispose() {
    _weighinsController.close();
  }
}
