import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:mf_posts/mf_posts.dart';
import 'package:mf_auth/mf_auth.dart';
import 'package:mf_profile/mf_profile.dart';
import 'package:mf_settings/mf_settings.dart';
import 'package:shell_app/layout/main_layout.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/posts',
    redirect: (context, state) {
      final authStore = GetIt.instance<AuthStore>();
      final isLoggedIn = authStore.isLoggedIn;
      final isLoggingIn = state.matchedLocation == '/auth/login';
      
      // Si no está logueado y no está intentando ir a login, redirigir a login
      if (!isLoggedIn && !isLoggingIn) {
        return '/auth/login';
      }
      
      // Si está logueado y está intentando ir a login, redirigir a posts
      if (isLoggedIn && isLoggingIn) {
        return '/posts';
      }
      
      return null;
    },
    routes: [
      // Splash screen
      GoRoute(
        path: '/splash',
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      
      // Auth routes
      GoRoute(
        path: '/auth',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Authentication')),
        ),
        routes: [
          GoRoute(
            path: 'login',
            builder: (context, state) => const LoginScreen(),
          ),
        ],
      ),
      
      // Shell Route para la aplicación principal
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          // Posts Routes
          GoRoute(
            path: '/posts',
            builder: (context, state) => const PostListScreen(),
            routes: PostsRoutes.routes,
          ),
          
          // Profile Routes
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          
          // Settings Routes
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          
          // Otras rutas se agregarán conforme se implementen los módulos correspondientes
        ],
      ),
    ],
  );
} 