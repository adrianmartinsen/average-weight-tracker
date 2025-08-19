import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings/settings_cubit.dart';
import 'average_weight_card.dart';

class AverageWeightView extends StatelessWidget {
  const AverageWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, String>(
      builder: (context, weightUnit) {
        String weightType = weightUnit;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AverageWeightCard(
              period: 'week',
              weightType: weightType,
            ),
            AverageWeightCard(
              period: 'month',
              weightType: weightType,
            ),
          ],
        );
      },
    );
  }
}
