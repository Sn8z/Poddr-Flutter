import 'package:flutter/material.dart';
import 'package:poddr/components/header.dart';
import 'package:go_router/go_router.dart';

class ToplistPage extends StatelessWidget {
  const ToplistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: Column(
              children: [
                const Text("Toplists"),
                Text(GoRouter.of(context).location),
              ],
            ),
          )
        ],
      ),
    );
  }
}
