import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/weighin_repo.dart';
import 'weighin_cubit.dart';
import 'weighin_view.dart';

class WeighinPage extends StatelessWidget {
  const WeighinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeighinCubit(
        weighinRepo: context.read<WeighinRepo>(),
      ),
      child: const WeighinView(),
    );
  }
}
