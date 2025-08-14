import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/weighin_model.dart';
import '../settings/settings_cubit.dart';
import 'weighin_cubit.dart';
import 'weighin_state.dart';
import 'widgets/weighin_tile.dart';

class WeighinView extends StatelessWidget {
  const WeighinView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeighinCubit, WeighinState>(
      builder: (context, state) {
        if (state is WeighinLoaded) {
          if (state.weighins.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No weigh-in data.\n Get started by adding your first weigh-in!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          final weighinList = List<Weighin>.from(state.weighins);
          weighinList.sort((a, b) => b.date.compareTo(a.date));
          return Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 20),
            child: ListView.builder(
              itemCount: weighinList.length,
              itemBuilder: (context, index) {
                final weighin = weighinList[index];
                return BlocBuilder<SettingsCubit, String>(
                  builder: (context, weightUnit) {
                    return WeighinTile(
                      date: weighin.date,
                      weight: weighin.weight,
                      weightType: weightUnit,
                      weighin: weighin,
                    );
                  },
                );
              },
            ),
          );
        } else if (state is WeighinLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeighinError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: ${state.message}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<WeighinCubit>().loadWeighins();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
