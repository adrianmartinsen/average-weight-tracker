import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/weighin_model.dart';
import '../settings/settings_cubit.dart';
import 'average_weight_cubit.dart';

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
                Center(
                  child: Card(
                    color: Colors.grey[800],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Average Weight Last 7 Days',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            lastWeekWeighins.isEmpty
                                ? 'No data'
                                : '${(lastWeekWeighins.map((w) => w.weight).reduce((a, b) => a + b) / lastWeekWeighins.length).toStringAsFixed(2)} $weightType',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Card(
                    color: Colors.grey[800],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Average Weight Last 30 Days',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            lastMonthWeighins.isEmpty
                                ? 'No data'
                                : '${(lastMonthWeighins.map((w) => w.weight).reduce((a, b) => a + b) / lastMonthWeighins.length).toStringAsFixed(2)} $weightType',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
