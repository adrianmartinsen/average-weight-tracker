import 'package:flutter/material.dart';
import '../../../domain/weighin_model.dart';

class AverageWeightCard extends StatelessWidget {
  final String period; // 'week' or 'month'
  final List<Weighin> weighins;
  final String weightType;

  const AverageWeightCard({
    super.key,
    required this.period,
    required this.weighins,
    required this.weightType,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    List<Weighin> filteredWeighins;

    if (period == 'week') {
      title = 'Average Weight Last 7 Days';
      filteredWeighins = weighins; // Pass lastWeekWeighins here
    } else {
      title = 'Average Weight Last 30 Days';
      filteredWeighins = weighins; // Pass lastMonthWeighins here
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
  }
}
