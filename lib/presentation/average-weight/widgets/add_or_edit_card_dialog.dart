import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view/average_weight_view_cubit.dart';

Future<void> showAddOrEditCardDialog(BuildContext context,
    {String? period}) async {
  final cubit = context.read<AverageWeightViewCubit>();
  final isEditing = period != null;
  String? selectedPeriod = period;

  final newPeriod = await showDialog<String>(
    context: context,
    builder: (BuildContext dialogContext) {
      String? dialogSelectedPeriod = selectedPeriod;

      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Card' : 'Add Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Week (7 days)'),
                value: 'week',
                groupValue: dialogSelectedPeriod,
                onChanged: (value) {
                  setState(() => dialogSelectedPeriod = value);
                },
              ),
              RadioListTile<String>(
                title: const Text('Two Weeks (14 days)'),
                value: 'twoweeks',
                groupValue: dialogSelectedPeriod,
                onChanged: (value) {
                  setState(() => dialogSelectedPeriod = value);
                },
              ),
              RadioListTile<String>(
                title: const Text('Month (30 days)'),
                value: 'month',
                groupValue: dialogSelectedPeriod,
                onChanged: (value) {
                  setState(() => dialogSelectedPeriod = value);
                },
              ),
              RadioListTile<String>(
                title: const Text('Two Months (60 days)'),
                value: 'twomonths',
                groupValue: dialogSelectedPeriod,
                onChanged: (value) {
                  setState(() => dialogSelectedPeriod = value);
                },
              ),
              RadioListTile<String>(
                title: const Text('Six Months (180 days)'),
                value: 'sixmonths',
                groupValue: dialogSelectedPeriod,
                onChanged: (value) {
                  setState(() => dialogSelectedPeriod = value);
                },
              ),
            ],

            // children: timePeriods.map((p) {
            //   return RadioListTile<String>(
            //     title: Text(p[0].toUpperCase() + p.substring(1)),
            //     value: p,
            //     groupValue: dialogSelectedPeriod,
            //     onChanged: (String? value) {
            //       setState(() {
            //         dialogSelectedPeriod = value;
            //       });
            //     },
            //   );
            // }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              onPressed: dialogSelectedPeriod == null
                  ? null
                  : () {
                      Navigator.of(dialogContext).pop(dialogSelectedPeriod);
                    },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        );
      });
    },
  );

  if (newPeriod != null && newPeriod.isNotEmpty) {
    try {
      if (isEditing) {
        if (newPeriod != period) {
          await cubit.updateCard(period!, newPeriod);
        }
      } else {
        await cubit.addCard(newPeriod);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}
