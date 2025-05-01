import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mf_posts/src/presentation/screens/post_list_screen.dart';

class PostsRoutes {
  static const String basePath = '/posts';
  static const String postDetails = 'details';
  static const String createPost = 'create';
  static const String editPost = 'edit';
  
  static List<RouteBase> get routes => [
    GoRoute(
      path: postDetails,
      builder: (BuildContext context, GoRouterState state) {
        final postId = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return PostListScreen(); // Aquí usaríamos una pantalla de detalle
      },
    ),
    GoRoute(
      path: createPost,
      builder: (BuildContext context, GoRouterState state) {
        return PostListScreen(); // Aquí usaríamos una pantalla de creación
      },
    ),
    GoRoute(
      path: editPost,
      builder: (BuildContext context, GoRouterState state) {
        final postId = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return PostListScreen(); // Aquí usaríamos una pantalla de edición
      },
    ),
  ];
} 