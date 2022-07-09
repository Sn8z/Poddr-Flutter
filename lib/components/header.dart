import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/services/auth_service.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 80,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        boxShadow: const [
          BoxShadow(
            offset: Offset(10, 0),
            blurRadius: 12.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Headline",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}
