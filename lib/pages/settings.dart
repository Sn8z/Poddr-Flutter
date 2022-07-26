import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/services/theme_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          const Header(
            title: 'Settings',
          ),
          const Text('Settings'),
          TextButton(
            child: Text('Set light mode'),
            onPressed: () {
              ref.read(themeModeProvider.notifier).setLightMode();
            },
          ),
          TextButton(
            child: Text('Set dark mode'),
            onPressed: () {
              ref.read(themeModeProvider.notifier).setDarkMode();
            },
          ),
          TextButton(
            child: Text('Toggle dark mode'),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleMode();
            },
          ),
          Text(ref.watch(themeModeProvider).toString()),
          Divider(
            thickness: 5,
            color: Colors.black,
          ),
          Text(ref.watch(themeDataProvider).toString()),
          TextButton(
            child: Text('Update theme Color'),
            onPressed: () {
              ref.read(themeDataProvider.notifier).updateColor();
            },
          ),
        ],
      ),
    );
  }
}
