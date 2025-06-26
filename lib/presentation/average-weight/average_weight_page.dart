import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/weighin_repo.dart';
import 'average_weight_cubit.dart';
import 'average_weight_view.dart';

class AverageWeightPage extends StatelessWidget {
  const AverageWeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AverageWeightCubit(
        weighinRepo: context.read<WeighinRepo>(),
      ),
      child: const AverageWeightView(),
    );
  }
}
