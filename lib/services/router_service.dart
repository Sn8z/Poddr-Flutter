import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Pages
import 'package:poddr/pages/error.dart';
import 'package:poddr/pages/favourites.dart';
import 'package:poddr/pages/search.dart';
import 'package:poddr/pages/settings.dart';
import 'package:poddr/pages/signin.dart';
import 'package:poddr/pages/toplists.dart';

// Base widget
import 'package:poddr/components/base.dart';

// Providers
import 'auth_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    routes: router._routes,
    initialLocation: '/',
    navigatorBuilder: (context, state, child) {
      if (state.subloc == '/signin') {
        return child;
      } else {
        return BaseWidget(child: child);
      }
    },
    errorPageBuilder: (context, state) => CustomTransitionPage(
      child: ErrorPage(error: state.error!),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref ref;

  RouterNotifier(this.ref) {
    ref.listen(userProvider, (n, __) {
      print('n: $n');
      notifyListeners();
    });
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: '/',
          name: 'toplists',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: ToplistPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          pageBuilder: (context, state) {
            final query = state.queryParams['query'] ?? "";
            return CustomTransitionPage(
              child: SearchPage(query: query),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          },
        ),
        GoRoute(
          path: '/favourites',
          name: 'favourites',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const FavouritesPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const SettingsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          path: '/signin',
          name: 'signin',
          redirect: (state) {
            final loggedIn = ref.read(authProvider).isLoggedIn();
            print(loggedIn);
            if (loggedIn) {
              return '/';
            } else {
              return null;
            }
          },
          pageBuilder: (context, state) => CustomTransitionPage(
            child: SignInPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
      ];
}
