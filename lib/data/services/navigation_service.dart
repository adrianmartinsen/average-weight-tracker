import 'package:flutter/material.dart';

import '../../presentation/home/add_weighin_modal.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void onNotificationTapped() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      showAddWeighinModal(context);
    }
  }
}
