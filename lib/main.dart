import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/app_settings_repo.dart';
import 'data/repository/sql_weighin_repo.dart';
import 'data/services/app_settings_service.dart';
import 'data/services/sql_weighin_service.dart';
import 'domain/settings_repo.dart';
import 'domain/weighin_repo.dart';
import 'presentation/home/home_view.dart';
import 'presentation/settings/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final weighinService = SqlWeighinRepo(db: SqlWeighin.instance);
  final settingsService = AppSettingsRepo(SettingsService());

  runApp(MainApp(
    weighinRepo: weighinService,
    settingsRepo: settingsService,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.weighinRepo,
    required this.settingsRepo,
  });

  final WeighinRepo weighinRepo;
  final SettingsRepo settingsRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeighinRepo>(
          create: (context) => weighinRepo,
        ),
        RepositoryProvider<SettingsRepo>(
          create: (context) => settingsRepo,
        ),
      ],
      child: BlocProvider(
        create: (context) => SettingsCubit(
          context.read<SettingsRepo>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const HomeView(),
        ),
      ),
    );
  }
}
