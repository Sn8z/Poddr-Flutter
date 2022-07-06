import 'dart:js';

import 'package:flutter/material.dart';
import 'package:poddr/components/navigation/sidenav.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Services
import 'package:poddr/services/auth_service.dart';

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
import 'pages/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Poddr());
}

class Poddr extends StatelessWidget {
  Poddr({Key? key}) : super(key: key);

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => authService)],
      child: MaterialApp.router(
        title: 'Poddr',
        debugShowCheckedModeBanner: false,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }

  late final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: authService,
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
      GoRoute(
        path: '/signin',
        name: 'signin',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: SignInPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
    navigatorBuilder: (context, state, child) =>
        authService.isLoggedIn() ? BaseWidget(child: child) : child,
    errorPageBuilder: (context, state) => CustomTransitionPage(
      child: ErrorPage(error: state.error!),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    redirect: (state) {
      // if the user is not logged in, they need to login
      final loggedIn = AuthService().isLoggedIn();
      final loggingIn = state.subloc == '/signin';
      if (!loggedIn) return loggingIn ? null : '/signin';

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) return '/';

      // no need to redirect at all
      return null;
    },
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
