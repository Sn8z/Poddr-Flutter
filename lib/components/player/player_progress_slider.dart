import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class PlayerProgressSlider extends ConsumerWidget {
  const PlayerProgressSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);
    return Slider(
      min: 0.0,
      max: player.duration.inSeconds.toDouble(),
      value: player.position.inSeconds.toDouble(),
      onChangeStart: (_) {
        ref.read(playbackProvider.notifier).pause();
      },
      onChangeEnd: (_) {
        ref.read(playbackProvider.notifier).play();
      },
      onChanged: (double v) {
        ref.read(playbackProvider.notifier).seek(v.toInt());
      },
    );
  }
}
