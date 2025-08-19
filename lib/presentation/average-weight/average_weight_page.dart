import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/card_config_repo.dart';
import '../../domain/weighin_repo.dart';
import 'card/average_weight_card_cubit.dart';
import 'view/average_weight_view.dart';
import 'view/average_weight_view_cubit.dart';

class AverageWeightPage extends StatelessWidget {
  const AverageWeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AverageWeightCardCubit>(
          create: (context) => AverageWeightCardCubit(
            weighinRepo: context.read<WeighinRepo>(),
          ),
        ),
        BlocProvider<AverageWeightViewCubit>(
          create: (context) => AverageWeightViewCubit(
            cardConfigRepo: context.read<CardConfigRepo>(),
          ),
        ),
      ],
      child: const AverageWeightView(),
    );
  }
}
