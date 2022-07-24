import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class DesktopPlayer extends ConsumerWidget {
  const DesktopPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);
    return Container(
      color: Colors.cyan,
      child: Column(
        children: [
          Row(
            children: [
              Text(player.currentPodcast),
              const Text(" - "),
              Text(player.currentEpisode),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.green,
                    thumbColor: Colors.red,
                  ),
                  child: Slider(
                    min: 0.0,
                    max: player.duration.inSeconds.toDouble(),
                    value: player.position.inSeconds.toDouble(),
                    onChanged: (double v) {
                      ref.read(playbackProvider.notifier).seek(v.toInt());
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(children: [
            IconButton(
              onPressed: () {
                ref.read(playbackProvider.notifier).play();
              },
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {
                ref.read(playbackProvider.notifier).pause();
              },
              icon: const Icon(Icons.pause_circle),
            ),
            Text(player.isPlaying.toString()),
            Text(player.duration.toString()),
            Text(player.position.toString()),
            Expanded(
              child: Slider(
                min: 0.0,
                max: 1.0,
                value: player.volume,
                onChanged: (double v) {
                  ref.read(playbackProvider.notifier).setVolume(v);
                },
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
