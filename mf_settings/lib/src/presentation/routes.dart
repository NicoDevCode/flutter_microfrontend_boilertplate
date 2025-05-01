import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_settings/src/presentation/screens/settings_screen.dart';

class SettingsRoutes {
  static const String basePath = '/settings';
  
  static List<RouteBase> get routes => [
    GoRoute(
      path: '',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen();
      },
    ),
  ];
} 