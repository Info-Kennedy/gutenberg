import 'package:flutter/material.dart';
import 'package:gutenberg/books/views/books_page.dart';
import 'package:gutenberg/categories/views/categories_page.dart';
import 'package:gutenberg/common/common.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import 'route_names.dart';

class Routes {
  /// The route configuration.
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteNames.initial,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          RouteHistory.push({'/': state.extra});
          return const CategoriesPage();
        },
      ),
      GoRoute(
        name: RouteNames.books,
        path: '/books',
        builder: (BuildContext context, GoRouterState state) {
          RouteHistory.push({'/books': state.extra});
          return BooksPage(categoryName: state.extra as String);
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final logger = Logger();
      logger.d("matchedLocation: ${state.matchedLocation}");
      return state.matchedLocation;
    },
    debugLogDiagnostics: true,
    // changes on the listenable will cause the router to refresh it's route
    // refreshListenable: GoRouterRefreshStream(_loginBloc.stream),
  );
}
