import 'package:bloc_weigh_in/presentation/average-weight/view/average_weight_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/settings_model.dart';
import '../../settings/settings_cubit.dart';
import '../card/average_weight_card.dart';
import '../widgets/add_or_edit_card_dialog.dart';

class AverageWeightView extends StatelessWidget {
  const AverageWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AverageWeightViewCubit, List<String>>(
      builder: (context, cardConfig) {
        if (cardConfig.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'Add time periods to show average weight!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: IconButton(
                      iconSize: 32,
                      onPressed: () => showAddOrEditCardDialog(context),
                      icon: Icon(Icons.add,
                          color: Theme.of(context).dividerColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return BlocBuilder<SettingsCubit, Settings>(
          builder: (context, settings) {
            String weightType = settings.weightUnit;

            return Center(
              child: ListView.builder(
                itemCount: cardConfig.length + 1,
                itemBuilder: (context, index) {
                  if (index < cardConfig.length) {
                    String period = cardConfig[index];
                    return AverageWeightCard(
                      period: period,
                      weightType: weightType,
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border:
                              Border.all(color: Theme.of(context).dividerColor),
                        ),
                        child: IconButton(
                          iconSize: 32,
                          onPressed: () => showAddOrEditCardDialog(context),
                          icon: Icon(Icons.add,
                              color: Theme.of(context).dividerColor),
                        ),
                      ),
                    );
                  }
                },
                shrinkWrap:
                    // when set to false the cards will not be centered
                    true,
              ),
            );
          },
        );
      },
    );
  }
}
