import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_profile/src/presentation/screens/profile_screen.dart';

class ProfileRoutes {
  static const String basePath = '/profile';
  
  static List<RouteBase> get routes => [
    GoRoute(
      path: '',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
  ];
} 