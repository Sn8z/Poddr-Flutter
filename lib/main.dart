import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

// Services
import 'package:poddr/services/theme_service.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Router
import 'package:poddr/services/router_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isAndroid | UniversalPlatform.isIOS) {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.sn8z.poddr.channel.audio',
      androidNotificationChannelName: 'Poddr',
      androidNotificationOngoing: false,
    );
  }

  bool isLinuxOrWin = UniversalPlatform.isLinux | UniversalPlatform.isWindows;
  debugPrint('Is Linux or win? -> $isLinuxOrWin.toString()');
  await Firebase.initializeApp(
    options: isLinuxOrWin
        ? DefaultFirebaseOptions.web
        : DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: Poddr(),
    ),
  );

  if (UniversalPlatform.isDesktop) {
    doWhenWindowReady(() {
      const initialSize = Size(600, 450);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}

class Poddr extends ConsumerWidget {
  const Poddr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themes = ref.watch(themeDataProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Poddr',
      themeMode: themeMode,
      theme: themes.lightTheme,
      darkTheme: themes.darkTheme,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
