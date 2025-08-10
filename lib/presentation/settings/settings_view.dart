import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, String>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Weight Unit',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    RadioListTile<String>(
                      title: const Text('Kilograms (kg)'),
                      value: 'kg',
                      groupValue: state,
                      onChanged: (String? value) {
                        if (value != null) {
                          context.read<SettingsCubit>().setWeightUnit(value);
                        }
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Pounds (lbs)'),
                      value: 'lbs',
                      groupValue: state,
                      onChanged: (String? value) {
                        if (value != null) {
                          context.read<SettingsCubit>().setWeightUnit(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                    child:
                        Text("App icon made by Freepik from www.flaticon.com")),
              ),
            ],
          ),
        );
      },
    );
  }
}
