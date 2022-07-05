import 'package:flutter/material.dart';
import 'package:poddr/components/navigation/sidenav.dart';
import 'package:go_router/go_router.dart';

// Components
import 'components/navigation/sidenav.dart';

// Pages
import 'pages/toplists.dart';
import 'pages/search.dart';
import 'pages/favourites.dart';
import 'pages/settings.dart';
import 'pages/error.dart';

void main() {
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
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SearchPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
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
    errorBuilder: (context, state) => ErrorPage(error: state.error!),
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
