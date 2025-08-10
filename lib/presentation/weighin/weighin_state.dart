import 'package:equatable/equatable.dart';

import '../../domain/weighin_model.dart';

abstract class WeighinState extends Equatable {
  const WeighinState();

  @override
  List<Object?> get props => [];
}

class WeighinInitial extends WeighinState {}

class WeighinLoading extends WeighinState {}

class WeighinLoaded extends WeighinState {
  final List<Weighin> weighins;
  const WeighinLoaded({
    required this.weighins,
  });

  @override
  List<Object?> get props => [weighins];
}

class WeighinError extends WeighinState {
  final String message;

  const WeighinError(this.message);

  @override
  List<Object?> get props => [message];
}
