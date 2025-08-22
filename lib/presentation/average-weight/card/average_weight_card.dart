import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/weighin_model.dart';
import '../view/average_weight_view_cubit.dart';
import '../widgets/add_or_edit_card_dialog.dart';
import 'average_weight_card_cubit.dart';

class AverageWeightCard extends StatelessWidget {
  final String period; // 'week' or 'month'
  final String weightType;

  const AverageWeightCard({
    super.key,
    required this.period,
    required this.weightType,
  });

  void _editCard(BuildContext context) {
    showAddOrEditCardDialog(context, period: period);
  }

  @override
  Widget build(BuildContext context) {
    late String title;
    late List<Weighin> filteredWeighins;

    return BlocBuilder<AverageWeightCardCubit, List<Weighin>>(
        builder: (context, weighins) {
      switch (period) {
        case 'week':
          title = 'Average Weight Last 7 Days';
          filteredWeighins = context
              .read<AverageWeightCardCubit>()
              .getLastWeekWeighins(weighins);
          break;
        case 'twoweeks':
          title = 'Average Weight Last 14 Days';
          filteredWeighins = context
              .read<AverageWeightCardCubit>()
              .getLastTwoWeeksWeighins(weighins);
          break;
        case 'month':
          title = 'Average Weight Last 30 Days';
          filteredWeighins = context
              .read<AverageWeightCardCubit>()
              .getLastMonthWeighins(weighins);
          break;
        case 'twomonths':
          title = 'Average Weight Last 60 Days';
          filteredWeighins = context
              .read<AverageWeightCardCubit>()
              .getLastTwoMonthsWeighins(weighins);
          break;
        case 'sixmonths':
          title = 'Average Weight Last 180 Days';
          filteredWeighins = context
              .read<AverageWeightCardCubit>()
              .getLastSixMonthsWeighins(weighins);
          break;
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
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editCard(context);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: const Text('Delete'),
                        onTap: () {
                          context
                              .read<AverageWeightViewCubit>()
                              .removeCard(period);
                        },
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
