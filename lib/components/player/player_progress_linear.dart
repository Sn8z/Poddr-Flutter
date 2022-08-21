import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class PlayerProgressLinear extends ConsumerWidget {
  const PlayerProgressLinear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerPosition =
        ref.watch(playbackProvider.select((value) => value.position));
    final playerDuration =
        ref.watch(playbackProvider.select((value) => value.duration));
    double playerProgress =
        playerPosition.inSeconds.toInt() / playerDuration.inSeconds.toInt();
    playerProgress = playerProgress.isNaN ? 0.0 : playerProgress;
    return LinearProgressIndicator(
      value: playerProgress,
    );
  }
}
