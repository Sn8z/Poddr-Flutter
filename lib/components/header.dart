import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/services/auth_service.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.title}) : super(key: key);

  final String title;

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
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 30, 30, 30),
        boxShadow: [
          BoxShadow(
            offset: Offset(10, 0),
            blurRadius: 12.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
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
