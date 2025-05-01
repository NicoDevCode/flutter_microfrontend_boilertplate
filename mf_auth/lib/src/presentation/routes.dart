import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_auth/src/presentation/screens/login_screen.dart';

class AuthRoutes {
  static const String basePath = '/auth';
  static const String login = 'login';
  
  static List<RouteBase> get routes => [
    GoRoute(
      path: login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ];
} 