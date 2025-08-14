import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/weighin_model.dart';
import '../settings/settings_cubit.dart';
import 'average_weight_cubit.dart';
import 'widgets/average_weight_card.dart';

class AverageWeightView extends StatelessWidget {
  const AverageWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AverageWeightCubit, List<Weighin>>(
      builder: (context, weighins) {
        final lastWeekWeighins =
            context.read<AverageWeightCubit>().getLastWeekWeighins(weighins);
        final lastMonthWeighins =
            context.read<AverageWeightCubit>().getLastMonthWeighins(weighins);
        String weightType;
        return BlocBuilder<SettingsCubit, String>(
          builder: (context, weightUnit) {
            weightType = weightUnit;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AverageWeightCard(
                  period: 'week',
                  weighins: lastWeekWeighins,
                  weightType: weightType,
                ),
                AverageWeightCard(
                  period: 'month',
                  weighins: lastMonthWeighins,
                  weightType: weightType,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
