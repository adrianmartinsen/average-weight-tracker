import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/weighin_model.dart';
import 'average_weight_card_cubit.dart';

class AverageWeightCard extends StatelessWidget {
  final String period; // 'week' or 'month'
  final String weightType;

  const AverageWeightCard({
    super.key,
    required this.period,
    required this.weightType,
  });

  @override
  Widget build(BuildContext context) {
    late String title;
    late List<Weighin> filteredWeighins;

    return BlocBuilder<AverageWeightCardCubit, List<Weighin>>(
        builder: (context, weighins) {
      final lastWeekWeighins =
          context.read<AverageWeightCardCubit>().getLastWeekWeighins(weighins);
      final lastMonthWeighins =
          context.read<AverageWeightCardCubit>().getLastMonthWeighins(weighins);

      // When we have more than two cards consider a switch statement instead
      if (period == 'week') {
        title = 'Average Weight Last 7 Days';
        filteredWeighins = lastWeekWeighins;
      }

      if (period == 'month') {
        title = 'Average Weight Last 30 Days';
        filteredWeighins = lastMonthWeighins;
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.grey[800],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 32),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        filteredWeighins.isEmpty
                            ? 'No data'
                            : '${(filteredWeighins.map((w) => w.weight).reduce((a, b) => a + b) / filteredWeighins.length).toStringAsFixed(2)} $weightType',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 3,
                  child: PopupMenuButton<String>(
                    color: Colors.grey[700],
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    child: const Icon(Icons.more_vert, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
