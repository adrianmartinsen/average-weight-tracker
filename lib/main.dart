import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/app_settings_repo.dart';
import 'data/repository/app_card_config_repo.dart';
import 'data/repository/sql_weighin_repo.dart';
import 'data/services/notification_service.dart';
import 'data/services/reminder_settings_service.dart';
import 'data/services/sql_weighin_service.dart';
import 'data/services/weight_card_service.dart';
import 'data/services/weight_settings_service.dart';
import 'domain/card_config_repo.dart';
import 'domain/settings_repo.dart';
import 'domain/weighin_repo.dart';
import 'presentation/home/home_view.dart';
import 'presentation/settings/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  // Initialize services
  final weighinService = SqlWeighinRepo(db: SqlWeighin.instance);
  final settingsService = AppSettingsRepo(
    weightSettingsService: WeightSettingsService(),
    reminderSettingsService: ReminderSettingsService(),
    notificationService: NotificationService(),
  );
  final cardConfigRepo = AppCardConfigRepo(WeightCardService());

  runApp(MainApp(
    weighinRepo: weighinService,
    settingsRepo: settingsService,
    cardConfigRepo: cardConfigRepo,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.weighinRepo,
    required this.settingsRepo,
    required this.cardConfigRepo,
  });

  final WeighinRepo weighinRepo;
  final SettingsRepo settingsRepo;
  final CardConfigRepo cardConfigRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeighinRepo>(
          create: (context) => weighinRepo,
        ),
        RepositoryProvider<CardConfigRepo>(
          create: (context) => cardConfigRepo,
        ),
      ],
      child: BlocProvider(
        create: (context) => SettingsCubit(
          settingsRepo: settingsRepo,
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
