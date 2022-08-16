import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/auth_service.dart';

class UserInfoCard extends ConsumerWidget {
  const UserInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<User?> user = ref.watch(userProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user.when(
          data: (data) {
            if (data == null) {
              return const Text('Not logged in');
            } else {
              return Text(data.email ?? 'Email');
            }
          },
          error: (_, __) {
            return const Text('Error');
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
