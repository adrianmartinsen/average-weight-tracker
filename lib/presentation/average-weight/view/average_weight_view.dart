import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../settings/settings_cubit.dart';
import '../card/average_weight_card.dart';

class AverageWeightView extends StatelessWidget {
  const AverageWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    // We need another BlocBuilder with a AverageWeightViewCubit
    // In essense we split the Average Weight into two features
    // 1. AverageWeightCard that show the average weight for a given period
    // 2. AverageWeightView that shows the cards the user wants
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
