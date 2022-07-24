import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/header.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/services/auth_service.dart';

class ToplistPage extends ConsumerWidget {
  const ToplistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(userProvider);

    return Container(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: Column(
              children: [
                const Text("Toplists"),
                Text(GoRouter.of(context).location),
                authState.when(
                  data: (user) {
                    if (user != null) {
                      return Text('Logged in as ${user.uid}');
                    } else {
                      return Text('Logged out');
                    }
                  },
                  error: (error, stack) {
                    return Text('error');
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
