import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/auth_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          const Text('Settings'),
          TextButton(
            child: Text('Toggle Test'),
            onPressed: () {},
          ),
        ],
      ),
    );
    /* return Container(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: Column(
              children: [
                const Text("Settings"),
                Consumer<AuthService>(builder: (context, user, child) {
                  return Text('Username: ${user.fbUser?.email}');
                }),
                MaterialButton(
                  child: const Text('Dark'),
                  onPressed: () {
                    Provider.of<ThemeService>(context, listen: false)
                        .setSelectedTheme(ThemeMode.dark);
                  },
                ),
                MaterialButton(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Text('Light'),
                  onPressed: () {
                    Provider.of<ThemeService>(context, listen: false)
                        .setSelectedTheme(ThemeMode.light);
                  },
                ),
                MaterialButton(
                  child: const Text('System'),
                  onPressed: () {
                    Provider.of<ThemeService>(context, listen: false)
                        .setSelectedTheme(ThemeMode.system);
                  },
                ),
                Text(Provider.of<ThemeService>(context).currentThemeMode.name),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String test = "signout";
              Provider.of<AuthService>(context, listen: false).signOut();
              print(test);
            },
            child: const Text("Sign out"),
          ),
        ],
      ),
    );
    */
  }
}
