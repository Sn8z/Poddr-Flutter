import 'package:flutter/material.dart';
import 'package:poddr/components/header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Header(),
          Expanded(
            child: Text("Settings"),
          )
        ],
      ),
    );
  }
}
