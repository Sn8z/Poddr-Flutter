import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class DesktopPlayer extends ConsumerWidget {
  const DesktopPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);

    return Container(
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              player.isPlaying
                  ? IconButton(
                      onPressed: () {
                        ref.read(playbackProvider.notifier).pause();
                      },
                      icon: const Icon(Icons.pause_circle),
                    )
                  : IconButton(
                      onPressed: () {
                        ref.read(playbackProvider.notifier).play();
                      },
                      icon: const Icon(Icons.play_arrow),
                    ),
              Visibility(
                  visible: player.isLoading,
                  child: CircularProgressIndicator()),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(player.position.toString()),
                  Slider(
                    min: 0.0,
                    max: player.duration.inSeconds.toDouble(),
                    value: player.position.inSeconds.toDouble(),
                    onChanged: (double v) {
                      ref.read(playbackProvider.notifier).seek(v.toInt());
                    },
                  ),
                  Text(player.duration.toString()),
                ],
              ),
              Text(player.currentPodcast),
              Text(player.currentEpisode),
            ],
          ),
          Column(
            children: [
              Slider(
                min: 0.0,
                max: 1.0,
                value: player.volume,
                onChanged: (double v) {
                  ref.read(playbackProvider.notifier).setVolume(v);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
