import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/helpers/user_agent.dart';
import 'package:poddr/services/auth_service.dart';
import 'package:poddr/services/theme_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseWidget(
      child: Center(
        child: Column(
          children: [
            const Header(
              title: 'Settings',
            ),
            const Text('Settings'),
            TextButton(
              child: const Text('Set light mode'),
              onPressed: () {
                ref.read(themeModeProvider.notifier).setLightMode();
              },
            ),
            TextButton(
              child: const Text('Set dark mode'),
              onPressed: () {
                ref.read(themeModeProvider.notifier).setDarkMode();
              },
            ),
            TextButton(
              child: const Text('Toggle dark mode'),
              onPressed: () {
                ref.read(themeModeProvider.notifier).toggleMode();
              },
            ),
            Text(ref.watch(themeModeProvider).toString()),
            Divider(
              thickness: 2,
              endIndent: 26,
              indent: 26,
              color: Theme.of(context).primaryColor,
            ),
            Text(ref.watch(themeDataProvider).toString()),
            TextButton(
              child: const Text('Update theme Color'),
              onPressed: () {
                ref.read(themeDataProvider.notifier).updateColor();
              },
            ),
            Divider(
              thickness: 2,
              endIndent: 26,
              indent: 26,
              color: Theme.of(context).primaryColor,
            ),
            SelectableText(getUserAgent()),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer(builder: (context, ref, child) {
                    return ElevatedButton(
                      onPressed: () => ref.read(authProvider).signOut(),
                      child: const Text('Logout'),
                    );
                  }),
                  ElevatedButton(
                    onPressed: () => context.go("/signin"),
                    child: const Text("Log in"),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              endIndent: 26,
              indent: 26,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
