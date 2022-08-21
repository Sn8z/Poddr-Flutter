import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class PlayerVolumeSlider extends ConsumerWidget {
  const PlayerVolumeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerVolume =
        ref.watch(playbackProvider.select((value) => value.volume));
    return Slider(
      min: 0.0,
      max: 1.0,
      value: playerVolume,
      onChanged: (double v) {
        debugPrint("Setting volume to $v");
        ref.read(playbackProvider.notifier).setVolume(v);
      },
    );
  }
}
