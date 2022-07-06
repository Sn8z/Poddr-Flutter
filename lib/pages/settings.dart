import 'package:flutter/material.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/services/auth_service.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Header(),
          Expanded(
            child: Column(
              children: [
                Text("Settings"),
                Consumer<AuthService>(builder: (context, user, child) {
                  return Text('Username: ${user.fbUser?.email}');
                })
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
