import 'package:flutter/material.dart';
import 'package:poddr/components/navigation/sidenav.dart';
import 'package:go_router/go_router.dart';

// Components
import 'components/navigation/sidenav.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Pages
import 'pages/toplists.dart';
import 'pages/search.dart';
import 'pages/favourites.dart';
import 'pages/settings.dart';
import 'pages/error.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Poddr());
}

class Poddr extends StatelessWidget {
  Poddr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Poddr',
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }

  final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: '/',
        name: 'toplists',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ToplistPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
    navigatorBuilder: (context, state, child) => BaseWidget(child: child),
    errorPageBuilder: (context, state) => CustomTransitionPage(
      child: ErrorPage(error: state.error!),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  );
}

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideNav(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
