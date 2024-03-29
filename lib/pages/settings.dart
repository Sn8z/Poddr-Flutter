import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/components/user_info.dart';
import 'package:poddr/helpers/user_agent.dart';
import 'package:poddr/services/auth_service.dart';
import 'package:poddr/services/snackbar_service.dart';
import 'package:poddr/services/theme_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: 'Settings',
          ),
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
          ElevatedButton(
            onPressed: () {
              SnackbarService().successSnack(context);
            },
            child: const Text("Snack"),
          ),
          Divider(
            thickness: 2,
            endIndent: 26,
            indent: 26,
            color: Theme.of(context).primaryColor,
          ),
          const UserInfoCard(),
          Divider(
            thickness: 2,
            endIndent: 26,
            indent: 26,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer(builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () => ref.read(authProvider).signOut(),
                    child: const Text('Logout'),
                  );
                }),
                ElevatedButton(
                  onPressed: () => context.push("/signin"),
                  child: const Text("Log in"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
