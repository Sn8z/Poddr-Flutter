import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class PositionTimer extends ConsumerWidget {
  const PositionTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerPosition =
        ref.watch(playbackProvider.select((value) => value.getPosition()));
    return Text(
      playerPosition,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
    );
  }
}
