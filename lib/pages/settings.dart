import 'package:flutter/material.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/services/auth_service.dart';
import 'package:poddr/services/theme_service.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}
