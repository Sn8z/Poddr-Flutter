import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class PlayerPlayButton extends ConsumerWidget {
  const PlayerPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying =
        ref.watch(playbackProvider.select((value) => value.isPlaying));
    return IconButton(
      iconSize: 52,
      onPressed: () {
        isPlaying
            ? ref.read(playbackProvider.notifier).pause()
            : ref.read(playbackProvider.notifier).play();
      },
      icon: Icon(
          isPlaying ? Icons.pause_circle_rounded : Icons.play_circle_rounded),
    );
  }
}
