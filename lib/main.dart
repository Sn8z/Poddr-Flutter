import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Services
import 'package:poddr/services/theme_service.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Router
import 'package:poddr/services/router_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: Poddr(),
    ),
  );
}

class Poddr extends ConsumerWidget {
  Poddr({Key? key}) : super(key: key);

  final themeService = ThemeService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Poddr',
      themeMode: themeService.currentThemeMode,
      theme: themeService.buildLightTheme(),
      darkTheme: themeService.buildDarkTheme(),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
