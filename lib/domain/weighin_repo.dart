import 'weighin_model.dart';

abstract class WeighinRepo {
  Future<List<Weighin>> getWeighins();

  // Implement a stream for weighins so that the pages can listen to changes...
  Stream<List<Weighin>> getWeighinsStream();

  Future<void> addWeighin(double weight, DateTime date);

  Future<void> updateWeighin(Weighin weighin);

  Future<void> deleteWeighin(Weighin weighin);
}
