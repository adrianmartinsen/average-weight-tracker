import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/weighin_model.dart';
import '../settings/settings_cubit.dart';
import 'weighin_cubit.dart';

class WeighinView extends StatelessWidget {
  const WeighinView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeighinCubit, List<Weighin>>(
      builder: (context, weighins) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 20),
          child: ListView.builder(
            itemCount: weighins.length,
            itemBuilder: (context, index) {
              weighins.sort((a, b) => b.date.compareTo(a.date));
              final weighin = weighins[index];
              final formattedDate = DateFormat.yMMMd().format(weighin.date);
              String weightType;
              return BlocBuilder<SettingsCubit, String>(
                  builder: (context, weightUnit) {
                weightType = weightUnit;

                return ListTile(
                  leading: Text(formattedDate),
                  title: Text(
                    "${weighin.weight} $weightType",
                    textAlign: TextAlign.center,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        context.read<WeighinCubit>().deleteWeighin(weighin),
                  ),
                );
              });
            },
          ),
        );
      },
    );
  }
}
