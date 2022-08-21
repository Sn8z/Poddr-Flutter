import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class DurationTimer extends ConsumerWidget {
  const DurationTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerDuration =
        ref.watch(playbackProvider.select((value) => value.getDuration()));
    return Text(
      playerDuration,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
