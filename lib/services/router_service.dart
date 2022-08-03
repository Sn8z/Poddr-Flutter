import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Pages
import 'package:poddr/pages/error.dart';
import 'package:poddr/pages/favourites.dart';
import 'package:poddr/pages/player.dart';
import 'package:poddr/pages/podcast.dart';
import 'package:poddr/pages/search.dart';
import 'package:poddr/pages/settings.dart';
import 'package:poddr/pages/signin.dart';
import 'package:poddr/pages/charts.dart';

// Providers
import 'auth_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    routes: router._routes,
    initialLocation: '/',
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
      debugPrint('n: $n');
      notifyListeners();
    });
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: '/',
          name: 'root',
          redirect: (_) {
            return '/charts';
          },
        ),
        GoRoute(
          path: '/charts',
          name: 'charts',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const ToplistPage(),
            key: state.pageKey,
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
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          },
        ),
        GoRoute(
          path: '/podcast',
          name: 'podcast',
          pageBuilder: (context, state) {
            final String url = state.queryParams['podcastUrl'] ?? "";
            return CustomTransitionPage(
              child: PodcastPage(url: url),
              key: state.pageKey,
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
            key: state.pageKey,
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
            key: state.pageKey,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          path: '/player',
          name: 'player',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const PlayerPage(),
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
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
            child: const SignInPage(),
            key: state.pageKey,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
      ];
}
