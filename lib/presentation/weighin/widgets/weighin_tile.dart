import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/weighin_model.dart';
import '../weighin_cubit.dart';

class WeighinTile extends StatelessWidget {
  final DateTime date;
  final double weight;
  final String weightType;
  final Weighin weighin;

  const WeighinTile({
    super.key,
    required this.date,
    required this.weight,
    required this.weightType,
    required this.weighin,
  });

  String get formattedDate =>
      "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(formattedDate),
      title: Text(
        "$weight $weightType",
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Entry'),
              content: Text(
                'Are you sure you want to delete the weigh-in from $formattedDate?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
          if (confirm == true) {
            if (context.mounted) {
              context.read<WeighinCubit>().deleteWeighin(weighin);
            }
          }
        },
        tooltip: 'Delete',
      ),
    );
  }
}
