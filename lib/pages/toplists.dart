import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';

class ToplistPage extends ConsumerWidget {
  const ToplistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseWidget(
      child: Column(
        children: [
          const Header(
            title: 'Charts',
          ),
          Column(
            children: [
              Text("Toplists"),
            ],
          ),
        ],
      ),
    );
  }
}
